# Import-IvantiWCEnvironmentVariable

Imports environment variables from Ivanti Workspace Control XML configuration into AppVentiX.

## Syntax

```powershell
Import-IvantiWCEnvironmentVariable
    -XmlFilePath <String>
    [-DomainFqdn <String>]
    [-MachineGroupFriendlyName <String>]
    [-GUI]
    [<CommonParameters>]
```

## Description

The `Import-IvantiWCEnvironmentVariable` function extracts environment variable definitions from an Ivanti Workspace Control XML file and creates corresponding AppVentiX UserSetting XML files. It processes Active Directory group assignments and places imported items in the 'Migrated User Settings' folder.

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

FQDN to append to non-FQDN SMB paths in environment variable values.

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

When specified, displays a graphical selection grid for interactive selection of which environment variables to import.

| | |
|---|---|
| Type: | SwitchParameter |
| Position: | Named |
| Default value: | False |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

## Examples

### Example 1: Import all environment variables

```powershell
Import-IvantiWCEnvironmentVariable -XmlFilePath "C:\Config\IvantiBB.xml"
```

Imports all environment variables from the Ivanti XML file into AppVentiX.

### Example 2: Import with GUI selection and specific machine group

```powershell
Import-IvantiWCEnvironmentVariable -XmlFilePath "C:\Config\IvantiBB.xml" -MachineGroupFriendlyName "Production" -GUI
```

Opens a GUI for selective import and assigns to the Production machine group.

## Notes

- Requires a valid AppVentiX license
- User-type assignments are skipped; only group assignments are processed
- Imported settings are automatically placed in the 'Migrated User Settings' folder

## Related Links

- [Get-IvantiWCEnvironmentVariable](Get-IvantiWCEnvironmentVariable.md)
- [New-AppVentiXEnvironmentVariableUserSetting](New-AppVentiXEnvironmentVariableUserSetting.md)
- [Import-IvantiWCNetworkDrive](Import-IvantiWCNetworkDrive.md)
- [Set-AppVentiXUserSettingsAssignment](Set-AppVentiXUserSettingsAssignment.md)
