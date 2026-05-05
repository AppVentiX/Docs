# New-AppVentiXRegistryUserSetting

Creates a new AppVentiX registry user setting XML file.

## Syntax

```powershell
# Parameter Set: RegistryEntries
New-AppVentiXRegistryUserSetting
    -FriendlyName <String>
    [-Description <String>]
    [-ExecutionOrder <Int32>]
    [-ProcessAtLogin]
    [-ProcessAtRefresh]
    [-ProcessAtReconnectAndUnlock]
    [-MachineGroupFriendlyName <String>]
    -RegistryEntries <PSCustomObject[]>
    [<CommonParameters>]

# Parameter Set: InputObject
New-AppVentiXRegistryUserSetting
    -InputObject <PSCustomObject>
    [<CommonParameters>]
```

## Description

The `New-AppVentiXRegistryUserSetting` function creates a new AppVentiX user setting XML file that applies one or more registry entries for users. The function can be called with individual parameters or by passing a pre-constructed PSCustomObject via `InputObject`.

This function has the alias `New-AppVentiXRegistry`.

## Parameters

### -FriendlyName

The display name for the registry user setting.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -Description

An optional description for the registry user setting.

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

When specified, the registry entries are processed at user login.

| | |
|---|---|
| Type: | SwitchParameter |
| Position: | Named |
| Default value: | False |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -ProcessAtRefresh

When specified, the registry entries are processed at refresh.

| | |
|---|---|
| Type: | SwitchParameter |
| Position: | Named |
| Default value: | False |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -ProcessAtReconnectAndUnlock

When specified, the registry entries are processed at reconnect and unlock.

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

### -RegistryEntries

An array of PSCustomObject items, each representing a registry entry to apply. Each object should describe the registry key path, value name, value data, and value type.

| | |
|---|---|
| Type: | PSCustomObject[] |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -InputObject

A PSCustomObject containing all registry setting properties. Used when piping output from `Get-IvantiWCRegistry` or similar functions.

| | |
|---|---|
| Type: | PSCustomObject |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | True |
| Accept wildcard characters: | False |

## Examples

### Example 1: Create a registry user setting

```powershell
$entries = @(
    [PSCustomObject]@{ Key = "HKCU\Software\MyApp"; ValueName = "Setting1"; ValueData = "1"; ValueType = "DWORD" }
)
New-AppVentiXRegistryUserSetting -FriendlyName "MyApp Registry Settings" -RegistryEntries $entries -ProcessAtLogin
```

Creates a registry user setting that applies a DWORD value at user login.

## Notes

- Requires a valid AppVentiX license
- This function has the alias `New-AppVentiXRegistry`

## Related Links

- [Get-IvantiWCRegistry](Get-IvantiWCRegistry.md)
- [Import-IvantiWCRegistry](Import-IvantiWCRegistry.md)
- [Set-AppVentiXUserSettingsAssignment](Set-AppVentiXUserSettingsAssignment.md)
- [Get-AppVentiXUserSettings](Get-AppVentiXUserSettings.md)
