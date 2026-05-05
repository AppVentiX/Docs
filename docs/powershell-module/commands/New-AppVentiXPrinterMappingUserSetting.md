# New-AppVentiXPrinterMappingUserSetting

Creates a new AppVentiX printer mapping user setting XML file.

## Syntax

```powershell
# Parameter Set: PrinterMapping
New-AppVentiXPrinterMappingUserSetting
    -FriendlyName <String>
    [-Description <String>]
    [-ExecutionOrder <Int32>]
    [-ProcessAtLogin]
    [-ProcessAtRefresh]
    [-ProcessAtReconnectAndUnlock]
    [-MachineGroupFriendlyName <String>]
    -PrinterPath <String>
    [-SetAsDefault]
    [<CommonParameters>]

# Parameter Set: InputObject
New-AppVentiXPrinterMappingUserSetting
    -InputObject <PSCustomObject>
    [<CommonParameters>]
```

## Description

The `New-AppVentiXPrinterMappingUserSetting` function creates a new AppVentiX user setting XML file that maps a network printer for users. The function can be called with individual parameters or by passing a pre-constructed PSCustomObject via `InputObject`.

This function has the alias `New-AppVentiXPrinterMapping`.

## Parameters

### -FriendlyName

The display name for the printer mapping user setting.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -Description

An optional description for the printer mapping user setting.

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

When specified, the printer mapping is processed at user login.

| | |
|---|---|
| Type: | SwitchParameter |
| Position: | Named |
| Default value: | False |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -ProcessAtRefresh

When specified, the printer mapping is processed at refresh.

| | |
|---|---|
| Type: | SwitchParameter |
| Position: | Named |
| Default value: | False |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -ProcessAtReconnectAndUnlock

When specified, the printer mapping is processed at reconnect and unlock.

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

### -PrinterPath

The UNC path to the network printer (e.g., `\\printserver\PrinterName`).

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -SetAsDefault

When specified, sets this printer as the user's default printer.

| | |
|---|---|
| Type: | SwitchParameter |
| Position: | Named |
| Default value: | False |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -InputObject

A PSCustomObject containing all printer mapping properties. Used when piping output from `Get-IvantiWCPrinterMapping` or similar functions.

| | |
|---|---|
| Type: | PSCustomObject |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | True |
| Accept wildcard characters: | False |

## Examples

### Example 1: Create a printer mapping

```powershell
New-AppVentiXPrinterMappingUserSetting -FriendlyName "Office Printer" -PrinterPath "\\printserver.domain.local\OfficePrinter" -ProcessAtLogin
```

Creates a printer mapping user setting for the Office Printer, processed at login.

### Example 2: Create a default printer mapping

```powershell
New-AppVentiXPrinterMappingUserSetting -FriendlyName "Default Printer" -PrinterPath "\\printserver.domain.local\DefaultPrinter" -SetAsDefault -ProcessAtLogin -ProcessAtRefresh -MachineGroupFriendlyName "Production"
```

Creates a printer mapping that sets the specified printer as the user's default for the Production machine group.

## Notes

- Requires a valid AppVentiX license
- This function has the alias `New-AppVentiXPrinterMapping`
- Printer paths should use fully qualified domain names for reliable resolution

## Related Links

- [Get-IvantiWCPrinterMapping](Get-IvantiWCPrinterMapping.md)
- [Import-IvantiWCPrinterMapping](Import-IvantiWCPrinterMapping.md)
- [Set-AppVentiXUserSettingsAssignment](Set-AppVentiXUserSettingsAssignment.md)
- [Get-AppVentiXUserSettings](Get-AppVentiXUserSettings.md)
