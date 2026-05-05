# Import-IvantiWCApplication

Imports application shortcuts from Ivanti Workspace Control XML configuration into AppVentiX.

## Syntax

```powershell
Import-IvantiWCApplication
    -XmlFilePath <String>
    [-MachineGroupFriendlyName <String>]
    [-GUI]
    [<CommonParameters>]
```

## Description

The `Import-IvantiWCApplication` function extracts application definitions from an Ivanti Workspace Control XML file and creates corresponding AppVentiX Shortcut UserSetting XML files. It processes Active Directory group assignments and places imported items in the 'Migrated User Settings' folder.

Uses `Get-IvantiWCApplication -ExportFor AppVentiX` as the data source. Icon data (base64) is included in the AppVentiXParams from the source function.

The function optionally presents a GUI for selective import, allowing you to choose which applications to migrate.

## Parameters

### -XmlFilePath

Path to the Ivanti Workspace Control XML building block file, or a directory containing multiple XML files (one per application).

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None |
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

When specified, displays a graphical selection grid for interactive selection of which applications to import.

| | |
|---|---|
| Type: | SwitchParameter |
| Position: | Named |
| Default value: | False |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

## Examples

### Example 1: Import all applications from an Ivanti XML file

```powershell
Import-IvantiWCApplication -XmlFilePath "C:\Config\IvantiBB.xml"
```

Imports all application shortcuts from the Ivanti XML file into AppVentiX with default settings.

### Example 2: Import applications for a specific machine group with GUI selection

```powershell
Import-IvantiWCApplication -XmlFilePath "C:\Config\IvantiBB.xml" -MachineGroupFriendlyName "Test" -GUI
```

Opens a GUI for selective import and assigns the imported applications to the Test machine group.

## Notes

- Requires a valid AppVentiX license
- User-type assignments are skipped; only group assignments are processed
- Imported settings are automatically placed in the 'Migrated User Settings' folder

## Related Links

- [Get-IvantiWCApplication](Get-IvantiWCApplication.md)
- [Import-IvantiWCShortcut](Import-IvantiWCShortcut.md)
- [New-AppVentiXShortcutUserSetting](New-AppVentiXShortcutUserSetting.md)
- [Set-AppVentiXUserSettingsAssignment](Set-AppVentiXUserSettingsAssignment.md)
