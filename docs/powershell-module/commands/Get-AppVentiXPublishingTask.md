---
category: publishing-task
category_title: Publishing Task Commands
document type: cmdlet
external help file: AppVentiX-Help.xml
HelpUri: ''
Locale: en-US
Module Name: AppVentiX
module_version: 2026.707.1700
ms.date: 07-07-2026
PlatyPS schema version: 2024-05-01
title: Get-AppVentiXPublishingTask
---

# Get-AppVentiXPublishingTask

## SYNOPSIS

Retrieves the publishing tasks from the AppVentiX configuration share.

## SYNTAX

### User (Default)

```
Get-AppVentiXPublishingTask [-UserPublishingTasks] [-MachineGroupFriendlyName <string>]
 [-ConfigShare <string>] [<CommonParameters>]
```

### Global

```
Get-AppVentiXPublishingTask -GlobalPublishingTasks [-MachineGroupFriendlyName <string>]
 [-ConfigShare <string>] [<CommonParameters>]
```

### All

```
Get-AppVentiXPublishingTask -All -MachineGroupFriendlyName <string> [-ConfigShare <string>]
 [<CommonParameters>]
```

### ID

```
Get-AppVentiXPublishingTask -Id <string> [-ConfigShare <string>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,

## DESCRIPTION

The Get-AppVentiXPublishingTask function retrieves the publishing tasks from the specified AppVentiX configuration share.
It checks if AppVentiX is licensed and if the publishing tasks file exists.
If successful, it returns the publishing tasks as an output.

## EXAMPLES

### EXAMPLE 1

Get-AppVentiXPublishingTask
Retrieves the (User) publishing tasks from the default AppVentiX configuration share.

### EXAMPLE 2

Get-AppVentiXPublishingTask -ConfigShare "\\fileserver.domain.local\config"
Retrieves the (User) publishing tasks from the specified AppVentiX configuration share "\\fileserver.domain.local\config".

### EXAMPLE 3

Get-AppVentiXPublishingTask -All
Retrieves both the global and user publishing tasks from the default AppVentiX configuration share.

### EXAMPLE 4

Get-AppVentiXPublishingTask -MachineGroupFriendlyName "MyMachineGroup"
Retrieves user publishing tasks that are configured for the "MyMachineGroup" Machine Group from the default AppVentiX configuration share.

## PARAMETERS

### -All

Retrieves both the global and user publishing tasks.

```yaml
Type: System.Management.Automation.SwitchParameter
DefaultValue: False
SupportsWildcards: false
Aliases: []
ParameterSets:
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
- Name: User
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: Global
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

### -GlobalPublishingTasks

Retrieves the global publishing tasks.

```yaml
Type: System.Management.Automation.SwitchParameter
DefaultValue: False
SupportsWildcards: false
Aliases:
- Global
ParameterSets:
- Name: Global
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Id

Retrieves the publishing task with the specified ID.

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

### -MachineGroupFriendlyName

Filters the publishing tasks to those configured for the specified Machine Group.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases:
- MachineGroup
ParameterSets:
- Name: User
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: Global
  Position: Named
  IsRequired: false
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

### -UserPublishingTasks

Retrieves the user publishing tasks.
This is the default if no parameter is specified.

```yaml
Type: System.Management.Automation.SwitchParameter
DefaultValue: False
SupportsWildcards: false
Aliases:
- User
ParameterSets:
- Name: User
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

## NOTES

Function : Get-AppVentiXPublishingTask
Author   : John Billekens
Copyright: (c) John Billekens Consultancy & AppVentiX
Version  : 2026.130.1000
Requires : Valid AppVentiX license


## RELATED LINKS

- [New-AppVentiXPublishingTask](New-AppVentiXPublishingTask.md)
- [Set-AppVentiXPublishingTask](Set-AppVentiXPublishingTask.md)
- [Remove-AppVentiXPublishingTask](Remove-AppVentiXPublishingTask.md)
- [Copy-AppVentiXPublishingTask](Copy-AppVentiXPublishingTask.md)
- [Export-AppVentiXPublishingTaskReport](Export-AppVentiXPublishingTaskReport.md)
- [Get-AppVentiXMachineGroup](Get-AppVentiXMachineGroup.md)
