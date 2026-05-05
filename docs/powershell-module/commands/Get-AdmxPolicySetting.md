# Get-AdmxPolicySetting

Retrieves Group Policy setting details from ADMX/ADML files matching a registry key path and value name.

## Syntax

```powershell
Get-AdmxPolicySetting
    -AdmxPath <String>
    [-Recurse]
    [-RegistryKey <String>]
    [-ValueName <String>]
    [-All]
    [<CommonParameters>]

Get-AdmxPolicySetting
    -AdmxFilePath <String>
    [-AdmlFilePath <String>]
    [-RegistryKey <String>]
    [-ValueName <String>]
    [-All]
    [<CommonParameters>]

Get-AdmxPolicySetting
    -AdmxContent <String>
    [-AdmlContent <String>]
    [-AdmxFileName <String>]
    [-AdmlFileName <String>]
    [-RegistryKey <String>]
    [-ValueName <String>]
    [-All]
    [<CommonParameters>]
```

## Description

The `Get-AdmxPolicySetting` function parses ADMX files to find policy settings matching a given registry key and value name. It returns registry type, element type, policy metadata, and display strings resolved from the corresponding ADML file.

Supports three parameter sets:
- **Path**: Provide a path to an ADMX file or directory containing ADMX files.
- **XmlFile**: Provide file paths to ADMX and optionally ADML files as strings.
- **XmlContent**: Provide raw XML content strings for ADMX and optionally ADML.

Use `-All` to return every policy in the file(s) without filtering. Otherwise, both `-RegistryKey` and `-ValueName` are required.

ADML auto-detection order (Path and XmlFile sets):
1. Subfolder matching the current UI culture (e.g., en-GB) in the ADMX directory.
2. Fallback to en-US subfolder.
3. Any available language subfolder found.

## Parameters

### -AdmxPath

Path to a single ADMX file or a directory containing ADMX files.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -Recurse

When AdmxPath is a directory, recurse into subdirectories to find ADMX files.

| | |
|---|---|
| Type: | SwitchParameter |
| Position: | Named |
| Default value: | False |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -AdmxFilePath

File path to a single ADMX file. Used with the XmlFile parameter set.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -AdmlFilePath

File path to a single ADML file. Optional; if omitted, auto-detection is attempted relative to the ADMX file location.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -AdmxContent

Raw XML string content of the ADMX file. Used with the XmlContent parameter set.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -AdmlContent

Raw XML string content of the ADML file. Optional when using the XmlContent parameter set.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -AdmxFileName

Optional filename hint for the ADMX source when using the XmlContent parameter set (e.g. 'ControlPanel.admx').

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -AdmlFileName

Optional filename hint for the ADML source when using the XmlContent parameter set (e.g. 'ControlPanel.adml').

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -All

Return all policy settings from the ADMX file(s) without filtering by registry key or value name. When specified, -RegistryKey and -ValueName are not required.

| | |
|---|---|
| Type: | SwitchParameter |
| Position: | Named |
| Default value: | False |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -RegistryKey

The registry key path to match (e.g., 'SOFTWARE\Policies\Microsoft\Edge'). HKLM/HKCU prefixes are stripped automatically.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -ValueName

The registry value name to match.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

## Examples

### Example 1: Search a directory for a specific registry setting

```powershell
Get-AdmxPolicySetting -AdmxPath 'C:\Windows\PolicyDefinitions' `
    -RegistryKey 'SOFTWARE\Policies\Microsoft\Edge' `
    -ValueName 'HomepageIsNewTabPage' -Recurse
```

Searches all ADMX files in the PolicyDefinitions directory for the specified registry setting.

### Example 2: Search a specific ADMX/ADML file pair

```powershell
Get-AdmxPolicySetting -AdmxFilePath 'C:\PolicyDefs\msedge.admx' `
    -AdmlFilePath 'C:\PolicyDefs\en-US\msedge.adml' `
    -RegistryKey 'SOFTWARE\Policies\Microsoft\Edge' `
    -ValueName 'HomepageIsNewTabPage'
```

Searches a specific ADMX file with a specified ADML language file.

### Example 3: Search using raw XML content

```powershell
$admxXml = Get-Content 'C:\PolicyDefs\msedge.admx' -Raw
$admlXml = Get-Content 'C:\PolicyDefs\en-US\msedge.adml' -Raw
Get-AdmxPolicySetting -AdmxContent $admxXml -AdmlContent $admlXml `
    -RegistryKey 'SOFTWARE\Policies\Microsoft\Edge' `
    -ValueName 'HomepageIsNewTabPage'
```

Searches using raw XML content strings.

## Notes

- HKLM and HKCU prefixes in the RegistryKey are automatically stripped before matching
- List-type ADMX elements (values stored as numbered entries under a sub-key) are fully supported
- Boolean elements with explicit trueValue/falseValue nodes are resolved correctly

## Related Links

- [Get-IvantiWCPolicy](Get-IvantiWCPolicy.md)
- [New-AppVentiXGroupPolicyUserSetting](New-AppVentiXGroupPolicyUserSetting.md)
