# New-AppVentiXShortcutUserSetting

Creates a new AppVentiX shortcut user setting XML file.

## Syntax

```powershell
# Parameter Set: ShortcutEntries
New-AppVentiXShortcutUserSetting
    -FriendlyName <String>
    [-Description <String>]
    [-ExecutionOrder <Int32>]
    [-ProcessAtLogin]
    [-ProcessAtRefresh]
    [-ProcessAtReconnectAndUnlock]
    [-MachineGroupFriendlyName <String>]
    -ShortcutEntries <PSCustomObject[]>
    [-IconFile <String>]
    [<CommonParameters>]

# Parameter Set: InputObject
New-AppVentiXShortcutUserSetting
    -InputObject <PSCustomObject>
    [<CommonParameters>]
```

## Description

The `New-AppVentiXShortcutUserSetting` function creates a new AppVentiX user setting XML file that defines one or more desktop or Start Menu shortcuts for users. The function can be called with individual parameters or by passing a pre-constructed PSCustomObject via `InputObject`.

This function has the alias `New-AppVentiXShortcut`.

## Parameters

### -FriendlyName

The display name for the shortcut user setting.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -Description

An optional description for the shortcut user setting.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -ExecutionOrder

The execution order for this user setting relative to others.

| | |
|---|---|
| Type: | Int32 |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -ProcessAtLogin

When specified, the shortcuts are processed at user login.

| | |
|---|---|
| Type: | SwitchParameter |
| Position: | Named |
| Default value: | False |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -ProcessAtRefresh

When specified, the shortcuts are processed at refresh.

| | |
|---|---|
| Type: | SwitchParameter |
| Position: | Named |
| Default value: | False |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -ProcessAtReconnectAndUnlock

When specified, the shortcuts are processed at reconnect and unlock.

| | |
|---|---|
| Type: | SwitchParameter |
| Position: | Named |
| Default value: | False |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -MachineGroupFriendlyName

The friendly name of the machine group to associate with this user setting.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | All Machine Groups |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -ShortcutEntries

An array of PSCustomObject items, each representing a shortcut to create. Each object should describe the shortcut target, name, location, and other properties.

| | |
|---|---|
| Type: | PSCustomObject[] |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -IconFile

The path to a custom icon file (.ico) to use for the shortcuts.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -InputObject

A PSCustomObject containing all shortcut properties. Used when piping output from `Get-IvantiWCApplication` or similar functions.

| | |
|---|---|
| Type: | PSCustomObject |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | True |
| Accept wildcard characters: | False |

## Examples

### Example 1: Create a shortcut user setting

```powershell
$shortcuts = @(
    [PSCustomObject]@{
        Name = "My Application"
        Target = "C:\Program Files\MyApp\MyApp.exe"
        Location = "Desktop"
        WorkingDirectory = "C:\Program Files\MyApp"
    }
)
New-AppVentiXShortcutUserSetting -FriendlyName "MyApp Shortcuts" -ShortcutEntries $shortcuts -ProcessAtLogin
```

Creates a shortcut user setting that places a desktop shortcut at user login.

## Notes

- Requires a valid AppVentiX license
- This function has the alias `New-AppVentiXShortcut`

## Related Links

- [Get-IvantiWCApplication](Get-IvantiWCApplication.md)
- [Import-IvantiWCShortcut](Import-IvantiWCShortcut.md)
- [Set-AppVentiXUserSettingsAssignment](Set-AppVentiXUserSettingsAssignment.md)
- [Get-AppVentiXUserSettings](Get-AppVentiXUserSettings.md)
