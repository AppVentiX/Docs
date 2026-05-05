# Enable-AppVentiXSeamlessPublishing

Enables seamless publishing for the specified AppVentiX publishing task.

## Syntax

```powershell
Enable-AppVentiXSeamlessPublishing
    -Id <String>
    -SubscriptionId <String>
    -TenantId <String>
    -ResourceGroupName <String>
    -ApplicationGroupName <String>
    -HostPoolName <String>
    -AssignmentName <String>
    [-RunVirtual]
    [<CommonParameters>]

Enable-AppVentiXSeamlessPublishing
    -Id <String>
    -SubscriptionId <String>
    -TenantId <String>
    -ResourceGroupName <String>
    -ApplicationGroupName <String>
    -HostPoolName <String>
    -AssignmentName <String>
    -SeamlessApps <PSCustomObject[]>
    [<CommonParameters>]
```

## Description

The `Enable-AppVentiXSeamlessPublishing` function enables seamless publishing for the specified AppVentiX publishing task. It supports publishing to Azure Virtual Desktop (AVD) application groups.

When Azure parameters are provided, the function:
1. Connects to Azure using the Az PowerShell modules
2. Creates or updates the AVD application group if needed
3. Assigns an Azure AD group or user to the application group
4. Removes existing applications from the group and publishes the new ones
5. Updates the publishing task XML with seamless application details

When no Azure parameters are provided, the function returns the publish command parameters as output objects so they can be used with another publishing tool.

## Parameters

### -Id

Specifies the ID of the publishing task for which to enable seamless publishing. Accepts pipeline input by property name.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | True |
| Accept wildcard characters: | False |

### -SubscriptionId

Specifies the Azure subscription ID where the AVD resources are located.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -TenantId

Specifies the Azure tenant ID.

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

Specifies the name of the Azure Virtual Desktop application group to publish applications to. Has alias: ApplicationGroup.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -HostPoolName

Specifies the name of the Azure Virtual Desktop host pool associated with the application group. Has alias: HostPool.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -AssignmentName

Specifies the name of the Azure AD group or user to assign to the application group.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -SeamlessApps

Specifies the applications to publish seamlessly. Each PSCustomObject must contain the properties: Order, Executable, Argument, IconPath, FriendlyName, RunVirtual, Description.

| | |
|---|---|
| Type: | PSCustomObject[] |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | True |
| Accept wildcard characters: | False |

### -RunVirtual

When specified, marks the applications as running virtually (App-V style). Only applicable when using the IDAzureAll parameter set (automatic app detection).

| | |
|---|---|
| Type: | SwitchParameter |
| Position: | Named |
| Default value: | False |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

## Examples

### Example 1: Enable seamless publishing for all apps in a package

```powershell
Enable-AppVentiXSeamlessPublishing -Id '12345678-1234-1234-1234-123456789012' `
    -SubscriptionId '12345678-1234-1234-1234-123456789012' `
    -TenantId '00000000-0000-0000-0000-000000000000' `
    -ResourceGroupName 'MyResourceGroup' `
    -ApplicationGroupName 'MyApplicationGroup' `
    -HostPoolName 'MyHostPool' `
    -AssignmentName 'MyAADGroup'
```

Enables seamless publishing for all applications detected in the package.

### Example 2: Enable seamless publishing from a new task

```powershell
$params = @{
    SubscriptionId       = '12345678-1234-1234-1234-123456789012'
    TenantId             = '00000000-0000-0000-0000-000000000000'
    ResourceGroupName    = 'MyResourceGroup'
    ApplicationGroupName = 'MyApplicationGroup'
    HostPoolName         = 'MyHostPool'
    AssignmentName       = 'MyAADGroup'
}
$newTask | Enable-AppVentiXSeamlessPublishing @params
```

Uses the output of `New-AppVentiXPublishingTask` piped to enable seamless publishing.

### Example 3: Enable seamless publishing with specific applications

```powershell
Enable-AppVentiXSeamlessPublishing -Id '12345678-1234-1234-1234-123456789012' `
    -SubscriptionId '12345678-1234-1234-1234-123456789012' `
    -TenantId '00000000-0000-0000-0000-000000000000' `
    -ResourceGroupName 'MyResourceGroup' `
    -ApplicationGroupName 'MyApplicationGroup' `
    -HostPoolName 'MyHostPool' `
    -AssignmentName 'MyAADGroup' `
    -SeamlessApps @(
        [PSCustomObject]@{
            Order        = '0'
            Executable   = 'MSIXApp1ID#Path\To\MSIXApp1.exe'
            Argument     = ''
            IconPath     = 'C:\Program Files\WindowsApps\App.1.1.1.1_x64__abc\Assets\App1.png'
            FriendlyName = 'App1'
            RunVirtual   = $false
            Description  = 'This is the first application'
        }
    )
```

Enables seamless publishing for specific applications rather than auto-detecting from the package manifest.

## Notes

- Requires a valid AppVentiX license
- Requires the Az.Accounts (minimum 2.17.0), Az.DesktopVirtualization (minimum 4.3.0), and Az.Resources (minimum 7.4.0) PowerShell modules
- An active Azure connection is required; the function will prompt for login if not already connected
- If no Azure parameters are provided, the function returns publish command parameters as output objects

## Related Links

- [Disable-AppVentiXSeamlessPublishing](Disable-AppVentiXSeamlessPublishing.md)
- [Get-AppVentiXPublishingTask](Get-AppVentiXPublishingTask.md)
- [New-AppVentiXPublishingTask](New-AppVentiXPublishingTask.md)
- [Get-AppVentiXSeamlessPublishCommand](Get-AppVentiXSeamlessPublishCommand.md)
