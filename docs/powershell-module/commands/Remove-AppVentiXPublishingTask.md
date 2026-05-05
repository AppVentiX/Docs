# Remove-AppVentiXPublishingTask

Removes one or more AppVentiX publishing tasks.

## Syntax

```powershell
# Parameter Set: ID
Remove-AppVentiXPublishingTask
    -Id <String[]>
    [-Force]
    [-WhatIf]
    [-Confirm]
    [<CommonParameters>]

# Parameter Set: MachineGroupFriendlyname
Remove-AppVentiXPublishingTask
    -MachineGroupFriendlyname <String>
    [-Force]
    [-WhatIf]
    [-Confirm]
    [<CommonParameters>]
```

## Description

The `Remove-AppVentiXPublishingTask` function removes one or more publishing tasks from AppVentiX. Tasks can be removed by their unique ID or by machine group friendly name. Because this is a destructive operation, confirmation is required unless `-Force` is specified. The function supports `-WhatIf` and `-Confirm` common parameters.

## Parameters

### -Id

One or more publishing task IDs to remove. Accepts an array of ID strings.

| | |
|---|---|
| Type: | String[] |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | True |
| Accept wildcard characters: | False |

### -MachineGroupFriendlyname

The friendly name of the machine group whose publishing tasks should be removed.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -Force

Suppresses the confirmation prompt and removes tasks without asking for confirmation.

| | |
|---|---|
| Type: | SwitchParameter |
| Position: | Named |
| Default value: | False |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -WhatIf

Shows what would happen if the command runs without actually performing the removal.

| | |
|---|---|
| Type: | SwitchParameter |
| Position: | Named |
| Default value: | False |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -Confirm

Prompts for confirmation before executing the removal.

| | |
|---|---|
| Type: | SwitchParameter |
| Position: | Named |
| Default value: | True |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

## Examples

### Example 1: Remove a publishing task by ID

```powershell
Remove-AppVentiXPublishingTask -Id "a1b2c3d4-e5f6-7890-abcd-ef1234567890"
```

Removes the publishing task with the specified ID after confirmation.

### Example 2: Remove multiple publishing tasks without confirmation

```powershell
Remove-AppVentiXPublishingTask -Id "id1", "id2", "id3" -Force
```

Removes the specified publishing tasks without prompting for confirmation.

### Example 3: Remove all tasks for a machine group

```powershell
Remove-AppVentiXPublishingTask -MachineGroupFriendlyname "Development" -Force
```

Removes all publishing tasks assigned to the Development machine group without confirmation.

### Example 4: Preview removal with WhatIf

```powershell
Remove-AppVentiXPublishingTask -MachineGroupFriendlyname "Production" -WhatIf
```

Shows which publishing tasks would be removed for the Production machine group without actually removing them.

## Notes

- Requires a valid AppVentiX license
- This operation is irreversible; use `-WhatIf` to preview changes before executing

## Related Links

- [Get-AppVentiXPublishingTask](Get-AppVentiXPublishingTask.md)
- [New-AppVentiXPublishingTask](New-AppVentiXPublishingTask.md)
- [Set-AppVentiXPublishingTask](Set-AppVentiXPublishingTask.md)
- [Get-AppVentiXMachineGroup](Get-AppVentiXMachineGroup.md)
