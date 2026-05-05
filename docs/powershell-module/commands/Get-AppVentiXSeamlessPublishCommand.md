# Get-AppVentiXSeamlessPublishCommand

Retrieves the seamless publishing command for the specified publishing task.

## Syntax

```powershell
Get-AppVentiXSeamlessPublishCommand
    -Id <String>
    [<CommonParameters>]

Get-AppVentiXSeamlessPublishCommand
    -PublishingTask <PSCustomObject>
    [<CommonParameters>]
```

## Description

The `Get-AppVentiXSeamlessPublishCommand` function retrieves the seamless publishing command parameters for the specified publishing task. For each seamless application in the task, it returns an object containing the package name, application name, executable path, launch parameter, and icon path. This information can be used to configure application publishing in tools that are not directly integrated with AppVentiX.

## Parameters

### -Id

Specifies the ID of the publishing task. Accepts pipeline input by property name.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | True |
| Accept wildcard characters: | False |

### -PublishingTask

Specifies the publishing task object to retrieve seamless publish commands for.

| | |
|---|---|
| Type: | PSCustomObject |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

## Examples

### Example 1: Retrieve seamless publish command by ID

```powershell
Get-AppVentiXSeamlessPublishCommand -Id '12345678-1234-1234-1234-123456789012'
```

Retrieves the seamless publishing command for the publishing task with the specified ID.

### Example 2: Retrieve seamless publish command from a task object

```powershell
$publishingTask = Get-AppVentiXPublishingTask -Id '12345678-1234-1234-1234-123456789012'
Get-AppVentiXSeamlessPublishCommand -PublishingTask $publishingTask
```

Retrieves the seamless publishing command for a task object obtained from `Get-AppVentiXPublishingTask`.

### Example 3: Retrieve commands for all seamless tasks

```powershell
Get-AppVentiXPublishingTask | Where-Object { $_.PublishSeamless -eq $true } | Get-AppVentiXSeamlessPublishCommand
```

Retrieves seamless publish commands for all publishing tasks with seamless publishing enabled.

## Notes

- Requires a valid AppVentiX license
- Returns one output object per seamless application in the publishing task
- Output properties: PackageName, Name, Program, Parameter, IconPath

## Related Links

- [Enable-AppVentiXSeamlessPublishing](Enable-AppVentiXSeamlessPublishing.md)
- [Disable-AppVentiXSeamlessPublishing](Disable-AppVentiXSeamlessPublishing.md)
- [Get-AppVentiXPublishingTask](Get-AppVentiXPublishingTask.md)
- [Export-AppVentiXSeamlessApplicationsReport](Export-AppVentiXSeamlessApplicationsReport.md)
