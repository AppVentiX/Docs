# Get-IvantiWCPrinterMapping

Parses Ivanti Workspace Control XML file(s) to extract printer mappings.

## Syntax

```powershell
Get-IvantiWCPrinterMapping
    -XmlFilePath <String>
    [-DomainFqdn <String>]
    [-AsJson]
    [<CommonParameters>]

Get-IvantiWCPrinterMapping
    -XmlPath <String>
    [-DomainFqdn <String>]
    [-AsJson]
    [<CommonParameters>]
```

## Description

The `Get-IvantiWCPrinterMapping` function reads specified Ivanti Workspace Control XML export file(s), filters for printer mappings, and transforms the data into structured PowerShell objects or a single JSON string.

Supports both single large XML files and directories containing multiple separate XML files.

For each printer mapping it:
- Converts the printer's SMB path to a Fully Qualified Domain Name (FQDN) using the specified domain
- Determines if it is the default printer
- Extracts associated access control objects (users and groups)
- Collects metadata such as comments, location, and driver names

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

Path to either a single XML file containing all printer configurations, or a directory containing multiple XML files.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -DomainFqdn

Specifies the domain FQDN (e.g., 'corp.domain.com') to append to any printer SMB paths that are not already fully qualified.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -AsJson

When specified, the function collects all results and outputs them as a single, multi-line JSON string. Otherwise, it streams each printer mapping object to the pipeline.

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
Get-IvantiWCPrinterMapping -XmlFilePath "C:\IvantiConfig\IvantiBB.xml" -DomainFqdn "domain.local"
```

Processes the Printers.xml file using the legacy parameter.

### Example 3: Export printer mappings to JSON

```powershell
Get-IvantiWCPrinterMapping -XmlPath "C:\IvantiConfig\Printers.xml" -DomainFqdn "domain.local" -AsJson | Out-File -FilePath "C:\Output\printers.json"
```

Processes the XML file and outputs printer mappings as JSON to a file.

## Notes

- Duplicate printer GUIDs found in the Building Block are skipped with a warning
- Backup printer settings are not supported and will be ignored
- Use `-ExportFor AppVentiX` to include pre-structured output suitable for `Import-IvantiWCPrinterMapping` or `New-AppVentiXPrinterMappingUserSetting`

## Related Links

- [Import-IvantiWCPrinterMapping](Import-IvantiWCPrinterMapping.md)
- [New-AppVentiXPrinterMappingUserSetting](New-AppVentiXPrinterMappingUserSetting.md)
- [Get-IvantiWCApplication](Get-IvantiWCApplication.md)
- [Get-IvantiWCNetworkDrive](Get-IvantiWCNetworkDrive.md)
