---
category: seamless
category_title: Seamless Publishing Commands
document type: cmdlet
external help file: AppVentiX-Help.xml
HelpUri: ''
Locale: en-US
Module Name: AppVentiX
module_version: 2026.707.1700
ms.date: 07-07-2026
PlatyPS schema version: 2024-05-01
title: Get-AppVentiXSeamlessPublishCommand
---

# Get-AppVentiXSeamlessPublishCommand

## SYNOPSIS

Retrieves the seamless publishing command for the specified publishing task.

## SYNTAX

### ID (Default)

```
Get-AppVentiXSeamlessPublishCommand -Id <string> [-ConfigShare <string>] [<CommonParameters>]
```

### Task

```
Get-AppVentiXSeamlessPublishCommand -PublishingTask <psobject> [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,

## DESCRIPTION

The Get-AppVentiXSeamlessPublishCommand function retrieves the seamless publishing command for the specified publishing task.

## EXAMPLES

### EXAMPLE 1

Get-AppVentiXSeamlessPublishCommand -Id '12345678-1234-1234-1234-123456789012'
Retrieves the seamless publishing command for the publishing task with the specified ID.

### EXAMPLE 2

Get-AppVentiXSeamlessPublishCommand -PublishingTask $publishingTask
Retrieves the seamless publishing command for the specified publishing task object.

## PARAMETERS

### -ConfigShare

Specifies the path to the AppVentiX configuration share.
You can omit this parameter if Set-AppVentiXConfigShare has been called.

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
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Id

Specifies the ID of the publishing task.

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

### -PublishingTask

Specifies the publishing task object.

```yaml
Type: System.Management.Automation.PSObject
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: Task
  Position: Named
  IsRequired: true
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

## NOTES

Function : Get-AppVentiXSeamlessPublishCommand
Author   : John Billekens
Copyright: (c) John Billekens Consultancy & AppVentiX
Version  : 2026.130.1000
Requires : Valid AppVentiX license


## RELATED LINKS

- [Enable-AppVentiXSeamlessPublishing](Enable-AppVentiXSeamlessPublishing.md)
- [Disable-AppVentiXSeamlessPublishing](Disable-AppVentiXSeamlessPublishing.md)
- [Export-AppVentiXSeamlessApplicationsReport](Export-AppVentiXSeamlessApplicationsReport.md)
- [Get-AppVentiXPublishingTask](Get-AppVentiXPublishingTask.md)
- [New-AppVentiXPublishingTask](New-AppVentiXPublishingTask.md)
