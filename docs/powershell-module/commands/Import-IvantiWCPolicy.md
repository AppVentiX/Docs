# Import-IvantiWCPolicy

Imports Group Policy settings from Ivanti Workspace Control XML configuration into AppVentiX.

## Syntax

```powershell
Import-IvantiWCPolicy
    -XmlFilePath <String>
    [-MachineGroupFriendlyName <String>]
    [-GUI]
    [<CommonParameters>]
```

## Description

The `Import-IvantiWCPolicy` function extracts Group Policy definitions (including ADMX/ADML content) from an Ivanti Workspace Control XML file and creates corresponding AppVentiX UserSetting XML files. It processes Active Directory group assignments and places imported items in the 'Migrated User Settings' folder.

Uses `Get-IvantiWCPolicy -IncludeADMFiles -ExportFor AppVentiX` as the data source, which ensures that ADMX and ADML content is included for each policy. The function optionally presents a GUI for selective import.

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

When specified, displays a graphical selection grid for interactive selection of which policies to import.

| | |
|---|---|
| Type: | SwitchParameter |
| Position: | Named |
| Default value: | False |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

## Examples

### Example 1: Import all Group Policy settings

```powershell
Import-IvantiWCPolicy -XmlFilePath "C:\Config\IvantiBB.xml"
```

Imports all Group Policy settings from the Ivanti XML file into AppVentiX.

### Example 2: Import with GUI selection and specific machine group

```powershell
Import-IvantiWCPolicy -XmlFilePath "C:\Config\IvantiBB.xml" -MachineGroupFriendlyName "Production" -GUI
```

Opens a GUI for selective import and assigns policies to the Production machine group.

## Notes

- Requires a valid AppVentiX license
- User-type assignments are skipped; only group assignments are processed
- Imported settings are automatically placed in the 'Migrated User Settings' folder
- ADMX/ADML files are embedded in the AppVentiX user setting XML

## Related Links

- [Get-IvantiWCPolicy](Get-IvantiWCPolicy.md)
- [New-AppVentiXGroupPolicyUserSetting](New-AppVentiXGroupPolicyUserSetting.md)
- [Import-IvantiWCRegistry](Import-IvantiWCRegistry.md)
- [Set-AppVentiXUserSettingsAssignment](Set-AppVentiXUserSettingsAssignment.md)
