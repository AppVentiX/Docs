# Get-AppVentiXMachineGroup

Retrieves the machine groups from the AppVentiX configuration.

## Syntax

```powershell
Get-AppVentiXMachineGroup
    [<CommonParameters>]

Get-AppVentiXMachineGroup
    -Name <String[]>
    [<CommonParameters>]
```

## Description

The `Get-AppVentiXMachineGroup` function retrieves the machine groups from the AppVentiX configuration store. It can retrieve all machine groups or a specific machine group by name.

## Parameters

### -Name

Specifies the name of the machine group to retrieve. Accepts multiple values. Has aliases: FriendlyName, MachineGroupFriendlyName.

| | |
|---|---|
| Type: | String[] |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

## Examples

### Example 1: Retrieve all machine groups

```powershell
Get-AppVentiXMachineGroup
```

Retrieves all machine groups from the AppVentiX configuration.

### Example 2: Retrieve a specific machine group

```powershell
Get-AppVentiXMachineGroup -Name 'Production'
```

Retrieves the machine group named 'Production' from the AppVentiX configuration.

### Example 3: Retrieve multiple machine groups

```powershell
Get-AppVentiXMachineGroup -Name 'Production', 'Development'
```

Retrieves the Production and Development machine groups.

## Notes

- Requires a valid AppVentiX license
- A warning is displayed if a requested machine group name is not found
- Each machine group object includes content share paths and group name information

## Related Links

- [Get-AppVentiXPublishingTask](Get-AppVentiXPublishingTask.md)
- [Get-AppVentiXContentSharePackages](Get-AppVentiXContentSharePackages.md)
- [New-AppVentiXPublishingTask](New-AppVentiXPublishingTask.md)
