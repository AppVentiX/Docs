# Get-IvantiWCPolicy

Reads, decodes, and correlates Ivanti Workspace Control policy sets from a Building Block XML file.

## Syntax

```powershell
Get-IvantiWCPolicy
    -Path <String>
    [-IncludeADMFiles]
    [-ExportFor <String>]
    [-IncludePolicyDescription]
    [<CommonParameters>]

Get-IvantiWCPolicy
    -Path <String>
    [-IncludeADMFiles]
    [-ExportFor <String>]
    [-IncludePolicyDescription]
    -SaveResourceFiles
    -ExportPath <String>
    [<CommonParameters>]
```

## Description

The `Get-IvantiWCPolicy` function reads an Ivanti Workspace Control Building Block XML file, pre-loads all embedded ADMX/ADML templates, and processes each policy set found within the file. For each policy set it correlates the applied registry settings with their ADMX definitions (via `Get-AdmxPolicySetting`) and returns a structured PowerShell object per policy set.

Supports two export modes via `-ExportFor`:
- **WEM**: returns correlated policy data only (default)
- **AppVentiX**: additionally returns an AppVentiXParams property containing pre-structured policy data ready to pass directly to `New-AppVentiXGroupPolicyUserSetting -PolicyInputObject`

Policy state (Enabled/Disabled/Unconfigured) is determined in priority order:
1. POLICY:1/2 indicator from the embedded PolicySettings data
2. Policy-level registry value compared against ADMX enabledValue/disabledValue
3. Presence of element-level registry values (implies Enabled)

List-type ADMX elements and Boolean elements with explicit trueValue/falseValue nodes are fully supported.

## Parameters

### -Path

Path to the Ivanti Workspace Control Building Block XML file.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -IncludeADMFiles

When specified, includes the ADMX and ADML filenames and their base64-encoded content in the output for each policy set. Required when piping output to `New-AppVentiXGroupPolicyUserSetting`.

| | |
|---|---|
| Type: | SwitchParameter |
| Position: | Named |
| Default value: | False |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -ExportFor

Target export format. 'AppVentiX' adds the AppVentiXParams property to each output object. Defaults to 'WEM'.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | WEM |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -IncludePolicyDescription

When specified, includes the ADMX ExplainText (policy description) in the PolicySettings output.

| | |
|---|---|
| Type: | SwitchParameter |
| Position: | Named |
| Default value: | False |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -SaveResourceFiles

When specified, saves the decoded ADMX/ADML files and the raw PolicySettings/RegistryFile data to disk at the path specified by -ExportPath.

| | |
|---|---|
| Type: | SwitchParameter |
| Position: | Named |
| Default value: | False |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -ExportPath

Directory path where decoded resource files are saved when -SaveResourceFiles is used.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

## Examples

### Example 1: Export policy data for use with AppVentiX

```powershell
$Policies = Get-IvantiWCPolicy -Path 'C:\temp\IvantiBB.xml' -IncludeADMFiles -ExportFor AppVentiX
$result = $Policies | ForEach-Object {
    New-AppVentiXGroupPolicyUserSetting `
        -FriendlyName       $_.Name `
        -AdmxContent        $_.ADMXContent `
        -AdmxFileName       $_.ADMX `
        -AdmlContent        $_.ADMLContent `
        -AdmlFileName       $_.ADML `
        -PolicyInputObject  $_.AppVentiXParams
}
```

Reads policy data from an Ivanti Building Block and creates corresponding AppVentiX Group Policy user settings.

### Example 2: Inspect correlated policy data as JSON

```powershell
Get-IvantiWCPolicy -Path 'C:\temp\IvantiBB.xml' | ConvertTo-Json -Depth 5
```

Inspects the correlated policy data in JSON format.

### Example 3: Save decoded resource files for inspection

```powershell
Get-IvantiWCPolicy -Path 'C:\temp\IvantiBB.xml' -SaveResourceFiles -ExportPath 'C:\temp\TempPolicy'
```

Saves the decoded ADMX/ADML and registry files to disk for manual inspection.

## Notes

- The Building Block XML must contain embedded ADMX/ADML templates for policy correlation to work
- Use `-IncludeADMFiles` when the output will be used with `New-AppVentiXGroupPolicyUserSetting` or `Import-IvantiWCPolicy`

## Related Links

- [Import-IvantiWCPolicy](Import-IvantiWCPolicy.md)
- [New-AppVentiXGroupPolicyUserSetting](New-AppVentiXGroupPolicyUserSetting.md)
- [Get-AdmxPolicySetting](Get-AdmxPolicySetting.md)
- [Get-IvantiWCRegistry](Get-IvantiWCRegistry.md)
