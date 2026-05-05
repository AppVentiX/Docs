# Import-IvantiWCPrinterMapping

Imports printer mappings from Ivanti Workspace Control XML configuration into AppVentiX.

## Syntax

```powershell
Import-IvantiWCPrinterMapping
    -XmlFilePath <String>
    [-DomainFqdn <String>]
    [-MachineGroupFriendlyName <String>]
    [-GUI]
    [<CommonParameters>]
```

## Description

The `Import-IvantiWCPrinterMapping` function extracts printer mapping definitions from an Ivanti Workspace Control XML file and creates corresponding AppVentiX UserSetting XML files. It processes Active Directory group assignments and places imported items in the 'Migrated User Settings' folder.

The function optionally presents a GUI for selective import.

## Parameters

### -XmlFilePath

Path to the Ivanti Workspace Control XML configuration file.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -DomainFqdn

FQDN to append to non-FQDN UNC printer paths.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | $Env:USERDNSDOMAIN |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -MachineGroupFriendlyName

Friendly name of the machine group to assign the imported settings to.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | All Machine Groups |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -GUI

When specified, displays a graphical selection grid for interactive selection of which printer mappings to import.

| | |
|---|---|
| Type: | SwitchParameter |
| Position: | Named |
| Default value: | False |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

## Examples

### Example 1: Import all printer mappings

```powershell
Import-IvantiWCPrinterMapping -XmlFilePath "C:\Config\IvantiBB.xml"
```

Imports all printer mappings from the Ivanti XML file into AppVentiX.

### Example 2: Import with domain FQDN and GUI selection

```powershell
Import-IvantiWCPrinterMapping -XmlFilePath "C:\Config\IvantiBB.xml" -DomainFqdn "domain.local" -GUI
```

Opens a GUI for selective import and ensures printer UNC paths are fully qualified.

## Notes

- Requires a valid AppVentiX license
- User-type assignments are skipped; only group assignments are processed
- Imported settings are automatically placed in the 'Migrated User Settings' folder

## Related Links

- [Get-IvantiWCPrinterMapping](Get-IvantiWCPrinterMapping.md)
- [New-AppVentiXPrinterMappingUserSetting](New-AppVentiXPrinterMappingUserSetting.md)
- [Import-IvantiWCNetworkDrive](Import-IvantiWCNetworkDrive.md)
- [Set-AppVentiXUserSettingsAssignment](Set-AppVentiXUserSettingsAssignment.md)
