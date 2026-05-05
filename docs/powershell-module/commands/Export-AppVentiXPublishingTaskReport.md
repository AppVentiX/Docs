# Export-AppVentiXPublishingTaskReport

Exports the AppVentiX publishing task report to a CSV file.

## Syntax

```powershell
Export-AppVentiXPublishingTaskReport
    -Path <DirectoryInfo>
    [-ReportType <String>]
    [<CommonParameters>]

Export-AppVentiXPublishingTaskReport
    -Id <String>
    -Path <DirectoryInfo>
    [-ReportType <String>]
    [<CommonParameters>]

Export-AppVentiXPublishingTaskReport
    -MachineGroupFriendlyname <String>
    -Path <DirectoryInfo>
    [-ReportType <String>]
    [<CommonParameters>]
```

## Description

The `Export-AppVentiXPublishingTaskReport` function exports the AppVentiX publishing task report to a CSV file. It can export all publishing tasks or a specific subset based on the provided parameters. If the specified output path does not exist, it will be created automatically.

The exported filename includes a timestamp in the format `AppVentiXPublishingTaskReport_yyyyMMdd_HHmmss.csv`.

## Parameters

### -ID

Specifies the ID of a specific publishing task to export. Must be a valid GUID. Accepts pipeline input by property name.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | True |
| Accept wildcard characters: | False |

### -MachineGroupFriendlyname

Specifies the friendly name of the machine group to filter publishing tasks. Accepts pipeline input by property name.

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

### Example 1: Export all publishing tasks to a report

```powershell
Export-AppVentiXPublishingTaskReport -Path 'C:\Reports'
```

Exports all publishing tasks to a CSV file in the C:\Reports directory.

### Example 2: Export tasks for a specific machine group

```powershell
Export-AppVentiXPublishingTaskReport -MachineGroupFriendlyname "Production" -Path 'C:\Reports'
```

Exports publishing tasks for the Production machine group to a CSV file.

### Example 3: Export a specific task by ID

```powershell
Export-AppVentiXPublishingTaskReport -Id "12345678-1234-1234-1234-123456789012" -Path 'C:\Reports'
```

Exports the publishing task with the specified ID to a CSV file.

## Notes

- Requires a valid AppVentiX license
- The output directory will be created automatically if it does not exist
- The exported file is named with a timestamp to avoid overwriting previous reports

## Related Links

- [Get-AppVentiXPublishingTask](Get-AppVentiXPublishingTask.md)
- [Export-AppVentiXSeamlessApplicationsReport](Export-AppVentiXSeamlessApplicationsReport.md)
