# Get-IvantiWCEnvironmentVariable

Retrieves Ivanti Workspace Control variable configurations from XML files.

## Syntax

```powershell
Get-IvantiWCEnvironmentVariable
    -XmlFilePath <String>
    [-DomainFqdn <String>]
    [-AsJson]
    [<CommonParameters>]

Get-IvantiWCEnvironmentVariable
    -XmlPath <String>
    [-DomainFqdn <String>]
    [-AsJson]
    [<CommonParameters>]
```

## Description

The `Get-IvantiWCEnvironmentVariable` function processes Ivanti Workspace Control XML building block file(s) and extracts variable (environment variable) settings, assignments, and metadata. Supports both single large XML files and directories containing multiple separate XML files.

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

Path to either a single XML file containing all variable configurations, or a directory containing multiple XML files.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -DomainFqdn

Domain FQDN to append to non-FQDN SMB paths found in environment variable values.

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
Get-IvantiWCEnvironmentVariable -XmlFilePath "C:\Config\IvantiBB.xml"
```

Processes a single XML file using the legacy parameter.

## Notes

- Use `-ExportFor AppVentiX` to include pre-structured output suitable for `Import-IvantiWCEnvironmentVariable` or `New-AppVentiXEnvironmentVariableUserSetting`

## Related Links

- [Import-IvantiWCEnvironmentVariable](Import-IvantiWCEnvironmentVariable.md)
- [New-AppVentiXEnvironmentVariableUserSetting](New-AppVentiXEnvironmentVariableUserSetting.md)
- [Get-IvantiWCApplication](Get-IvantiWCApplication.md)
- [Get-IvantiWCNetworkDrive](Get-IvantiWCNetworkDrive.md)
