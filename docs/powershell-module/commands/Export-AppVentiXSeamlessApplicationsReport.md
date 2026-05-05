# Export-AppVentiXSeamlessApplicationsReport

Exports the AppVentiX seamless applications to a CSV file.

## Syntax

```powershell
Export-AppVentiXSeamlessApplicationsReport
    -Path <DirectoryInfo>
    [-ReportType <String>]
    [<CommonParameters>]

Export-AppVentiXSeamlessApplicationsReport
    -Id <String>
    -Path <DirectoryInfo>
    [-ReportType <String>]
    [<CommonParameters>]

Export-AppVentiXSeamlessApplicationsReport
    -MachineGroupFriendlyname <String>
    -Path <DirectoryInfo>
    [-ReportType <String>]
    [<CommonParameters>]
```

## Description

The `Export-AppVentiXSeamlessApplicationsReport` function exports seamless application details from AppVentiX publishing tasks to a CSV file. It can export seamless applications from all publishing tasks, or filter by a specific task ID or machine group. If the specified output path does not exist, it will be created automatically.

The exported filename includes a timestamp in the format `AppVentiXSeamlessApplicationsReport_yyyyMMdd_HHmmss.csv`.

Each row in the exported CSV includes: task name, task ID, application number, executable, arguments, run-virtual setting, friendly name, and icon path.

## Parameters

### -ID

Specifies the ID of a specific publishing task whose seamless applications to export. Must be a valid GUID. Accepts pipeline input by property name.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | True |
| Accept wildcard characters: | False |

### -MachineGroupFriendlyname

Specifies the friendly name of the machine group to filter publishing tasks. Only seamless applications from tasks in this group are exported. Accepts pipeline input by property name.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | True |
| Accept wildcard characters: | False |

### -ReportType

Specifies the type of report to generate. Currently only CSV is supported.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | CSV |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -Path

Specifies the directory path where the CSV file will be saved. The directory will be created if it does not exist.

| | |
|---|---|
| Type: | DirectoryInfo |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

## Examples

### Example 1: Export all seamless applications to a report

```powershell
Export-AppVentiXSeamlessApplicationsReport -Path 'C:\Reports'
```

Exports all seamless applications from all publishing tasks to a CSV file in the C:\Reports directory.

### Example 2: Export seamless applications for a specific machine group

```powershell
Export-AppVentiXSeamlessApplicationsReport -MachineGroupFriendlyname "Production" -Path 'C:\Reports'
```

Exports seamless applications for tasks assigned to the Production machine group.

## Notes

- Requires a valid AppVentiX license
- Only publishing tasks with seamless publishing enabled are included in the export
- The output directory will be created automatically if it does not exist

## Related Links

- [Export-AppVentiXPublishingTaskReport](Export-AppVentiXPublishingTaskReport.md)
- [Get-AppVentiXPublishingTask](Get-AppVentiXPublishingTask.md)
- [Enable-AppVentiXSeamlessPublishing](Enable-AppVentiXSeamlessPublishing.md)
- [Get-AppVentiXSeamlessPublishCommand](Get-AppVentiXSeamlessPublishCommand.md)
