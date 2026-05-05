# New-AppVentiXPublishingTask

Creates a new AppVentiX publishing task for an App-V or MSIX package.

## Syntax

```powershell
# Parameter Set: AutoLaunch (default)
New-AppVentiXPublishingTask
    [-MachineGroupFriendlyName <String>]
    [-Priority <Int32>]
    [-Group <String>]
    -Path <String>
    [-AlwaysPublish]
    [-WhenNotExist]
    [-AutoLaunch]
    [-DynamicUserConfigurationPath <String>]
    [-ReturnPublishCommand]
    [<CommonParameters>]

# Parameter Set: PublishSeamless
New-AppVentiXPublishingTask
    [-MachineGroupFriendlyName <String>]
    [-Priority <Int32>]
    [-Group <String>]
    -Path <String>
    [-AlwaysPublish]
    [-WhenNotExist]
    [-DynamicUserConfigurationPath <String>]
    [-ReturnPublishCommand]
    [<CommonParameters>]
```

## Description

The `New-AppVentiXPublishingTask` function creates a new publishing task in AppVentiX for a specified App-V or MSIX package. Publishing tasks define how and when packages are delivered to users in the assigned machine groups.

## Parameters

### -MachineGroupFriendlyName

The friendly name of the machine group for which the publishing task is created.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | All Machine Groups |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -Priority

The priority of the publishing task. Lower numbers indicate higher priority.

| | |
|---|---|
| Type: | Int32 |
| Position: | Named |
| Default value: | 10 |
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

### -Path

The full path to the App-V (.appv) or MSIX package file.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -AlwaysPublish

When specified, the package is always published regardless of whether it is already present.

| | |
|---|---|
| Type: | SwitchParameter |
| Position: | Named |
| Default value: | False |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -WhenNotExist

When specified, the package is only published if it does not already exist on the target.

| | |
|---|---|
| Type: | SwitchParameter |
| Position: | Named |
| Default value: | False |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -AutoLaunch

When specified, configures the publishing task to auto-launch the application after publishing. Available in the AutoLaunch parameter set.

| | |
|---|---|
| Type: | SwitchParameter |
| Position: | Named |
| Default value: | False |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -DynamicUserConfigurationPath

Path to an App-V dynamic user configuration XML file to apply when publishing.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -ReturnPublishCommand

When specified, the function returns the publish command string instead of creating the publishing task directly.

| | |
|---|---|
| Type: | SwitchParameter |
| Position: | Named |
| Default value: | False |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

## Examples

### Example 1: Create a publishing task for all machine groups

```powershell
New-AppVentiXPublishingTask -Path "\\fileserver.domain.local\content\MyApp_1.0.0.0_DeploymentConfig.appv"
```

Creates a publishing task for the specified package available to all machine groups.

### Example 2: Create a high-priority publishing task for a specific machine group

```powershell
New-AppVentiXPublishingTask -Path "\\fileserver.domain.local\content\Office_16.0.appv" -MachineGroupFriendlyName "Production" -Priority 1 -Group "Office Apps" -AlwaysPublish
```

Creates a high-priority publishing task for the Production machine group that always republishes the Office package.

### Example 3: Create an auto-launch publishing task

```powershell
New-AppVentiXPublishingTask -Path "\\fileserver.domain.local\content\MyApp_1.0.0.0.appv" -MachineGroupFriendlyName "Development" -AutoLaunch -WhenNotExist
```

Creates a publishing task that auto-launches the application after publishing, only if it does not already exist.

### Example 4: Create a publishing task and prepare for (seamless) application publishing, aka Published Apps

```powershell
$pubApps = New-AppVentiXPublishingTask -Path "\\fileserver.domain.local\content\MyApp_1.0.0.0.appv" -MachineGroupFriendlyName "Development" -ReturnPublishCommand
```

"Creates a publishing task for MyApp_1.0.0.0.appv, enables Seamless Publishing for the available shortcuts, and returns the commands to launch the applications.

## Notes

- Requires a valid AppVentiX license
- Both App-V (.appv) and MSIX packages are supported

## Related Links

- [Get-AppVentiXPublishingTask](Get-AppVentiXPublishingTask.md)
- [Set-AppVentiXPublishingTask](Set-AppVentiXPublishingTask.md)
- [Remove-AppVentiXPublishingTask](Remove-AppVentiXPublishingTask.md)
- [Copy-AppVentiXPublishingTask](Copy-AppVentiXPublishingTask.md)
- [Get-AppVentiXMachineGroup](Get-AppVentiXMachineGroup.md)
