# Get-AppVentiXUserSettings

Retrieves AppVentiX user settings from the configuration store.

## Syntax

```powershell
Get-AppVentiXUserSettings
    [-Setting <String>]
    [<CommonParameters>]
```

## Description

The `Get-AppVentiXUserSettings` function retrieves AppVentiX user settings (drive mappings, environment variables, printer mappings, etc.) from the configuration store. It reads all user setting XML files and returns them as structured objects. You can filter results by setting type using the `-Setting` parameter.

## Parameters

### -Setting

Specifies the type of user settings to retrieve. Valid values are: All, DriveMapping, EnvironmentVariables, PrinterMapping.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | All |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

## Examples

### Example 1: Retrieve all user settings

```powershell
Get-AppVentiXUserSettings
```

Retrieves all user settings from the configuration store.

### Example 2: Retrieve only drive mapping settings

```powershell
Get-AppVentiXUserSettings -Setting DriveMapping
```

Retrieves only drive mapping user settings.

### Example 3: Retrieve only printer mapping settings

```powershell
Get-AppVentiXUserSettings -Setting PrinterMapping
```

Retrieves only printer mapping user settings.

## Notes

- Requires a valid AppVentiX license
- Each returned object includes: Type, Id, Settings, FilePath, and FriendlyName properties

## Related Links

- [New-AppVentiXDriveMappingUserSetting](New-AppVentiXDriveMappingUserSetting.md)
- [New-AppVentiXEnvironmentVariableUserSetting](New-AppVentiXEnvironmentVariableUserSetting.md)
- [New-AppVentiXPrinterMappingUserSetting](New-AppVentiXPrinterMappingUserSetting.md)
- [Set-AppVentiXUserSettingsAssignment](Set-AppVentiXUserSettingsAssignment.md)
