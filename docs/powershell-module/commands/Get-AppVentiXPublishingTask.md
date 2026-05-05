# Get-AppVentiXPublishingTask

Retrieves the publishing tasks from the AppVentiX configuration share.

## Syntax

```powershell
Get-AppVentiXPublishingTask
    [-UserPublishingTasks]
    [-MachineGroupFriendlyName <String>]
    [<CommonParameters>]

Get-AppVentiXPublishingTask
    -GlobalPublishingTasks
    [-MachineGroupFriendlyName <String>]
    [<CommonParameters>]

Get-AppVentiXPublishingTask
    -All
    -MachineGroupFriendlyName <String>
    [<CommonParameters>]

Get-AppVentiXPublishingTask
    -Id <String>
    [<CommonParameters>]
```

## Description

The `Get-AppVentiXPublishingTask` function retrieves the publishing tasks from the specified AppVentiX configuration share. It checks if AppVentiX is licensed and if the publishing tasks file exists. By default, it retrieves user publishing tasks.

## Parameters

### -UserPublishingTasks

Retrieves user publishing tasks. This is the default behavior when no parameter is specified. Has alias: User.

| | |
|---|---|
| Type: | SwitchParameter |
| Position: | Named |
| Default value: | False |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -GlobalPublishingTasks

Retrieves global publishing tasks. Has alias: Global.

| | |
|---|---|
| Type: | SwitchParameter |
| Position: | Named |
| Default value: | False |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -All

Retrieves both global and user publishing tasks. Returns an object with GlobalPublishingTasks and UserPublishingTasks properties.

| | |
|---|---|
| Type: | SwitchParameter |
| Position: | Named |
| Default value: | False |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -Id

Retrieves a specific publishing task by its ID. Accepts pipeline input by property name.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | True |
| Accept wildcard characters: | False |

### -MachineGroupFriendlyName

Filters publishing tasks by the specified machine group friendly name. Has alias: MachineGroup.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

## Examples

### Example 1: Retrieve all user publishing tasks

```powershell
Get-AppVentiXPublishingTask
```

Retrieves all user publishing tasks from the default AppVentiX configuration share.

### Example 2: Retrieve publishing tasks from a specific configuration share

```powershell
Get-AppVentiXPublishingTask -ConfigShare "\\fileserver.domain.local\config"
```

Retrieves user publishing tasks from the specified AppVentiX configuration share.

### Example 3: Retrieve all publishing tasks (global and user)

```powershell
Get-AppVentiXPublishingTask -All
```

Retrieves both global and user publishing tasks.

### Example 4: Retrieve publishing tasks for a specific machine group

```powershell
Get-AppVentiXPublishingTask -MachineGroupFriendlyName "MyMachineGroup"
```

Retrieves user publishing tasks configured for the specified machine group.

## Notes

- Requires a valid AppVentiX license
- Without parameters, only user publishing tasks are returned
- The -All parameter returns a single object with two properties: GlobalPublishingTasks and UserPublishingTasks

## Related Links

- [New-AppVentiXPublishingTask](New-AppVentiXPublishingTask.md)
- [Set-AppVentiXPublishingTask](Set-AppVentiXPublishingTask.md)
- [Remove-AppVentiXPublishingTask](Remove-AppVentiXPublishingTask.md)
- [Copy-AppVentiXPublishingTask](Copy-AppVentiXPublishingTask.md)
- [Export-AppVentiXPublishingTaskReport](Export-AppVentiXPublishingTaskReport.md)
