# Get-IvantiWCRegistry

Reads and parses Ivanti Workspace Control registry sets from a Building Block XML file or a standalone .reg file.

## Syntax

```powershell
Get-IvantiWCRegistry
    -Path <String>
    [-ExportFor <String>]
    [<CommonParameters>]
```

## Description

The `Get-IvantiWCRegistry` function accepts either:
- An Ivanti Workspace Control Building Block XML file: extracts every `<registry type="registry">` node, decodes the hex-encoded registryfile, and parses it. Name and description are taken from the `<name>` and `<description>` XML elements.
- A standalone .reg file: parses it directly. Name and description are read from the `;<PFNAME>` and `;<PFDESC>` comment tags if present.

Each value entry is returned as a structured object with its registry hive, key, value name, value data, value type, and an optional per-value description.

Supports all standard .reg value types:
- REG_SZ, REG_EXPAND_SZ, REG_BINARY, REG_DWORD, REG_MULTI_SZ, REG_QWORD

## Parameters

### -Path

Path to an Ivanti Workspace Control Building Block XML file or a standalone .reg file.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None |
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

## Examples

### Example 1: Parse registry sets from a Building Block XML

```powershell
Get-IvantiWCRegistry -Path 'C:\temp\IvantiBB.xml'
```

Extracts and parses all registry sets from the Ivanti Building Block XML file.

### Example 2: Parse a standalone .reg file for AppVentiX export

```powershell
Get-IvantiWCRegistry -Path 'C:\temp\registry.reg' -ExportFor AppVentiX
```

Parses a standalone .reg file and includes AppVentiX-formatted output.

## Notes

- Per-value descriptions can be captured from `;<PF>...</PF>` comment tags in .reg files
- Use `-ExportFor AppVentiX` to include pre-structured output suitable for `Import-IvantiWCRegistry` or `New-AppVentiXRegistryUserSetting`

## Related Links

- [Import-IvantiWCRegistry](Import-IvantiWCRegistry.md)
- [New-AppVentiXRegistryUserSetting](New-AppVentiXRegistryUserSetting.md)
- [Get-IvantiWCPolicy](Get-IvantiWCPolicy.md)
