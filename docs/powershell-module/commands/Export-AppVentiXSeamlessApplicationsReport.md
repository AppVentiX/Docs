---
category: seamless
category_title: Seamless Publishing Commands
document type: cmdlet
external help file: AppVentiX-Help.xml
HelpUri: ''
Locale: en-US
Module Name: AppVentiX
module_version: 2026.818.1700
ms.date: 08-19-2026
PlatyPS schema version: 2024-05-01
title: Export-AppVentiXSeamlessApplicationsReport
---

# Export-AppVentiXSeamlessApplicationsReport

## SYNOPSIS

Exports the AppVentiX Seamless Applications to a CSV file.

## SYNTAX

### All (Default)

```
Export-AppVentiXSeamlessApplicationsReport -Path <DirectoryInfo> [-ReportType <Object>]
 [-ConfigShare <string>] [<CommonParameters>]
```

### ID

```
Export-AppVentiXSeamlessApplicationsReport -ID <string> -Path <DirectoryInfo> [-ReportType <Object>]
 [-ConfigShare <string>] [<CommonParameters>]
```

### MachineGroupFriendlyname

```
Export-AppVentiXSeamlessApplicationsReport -MachineGroupFriendlyname <string> -Path <DirectoryInfo>
 [-ReportType <Object>] [-ConfigShare <string>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,

## DESCRIPTION

The Export-AppVentiXSeamlessApplicationsReport function exports the AppVentiX Seamless Applications to a CSV file.
It can export all Seamless Applications or a specific task Seamless Applications based on the provided parameters.

## EXAMPLES

### EXAMPLE 1

Export-AppVentiXSeamlessApplicationsReport -Path 'C:\Reports'

This example exports all Seamless Applications to a CSV file located at 'C:\Reports'.

## PARAMETERS

### -ConfigShare

Specifies the path to the AppVentiX configuration share.
You can omit this parameter if the configuration store was already set with Set-AppVentiXConfigShare,
or when it can be detected automatically (for example on a machine where AppVentiX Central View is installed and configured).

```yaml
Type: System.String
DefaultValue: $Script:AppVentix.ConfigShare
SupportsWildcards: false
Aliases:
- Config
- Share
- AppVentixConfigShare
ParameterSets:
- Name: ID
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: MachineGroupFriendlyname
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: All
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -ID

Specifies the ID of the publishing task to export.
This parameter is used to export a specific publishing task based on its ID.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: ID
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: true
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -MachineGroupFriendlyname

Exports only the Seamless Applications for the publishing tasks configured for the specified Machine Group.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: MachineGroupFriendlyname
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: true
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Path

Specifies the path where the CSV file will be saved.
If the path does not exist, it will be created.

```yaml
Type: System.IO.DirectoryInfo
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: ID
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: MachineGroupFriendlyname
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: All
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -ReportType

Specifies the type of report to generate.
Currently, only CSV is supported.

```yaml
Type: System.Object
DefaultValue: CSV
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: ID
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: MachineGroupFriendlyname
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: All
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutBuffer, -OutVariable, -PipelineVariable,
-ProgressAction, -Verbose, -WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

## OUTPUTS

## RELATED LINKS

- [Enable-AppVentiXSeamlessPublishing](Enable-AppVentiXSeamlessPublishing.md)
- [Disable-AppVentiXSeamlessPublishing](Disable-AppVentiXSeamlessPublishing.md)
- [Get-AppVentiXSeamlessPublishCommand](Get-AppVentiXSeamlessPublishCommand.md)
- [Get-AppVentiXPublishingTask](Get-AppVentiXPublishingTask.md)
- [New-AppVentiXPublishingTask](New-AppVentiXPublishingTask.md)
