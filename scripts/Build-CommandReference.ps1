#requires -Modules Microsoft.PowerShell.PlatyPS
<#
.SYNOPSIS
    Generates the AppVentiX PowerShell command-reference Markdown for this docs site.

.DESCRIPTION
    Runs manually, on demand, from within the docs repo. Imports the AppVentiX module
    from a sibling checkout (read-only), then for every EXPORTED command:

        module command (comment-based help)
            -> New-CommandHelp
            -> resolve category (override > pattern > fallback)
            -> Export-MarkdownCommandHelp -Metadata @{ category; category_title; module_version; Locale }
            -> docs/powershell-module/commands/<Command>.md

    The module version is read from the module manifest at generation time and stamped
    into each page's front matter. The site navigation is built from the 'category'
    front matter at 'mkdocs build' time (see scripts/gen_nav.py) -- this script does
    not touch mkdocs.yml.

.NOTES
    Only commands returned by Get-Command -Module (i.e. actually exported via
    FunctionsToExport) are documented. If the module's public\ folder contains more
    .ps1 files than are exported, those are intentionally NOT documented here -- fix
    the export list in the module repo, not here.
#>
[CmdletBinding()]
param(
    # Path to the module manifest in the sibling module checkout.
    [string]$ModulePath = (Join-Path $PSScriptRoot '..\..\AppVentiX-Powershell-Module\AppVentiX\AppVentiX.psd1'),

    # Output goes straight into the docs tree.
    [string]$OutputRoot = (Join-Path $PSScriptRoot '..\docs\powershell-module\commands'),

    [string]$CategoryMap = (Join-Path $PSScriptRoot 'CommandCategories.psd1'),

    # Optional: restrict to a few commands while iterating.
    [string[]]$OnlyCommands = @()
)

$ErrorActionPreference = 'Stop'

if (-not (Test-Path $ModulePath)) {
    throw "Module manifest not found at '$ModulePath'. Point -ModulePath at your AppVentiX-Powershell-Module checkout."
}

$map = Import-PowerShellDataFile -Path $CategoryMap
$titleById = @{}
foreach ($c in $map.Categories) { $titleById[$c.Id] = $c.Title }

function Resolve-Category {
    param([string]$Name)
    if ($map.Overrides.ContainsKey($Name)) { return $map.Overrides[$Name] }
    foreach ($rule in $map.Patterns) { if ($Name -like $rule.Match) { return $rule.Category } }
    return 'uncategorized'
}

# Version comes from the manifest at generation time.
$manifest      = Import-PowerShellDataFile -Path $ModulePath
$moduleVersion = "$($manifest.ModuleVersion)"
$moduleName    = [System.IO.Path]::GetFileNameWithoutExtension($ModulePath)

Import-Module $ModulePath -Force

$commands = Get-Command -Module $moduleName -CommandType Function | Sort-Object Name
if ($OnlyCommands) { $commands = $commands | Where-Object { $_.Name -in $OnlyCommands } }

Write-Host "Documenting $($commands.Count) exported command(s) from $moduleName $moduleVersion" -ForegroundColor Cyan

# Set of documented command names, to turn '.LINK <Command>' into '<Command>.md'.
$documentedNames = [System.Collections.Generic.HashSet[string]]::new(
    [string[]]($commands.Name), [System.StringComparer]::OrdinalIgnoreCase)

# Export-MarkdownCommandHelp writes to <OutputFolder>\<ModuleName>\<Command>.md.
# We want them flat in the commands dir, so export to a temp folder then move.
$temp = Join-Path ([System.IO.Path]::GetTempPath()) ("avx-docs-" + [guid]::NewGuid().ToString('N'))
New-Item -ItemType Directory -Path $temp -Force | Out-Null

$uncategorized = [System.Collections.Generic.List[string]]::new()
$placeholders  = [System.Collections.Generic.List[string]]::new()

try {
    New-Item -ItemType Directory -Path $OutputRoot -Force | Out-Null

    foreach ($cmd in $commands) {
        $category = Resolve-Category -Name $cmd.Name
        if ($category -eq 'uncategorized') { $uncategorized.Add($cmd.Name) }

        $help = New-CommandHelp -CommandInfo $cmd
        $metadata = [ordered]@{
            category       = $category
            category_title = $titleById[$category]
            module_version = $moduleVersion
            Locale         = 'en-US'
        }
        Export-MarkdownCommandHelp -CommandHelp $help -OutputFolder $temp -Metadata $metadata -Force | Out-Null

        $src = Join-Path $temp (Join-Path $moduleName "$($cmd.Name).md")
        $dst = Join-Path $OutputRoot "$($cmd.Name).md"
        Move-Item -Path $src -Destination $dst -Force

        # Report ONLY real, help-fixable gaps: a parameter/example without a
        # description ('{{ Fill <Param> Description }}', '{{ Add example ... }}').
        # These are fixable in the module's comment-based help.
        $fixableGaps = Select-String -Path $dst -Pattern '\{\{\s*(Fill\s+\w+\s+Description|Add example)' -AllMatches
        if ($fixableGaps) {
            $count = ($fixableGaps.Matches | Measure-Object).Count
            $placeholders.Add(("{0} ({1})" -f $cmd.Name, $count))
        }

        $content = Get-Content -Path $dst -Raw

        # Strip placeholders that comment-based help CANNOT fill, so the published
        # page never shows raw '{{ ... }}':
        #   - '{{Insert list of aliases}}'      (no aliases)
        #   - '{{ Fill in the related links }}' (RELATED LINKS empty)
        #   - '{{ Fill in the Description }}'    (per-type INPUTS/OUTPUTS description)
        $content = $content `
            -replace '(?m)^\s*\{\{Insert list of aliases\}\}\s*$', '' `
            -replace '(?m)^\s*\{\{\s*Fill in the related links here\s*\}\}\s*$', '' `
            -replace '(?m)^\s*\{\{\s*Fill in the Description\s*\}\}\s*$', ''

        # Drop the '## NOTES' section entirely -- it's just the module's internal
        # Function/Author/Copyright/Version/Requires boilerplate from comment-based
        # help, not something readers of the public command reference need.
        $content = $content -replace '(?ms)^## NOTES\r?\n.*?(?=^## |\z)', ''

        # RELATED LINKS from '.LINK <Command>' render as '[Command]()' (empty target)
        # because the source only has a name, not a URL. Point them at the sibling
        # generated page. Only rewrite links to commands we actually document, so
        # 'mkdocs build --strict' never sees a link to a missing file. Any other
        # empty-target link is dropped (it would break the strict build).
        $content = [regex]::Replace($content, '\[([^\]]+)\]\(\)', {
            param($m)
            $name = $m.Groups[1].Value
            if ($documentedNames.Contains($name)) { "[$name]($name.md)" } else { $name }
        })

        Set-Content -Path $dst -Value $content -NoNewline
    }
} finally {
    Remove-Item $temp -Recurse -Force -ErrorAction SilentlyContinue
}

Write-Host "`nGenerated $($commands.Count) page(s) in $OutputRoot" -ForegroundColor Green

if ($uncategorized.Count) {
    Write-Warning "Uncategorized (add an override or pattern in CommandCategories.psd1):`n  $($uncategorized -join "`n  ")"
}
if ($placeholders.Count) {
    Write-Warning "Incomplete comment-based help - missing parameter/description text (fix in the module repo). Count in parentheses:`n  $($placeholders -join "`n  ")"
}

Write-Host "`nNext: run 'mkdocs build --strict' to regenerate the menu and validate links." -ForegroundColor Cyan
