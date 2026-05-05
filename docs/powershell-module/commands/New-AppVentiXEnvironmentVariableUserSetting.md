# New-AppVentiXEnvironmentVariableUserSetting

Creates a new AppVentiX environment variable user setting XML file.

## Syntax

```powershell
# Parameter Set: EnvironmentVariables
New-AppVentiXEnvironmentVariableUserSetting
    -FriendlyName <String>
    [-Description <String>]
    [-ExecutionOrder <Int32>]
    [-ProcessAtLogin]
    [-ProcessAtRefresh]
    [-ProcessAtReconnectAndUnlock]
    [-MachineGroupFriendlyName <String>]
    -EnvironmentVariables <PSCustomObject[]>
    [<CommonParameters>]

# Parameter Set: InputObject
New-AppVentiXEnvironmentVariableUserSetting
    -InputObject <PSCustomObject>
    [<CommonParameters>]
```

## Description

The `New-AppVentiXEnvironmentVariableUserSetting` function creates a new AppVentiX user setting XML file that defines one or more environment variables for users. The function can be called with individual parameters or by passing a pre-constructed PSCustomObject via `InputObject`.

This function has the alias `New-AppVentiXEnvironmentVariable`.

## Parameters

### -FriendlyName

The display name for the environment variable user setting.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -Description

An optional description for the environment variable user setting.

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

When specified, the environment variables are processed at user login.

| | |
|---|---|
| Type: | SwitchParameter |
| Position: | Named |
| Default value: | False |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -ProcessAtRefresh

When specified, the environment variables are processed at refresh.

| | |
|---|---|
| Type: | SwitchParameter |
| Position: | Named |
| Default value: | False |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -ProcessAtReconnectAndUnlock

When specified, the environment variables are processed at reconnect and unlock.

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

### -EnvironmentVariables

An array of PSCustomObject items, each representing an environment variable to define. Each object should have Name and Value properties.

| | |
|---|---|
| Type: | PSCustomObject[] |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -InputObject

A PSCustomObject containing all environment variable properties. Used when piping output from `Get-IvantiWCEnvironmentVariable` or similar functions.

| | |
|---|---|
| Type: | PSCustomObject |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | True |
| Accept wildcard characters: | False |

## Examples

### Example 1: Create an environment variable setting

```powershell
$vars = @(
    [PSCustomObject]@{ Name = "APP_HOME"; Value = "C:\Apps\MyApp" },
    [PSCustomObject]@{ Name = "APP_CONFIG"; Value = "C:\Config\MyApp" }
)
New-AppVentiXEnvironmentVariableUserSetting -FriendlyName "MyApp Environment" -EnvironmentVariables $vars -ProcessAtLogin
```

Creates an environment variable user setting with two variables, processed at login.

## Notes

- Requires a valid AppVentiX license
- This function has the alias `New-AppVentiXEnvironmentVariable`

## Related Links

- [Get-IvantiWCEnvironmentVariable](Get-IvantiWCEnvironmentVariable.md)
- [Import-IvantiWCEnvironmentVariable](Import-IvantiWCEnvironmentVariable.md)
- [Set-AppVentiXUserSettingsAssignment](Set-AppVentiXUserSettingsAssignment.md)
- [Get-AppVentiXUserSettings](Get-AppVentiXUserSettings.md)
