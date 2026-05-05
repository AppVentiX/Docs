# Set-AppVentiXPublishingTask

Modifies an existing AppVentiX publishing task.

## Syntax

```powershell
Set-AppVentiXPublishingTask
    -Id <String>
    [-MachineGroupFriendlyname <String>]
    [-Group <String>]
    [-Priority <Int32>]
    [<CommonParameters>]
```

## Description

The `Set-AppVentiXPublishingTask` function modifies an existing publishing task identified by its unique ID. You can update the machine group assignment, task group, and priority of the publishing task.

## Parameters

### -Id

The unique identifier of the publishing task to modify. This parameter is mandatory.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | True |
| Accept wildcard characters: | False |

### -MachineGroupFriendlyname

The friendly name of the machine group to assign the publishing task to.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -Group

The group name used to organize publishing tasks.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -Priority

The priority of the publishing task. Lower numbers indicate higher priority.

| | |
|---|---|
| Type: | Int32 |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

## Examples

### Example 1: Change the priority of a publishing task

```powershell
Set-AppVentiXPublishingTask -Id "a1b2c3d4-e5f6-7890-abcd-ef1234567890" -Priority 5
```

Sets the priority of the specified publishing task to 5.

### Example 2: Move a publishing task to a different machine group

```powershell
Set-AppVentiXPublishingTask -Id "a1b2c3d4-e5f6-7890-abcd-ef1234567890" -MachineGroupFriendlyname "Production" -Group "Business Apps"
```

Moves the publishing task to the Production machine group and assigns it to the 'Business Apps' group.

### Example 3: Update tasks from pipeline

```powershell
Get-AppVentiXPublishingTask -MachineGroupFriendlyname "Development" | Set-AppVentiXPublishingTask -Priority 20
```

Sets the priority of all publishing tasks in the Development machine group to 20.

## Notes

- Requires a valid AppVentiX license
- Use `Get-AppVentiXPublishingTask` to retrieve task IDs before modification

## Related Links

- [Get-AppVentiXPublishingTask](Get-AppVentiXPublishingTask.md)
- [New-AppVentiXPublishingTask](New-AppVentiXPublishingTask.md)
- [Remove-AppVentiXPublishingTask](Remove-AppVentiXPublishingTask.md)
- [Copy-AppVentiXPublishingTask](Copy-AppVentiXPublishingTask.md)
