# Get-IvantiWCNetworkDrive

Retrieves Ivanti Workspace Control network drive mappings from XML files.

## Syntax

```powershell
Get-IvantiWCNetworkDrive
    -XmlFilePath <String>
    [-DomainFqdn <String>]
    [-AsJson]
    [<CommonParameters>]

Get-IvantiWCNetworkDrive
    -XmlPath <String>
    [-DomainFqdn <String>]
    [-AsJson]
    [<CommonParameters>]
```

## Description

The `Get-IvantiWCNetworkDrive` function processes Ivanti Workspace Control XML building block file(s) and extracts network drive mapping settings, assignments, and metadata. Supports both single large XML files and directories containing multiple separate XML files.

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

Path to either a single XML file containing all network drive configurations, or a directory containing multiple XML files.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -DomainFqdn

Domain FQDN to append to non-FQDN SMB paths in network drive UNC paths.

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
Get-IvantiWCNetworkDrive -XmlFilePath "C:\Config\IvantiBB.xml" -DomainFqdn "domain.local"
```

Processes a single XML file using the legacy parameter and converts non-FQDN paths.

## Notes

- Use `-ExportFor AppVentiX` to include pre-structured output suitable for `Import-IvantiWCNetworkDrive` or `New-AppVentiXDriveMappingUserSetting`
- Specify `-DomainFqdn` to ensure UNC paths are fully qualified

## Related Links

- [Import-IvantiWCNetworkDrive](Import-IvantiWCNetworkDrive.md)
- [New-AppVentiXDriveMappingUserSetting](New-AppVentiXDriveMappingUserSetting.md)
- [Get-IvantiWCApplication](Get-IvantiWCApplication.md)
- [Get-IvantiWCEnvironmentVariable](Get-IvantiWCEnvironmentVariable.md)
