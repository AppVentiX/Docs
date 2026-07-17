<#
.SYNOPSIS
    Builds the site, indexes it with Pagefind, and serves the static output.

.DESCRIPTION
    `mkdocs serve` live-reloads from an in-memory build that Pagefind cannot
    index, so search is unavailable there. This script runs a full
    `mkdocs build`, indexes the result with Pagefind, and serves the static
    `site/` folder instead. There is no live reload - re-run this script
    after making content changes to see them, and to keep the search index
    up to date.

.PARAMETER Port
    Port to serve the site on. Defaults to 8000.
#>
param(
    [int]$Port = 8000
)

$ErrorActionPreference = "Stop"
$repoRoot = Split-Path -Parent $PSScriptRoot

Push-Location $repoRoot
try {
    Write-Host "Building site..." -ForegroundColor Cyan
    python -m mkdocs build --clean
    if ($LASTEXITCODE -ne 0) { throw "mkdocs build failed" }

    Write-Host "Indexing with Pagefind..." -ForegroundColor Cyan
    npx --yes pagefind --site site
    if ($LASTEXITCODE -ne 0) { throw "pagefind indexing failed" }

    Write-Host "Serving site/ at http://127.0.0.1:$Port (Ctrl+C to stop, no live reload)" -ForegroundColor Green
    python -m http.server $Port --directory site
}
finally {
    Pop-Location
}
