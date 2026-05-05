# Get-IvantiWCApplication

Retrieves Ivanti Workspace Control application configurations from XML files.

## Syntax

```powershell
Get-IvantiWCApplication
    -XmlFilePath <String>
    [-AsJson]
    [<CommonParameters>]

Get-IvantiWCApplication
    -XmlPath <String>
    [-AsJson]
    [<CommonParameters>]
```

## Description

The `Get-IvantiWCApplication` function processes Ivanti Workspace Control XML building block file(s) and extracts application settings, assignments, and metadata. Supports both single large XML files and directories containing multiple separate XML files (one per application).

## Parameters

### -XmlFilePath

Path to a single Ivanti Workspace Control XML building block file. This is a legacy parameter maintained for backward compatibility. Use -XmlPath instead.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -XmlPath

Path to either a single XML file containing all application configurations, or a directory containing multiple XML files (one per application).

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -AsJson

When specified, outputs the results as JSON format instead of PowerShell objects.

| | |
|---|---|
| Type: | SwitchParameter |
| Position: | Named |
| Default value: | False |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

## Examples

### Example 1: Process a single XML file (legacy parameter)

```powershell
Get-IvantiWCApplication -XmlFilePath "C:\Config\IvantiBB.xml"
```

Processes a single XML file using the legacy parameter.

### Example 2: Process a single XML file

```powershell
Get-IvantiWCApplication -XmlPath "C:\Config\IvantiBB.xml"
```

Processes a single XML file containing all application configurations.

## Notes

- Use `-ExportFor AppVentiX` to include pre-structured output suitable for `Import-IvantiWCApplication` or `New-AppVentiXShortcutUserSetting`
- Icon data (base64) is included in the AppVentiXParams output when using `-ExportFor AppVentiX`

## Related Links

- [Import-IvantiWCApplication](Import-IvantiWCApplication.md)
- [Import-IvantiWCShortcut](Import-IvantiWCShortcut.md)
- [Get-IvantiWCEnvironmentVariable](Get-IvantiWCEnvironmentVariable.md)
- [Get-IvantiWCNetworkDrive](Get-IvantiWCNetworkDrive.md)
