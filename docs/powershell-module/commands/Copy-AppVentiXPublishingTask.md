# Copy-AppVentiXPublishingTask

Copies AppVentiX publishing tasks to a new machine group with optional Azure Virtual Desktop seamless publishing.

## Syntax

```powershell
Copy-AppVentiXPublishingTask
    -Id <String>
    -NewMachineGroupFriendlyname <String>
    [-NewGroup <String>]
    [-DontPublishSeamless]
    [<CommonParameters>]

Copy-AppVentiXPublishingTask
    -MachineGroupFriendlyname <String>
    -NewMachineGroupFriendlyname <String>
    [-DontPublishSeamless]
    [<CommonParameters>]

Copy-AppVentiXPublishingTask
    -Id <String>
    -NewMachineGroupFriendlyname <String>
    -SubscriptionId <String>
    -ResourceGroupName <String>
    -ApplicationGroupName <String>
    -HostPoolName <String>
    -AssignmentName <String>
    [<CommonParameters>]

Copy-AppVentiXPublishingTask
    -MachineGroupFriendlyname <String>
    -NewMachineGroupFriendlyname <String>
    -SubscriptionId <String>
    -ResourceGroupName <String>
    -ApplicationGroupName <String>
    -HostPoolName <String>
    -AssignmentName <String>
    [<CommonParameters>]
```

## Description

The `Copy-AppVentiXPublishingTask` function copies one or more AppVentiX publishing tasks from an existing machine group to a new machine group. It supports both standard copying and Azure Virtual Desktop (AVD) seamless publishing scenarios.

The function performs the following operations:
- Validates that AppVentiX is properly licensed
- Retrieves existing publishing tasks and machine groups from the configuration
- Copies task configuration including package paths, groups, and seamless applications
- Automatically adjusts content share paths for the new machine group
- Optionally configures Azure Virtual Desktop seamless publishing
- Updates Active Directory group assignments with SID resolution
- Preserves or disables seamless publishing based on parameters

## Parameters

### -Id

Specifies the GUID of a specific publishing task to copy. Accepts pipeline input by property name.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | True |
| Accept wildcard characters: | False |

### -MachineGroupFriendlyname

Specifies the friendly name of the source machine group containing the publishing tasks to copy. All publishing tasks from this machine group will be copied to the new machine group. Accepts pipeline input by property name.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | True |
| Accept wildcard characters: | False |

### -NewMachineGroupFriendlyname

Specifies the friendly name of the destination machine group where tasks will be copied. The machine group must already exist in the AppVentiX configuration.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -NewGroup

Specifies the new Active Directory group to assign to the copied publishing tasks. Can be specified as "GroupName" or "DOMAIN\GroupName". If only the group name is provided, the domain from the original task will be reused.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -DontPublishSeamless

Disables seamless publishing for the copied tasks, even if the original tasks had seamless publishing enabled.

| | |
|---|---|
| Type: | SwitchParameter |
| Position: | Named |
| Default value: | False |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -SubscriptionId

Specifies the Azure subscription ID for Azure Virtual Desktop seamless publishing.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -ResourceGroupName

Specifies the Azure resource group name containing the AVD resources.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -ApplicationGroupName

Specifies the Azure Virtual Desktop application group name for seamless publishing. Has alias: ApplicationGroup.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -HostPoolName

Specifies the Azure Virtual Desktop host pool name associated with the application group. Has alias: HostPool.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -AssignmentName

Specifies the name for the Azure Virtual Desktop user assignment.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

## Examples

### Example 1: Copy a single publishing task by ID

```powershell
Copy-AppVentiXPublishingTask -Id "a1b2c3d4-e5f6-7890-abcd-ef1234567890" -NewMachineGroupFriendlyname "Production"
```

Copies a single publishing task to the Production machine group, preserving all settings including group assignments and seamless publishing.

### Example 2: Copy all tasks from one machine group to another

```powershell
Copy-AppVentiXPublishingTask -MachineGroupFriendlyname "Development" -NewMachineGroupFriendlyname "Testing"
```

Copies all publishing tasks from the Development machine group to the Testing machine group.

### Example 3: Copy tasks and assign to a new AD group

```powershell
Copy-AppVentiXPublishingTask -MachineGroupFriendlyname "Development" -NewMachineGroupFriendlyname "Production" -NewGroup "DOMAIN.local\Prod-Users"
```

Copies all publishing tasks from Development to Production and assigns them to the DOMAIN.local\Prod-Users AD group.

### Example 4: Copy a task and disable seamless publishing

```powershell
Copy-AppVentiXPublishingTask -Id "a1b2c3d4-e5f6-7890-abcd-ef1234567890" -NewMachineGroupFriendlyname "Testing" -DontPublishSeamless
```

Copies a publishing task to Testing but disables seamless publishing even if the source task had it enabled.

### Example 5: Use pipeline input to copy tasks

```powershell
Get-AppVentiXPublishingTask -MachineGroupFriendlyName "Development" | Copy-AppVentiXPublishingTask -NewMachineGroupFriendlyname "Staging"
```

Uses pipeline input to copy all publishing tasks from Development to Staging.

### Example 6: Copy a task with Azure Virtual Desktop configuration

```powershell
$Params = @{
    Id                          = "a1b2c3d4-e5f6-7890-abcd-ef1234567890"
    NewMachineGroupFriendlyname = "AVD-Production"
    SubscriptionId              = "12345678-1234-1234-1234-123456789012"
    ResourceGroupName           = "RG-AVD-Prod"
    ApplicationGroupName        = "AppGroup-Office"
    HostPoolName                = "HostPool-Prod"
    AssignmentName              = "Office-Users-Assignment"
}
Copy-AppVentiXPublishingTask @Params
```

Copies a publishing task with Azure Virtual Desktop seamless publishing configuration.

## Notes

- Requires a valid AppVentiX license
- Tasks assigned to "All Machine Groups" cannot be copied and will be skipped
- The package file must exist in the new machine group's content share for the copy to succeed
- Azure parameter sets require the Az.Accounts, Az.DesktopVirtualization, and Az.Resources PowerShell modules

## Related Links

- [Get-AppVentiXPublishingTask](Get-AppVentiXPublishingTask.md)
- [New-AppVentiXPublishingTask](New-AppVentiXPublishingTask.md)
- [Set-AppVentiXPublishingTask](Set-AppVentiXPublishingTask.md)
- [Remove-AppVentiXPublishingTask](Remove-AppVentiXPublishingTask.md)
- [Enable-AppVentiXSeamlessPublishing](Enable-AppVentiXSeamlessPublishing.md)
