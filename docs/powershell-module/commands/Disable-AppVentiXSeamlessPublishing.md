# Disable-AppVentiXSeamlessPublishing

Disables seamless publishing for an AppVentiX publishing task in an Azure environment.

## Syntax

```powershell
Disable-AppVentiXSeamlessPublishing
    -Id <String>
    -SubscriptionId <String>
    -ResourceGroupName <String>
    -ApplicationGroupName <String>
    -HostPoolName <String>
    [-RemoveApplicationGroup]
    [<CommonParameters>]
```

## Description

The `Disable-AppVentiXSeamlessPublishing` function disables seamless publishing for an AppVentiX publishing task in an Azure environment. It removes the SeamlessApplication elements from the Publishing Tasks file and sets the PublishSeamless property to False.

The function also removes the published applications from the Azure Virtual Desktop application group, and optionally removes the application group itself.

## Parameters

### -Id

Specifies the ID of the AppVentiX publishing task. Accepts pipeline input by property name.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | True |
| Accept wildcard characters: | False |

### -SubscriptionId

Specifies the ID of the Azure subscription where the AVD resources are located.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -ResourceGroupName

Specifies the name of the Azure resource group containing the AVD resources.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -ApplicationGroupName

Specifies the name of the Azure Virtual Desktop application group from which applications will be removed.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -HostPoolName

Specifies the name of the Azure Virtual Desktop host pool associated with the application group.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -RemoveApplicationGroup

When specified, removes the entire Azure Virtual Desktop application group after removing its applications. If not specified, only the applications are removed and a warning is displayed.

| | |
|---|---|
| Type: | SwitchParameter |
| Position: | Named |
| Default value: | False |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

## Examples

### Example 1: Disable seamless publishing for a task

```powershell
Disable-AppVentiXSeamlessPublishing -Id "Task1" -SubscriptionId "12345678-1234-1234-1234-1234567890ab" -ResourceGroupName "MyResourceGroup" -ApplicationGroupName "MyAppGroup" -HostPoolName "MyHostPool"
```

Disables seamless publishing for the AppVentiX task with ID "Task1" in the Azure environment. Removes all applications from the application group but keeps the application group itself.

### Example 2: Disable seamless publishing and remove the application group

```powershell
Disable-AppVentiXSeamlessPublishing -Id "Task1" -SubscriptionId "12345678-1234-1234-1234-1234567890ab" -ResourceGroupName "MyResourceGroup" -ApplicationGroupName "MyAppGroup" -HostPoolName "MyHostPool" -RemoveApplicationGroup
```

Disables seamless publishing and removes the entire Azure Virtual Desktop application group.

## Notes

- Requires a valid AppVentiX license
- Requires the Az.Accounts and Az.DesktopVirtualization PowerShell modules (minimum versions 2.17.0 and 4.3.0 respectively)
- An active Azure connection is required; the function will prompt for login if not already connected
- If the application group does not exist, the function exits gracefully

## Related Links

- [Enable-AppVentiXSeamlessPublishing](Enable-AppVentiXSeamlessPublishing.md)
- [Get-AppVentiXPublishingTask](Get-AppVentiXPublishingTask.md)
- [Get-AppVentiXSeamlessPublishCommand](Get-AppVentiXSeamlessPublishCommand.md)
