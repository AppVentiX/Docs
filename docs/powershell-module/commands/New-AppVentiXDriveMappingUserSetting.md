# New-AppVentiXDriveMappingUserSetting

Creates a new AppVentiX drive mapping user setting XML file.

## Syntax

```powershell
# Parameter Set: DriveMapping
New-AppVentiXDriveMappingUserSetting
    -FriendlyName <String>
    [-Description <String>]
    [-ExecutionOrder <Int32>]
    [-ProcessAtLogin]
    [-ProcessAtRefresh]
    [-ProcessAtReconnectAndUnlock]
    [-MachineGroupFriendlyName <String>]
    -DriveLetter <String>
    -NetworkPath <String>
    [-ConnectAtLogon]
    [-Label <String>]
    [-DoNotExecute]
    [-HideDrive]
    [<CommonParameters>]

# Parameter Set: InputObject
New-AppVentiXDriveMappingUserSetting
    -InputObject <PSCustomObject>
    [<CommonParameters>]
```

## Description

The `New-AppVentiXDriveMappingUserSetting` function creates a new AppVentiX user setting XML file that maps a network drive for users. The function can be called with individual parameters or by passing a pre-constructed PSCustomObject via `InputObject`.

This function has the alias `New-AppVentiXDriveMapping`.

## Parameters

### -FriendlyName

The display name for the drive mapping user setting.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -Description

An optional description for the drive mapping user setting.

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

When specified, the drive mapping is processed at user login.

| | |
|---|---|
| Type: | SwitchParameter |
| Position: | Named |
| Default value: | False |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -ProcessAtRefresh

When specified, the drive mapping is processed at refresh.

| | |
|---|---|
| Type: | SwitchParameter |
| Position: | Named |
| Default value: | False |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -ProcessAtReconnectAndUnlock

When specified, the drive mapping is processed at reconnect and unlock.

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

### -DriveLetter

The drive letter to assign (e.g., 'H', 'Z').

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -NetworkPath

The UNC path to the network share to map (e.g., `\\server\share`).

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -ConnectAtLogon

When specified, the drive is connected at logon.

| | |
|---|---|
| Type: | SwitchParameter |
| Position: | Named |
| Default value: | False |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -Label

An optional label to display for the mapped drive.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -DoNotExecute

When specified, the drive mapping is defined but not executed.

| | |
|---|---|
| Type: | SwitchParameter |
| Position: | Named |
| Default value: | False |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -HideDrive

When specified, the mapped drive is hidden from the user.

| | |
|---|---|
| Type: | SwitchParameter |
| Position: | Named |
| Default value: | False |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -InputObject

A PSCustomObject containing all drive mapping properties. Used when piping output from `Get-IvantiWCNetworkDrive` or similar functions.

| | |
|---|---|
| Type: | PSCustomObject |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | True |
| Accept wildcard characters: | False |

## Examples

### Example 1: Create a basic drive mapping

```powershell
New-AppVentiXDriveMappingUserSetting -FriendlyName "Home Drive" -DriveLetter "H" -NetworkPath "\\fileserver\users\%username%" -ProcessAtLogin
```

Creates a drive mapping user setting that maps the H: drive to the user's home folder at login.

### Example 2: Create a drive mapping with full options

```powershell
New-AppVentiXDriveMappingUserSetting -FriendlyName "Shared Data" -Description "Department shared data" -DriveLetter "S" -NetworkPath "\\fileserver\shared" -Label "Shared" -ConnectAtLogon -ProcessAtLogin -ProcessAtRefresh -MachineGroupFriendlyName "Production"
```

Creates a fully configured drive mapping for the Production machine group.

## Notes

- Requires a valid AppVentiX license
- This function has the alias `New-AppVentiXDriveMapping`

## Related Links

- [Get-IvantiWCNetworkDrive](Get-IvantiWCNetworkDrive.md)
- [Import-IvantiWCNetworkDrive](Import-IvantiWCNetworkDrive.md)
- [Set-AppVentiXUserSettingsAssignment](Set-AppVentiXUserSettingsAssignment.md)
- [Get-AppVentiXUserSettings](Get-AppVentiXUserSettings.md)
