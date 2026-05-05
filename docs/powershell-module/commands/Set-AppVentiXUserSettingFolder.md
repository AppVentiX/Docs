# Set-AppVentiXUserSettingFolder

Creates or retrieves an AppVentiX user setting folder.

## Syntax

```powershell
Set-AppVentiXUserSettingFolder
    [-FolderName <String>]
    [-Id <Guid>]
    [-PassThru]
    [<CommonParameters>]
```

## Description

The `Set-AppVentiXUserSettingFolder` function creates a new user setting folder in AppVentiX or retrieves an existing one by name or GUID. User setting folders are used to organize user settings such as drive mappings, environment variables, registry settings, shortcuts, printer mappings, and Group Policy settings.

## Parameters

### -FolderName

The name of the user setting folder to create or retrieve.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -Id

The GUID of an existing user setting folder to retrieve.

| | |
|---|---|
| Type: | Guid |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -PassThru

When specified, returns the folder object to the pipeline.

| | |
|---|---|
| Type: | SwitchParameter |
| Position: | Named |
| Default value: | False |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

## Examples

### Example 1: Create a new user setting folder

```powershell
Set-AppVentiXUserSettingFolder -FolderName "Migrated User Settings"
```

Creates a new user setting folder named 'Migrated User Settings'.

### Example 2: Create a folder and return the object

```powershell
$folder = Set-AppVentiXUserSettingFolder -FolderName "Production Settings" -PassThru
```

Creates the folder and returns the folder object for use in subsequent commands.

### Example 3: Retrieve an existing folder by GUID

```powershell
$folder = Set-AppVentiXUserSettingFolder -Id "12345678-1234-1234-1234-123456789012" -PassThru
```

Retrieves the user setting folder with the specified GUID.

## Notes

- Requires a valid AppVentiX license
- This function is commonly used before importing user settings to ensure the target folder exists

## Related Links

- [Get-AppVentiXUserSettings](Get-AppVentiXUserSettings.md)
- [Set-AppVentiXUserSettingsAssignment](Set-AppVentiXUserSettingsAssignment.md)
- [New-AppVentiXDriveMappingUserSetting](New-AppVentiXDriveMappingUserSetting.md)
- [New-AppVentiXEnvironmentVariableUserSetting](New-AppVentiXEnvironmentVariableUserSetting.md)
