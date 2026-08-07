---
category: publishing-task
category_title: Publishing Task Commands
document type: cmdlet
external help file: AppVentiX-Help.xml
HelpUri: ''
Locale: en-US
Module Name: AppVentiX
module_version: 2026.806.1845
ms.date: 08-07-2026
PlatyPS schema version: 2024-05-01
title: Set-AppVentiXPublishingTask
---

# Set-AppVentiXPublishingTask

## SYNOPSIS

Updates the properties of an AppVentiX publishing task.

## SYNTAX

### __AllParameterSets

```
Set-AppVentiXPublishingTask [-Id] <string> [[-MachineGroupFriendlyname] <string[]>]
 [[-Group] <string[]>] [[-Priority] <int>] [[-ConfigShare] <string>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,

## DESCRIPTION

The Set-AppVentiXPublishingTask function is used to update the properties of an existing AppVentiX publishing task.
It allows you to modify the ID, MachineGroupFriendlyname, Group, and Priority of the task.

Every run also brings the task up to date with the RelativePath element, which holds the
package path relative to the Content Share.
Piping Get-AppVentiXPublishingTask into this
function without any other parameter therefore adds the missing relative paths.

Tasks can be piped in, and the Publishing Tasks file is read once and saved once for the
whole pipeline.

## EXAMPLES

### EXAMPLE 1

Set-AppVentiXPublishingTask -Id "12345678-1234-1234-1234-1234567890AB" -MachineGroupFriendlyname "MyMachineGroup" -Group "DOMAIN\GROUP" -Priority 1 -ConfigShare "\\fileserver.domain.local\config"

This example updates the properties of the publishing task with the specified ID.
It changes the machine group friendly name to "MyMachineGroup", the group name to "DOMAIN\GROUP", the priority to 1, and uses the specified configuration share path.

### EXAMPLE 2

Get-AppVentiXPublishingTask | Set-AppVentiXPublishingTask

This example adds the missing relative path to every user publishing task, without changing anything else.

### EXAMPLE 3

Set-AppVentiXPublishingTask -Id "12345678-1234-1234-1234-1234567890AB"

This example adds the missing relative path to the publishing task with the specified ID.

## PARAMETERS

### -ConfigShare

Specifies the configuration share path.
If this parameter is not provided, the default configuration share path will be used.

```yaml
Type: System.String
DefaultValue: $Script:AppVentix.ConfigShare
SupportsWildcards: false
Aliases:
- Config
- Share
- AppVentixConfigShare
ParameterSets:
- Name: (All)
  Position: 4
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Group

Specifies the group name associated with the publishing task.
The group name should contain the domain name and the group name, e.g., "DOMAIN.LOCAL\GROUP".
If this parameter is not provided, the group name will not be changed.

```yaml
Type: System.String[]
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 2
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Id

Specifies the ID of the publishing task to be updated.
The ID must be a valid GUID.
Accepts the Id of the objects returned by Get-AppVentiXPublishingTask from the pipeline.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 0
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: true
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -MachineGroupFriendlyname

Specifies the friendly name of the machine group associated with the publishing task.
If this parameter is not provided, the machine group friendly name will not be changed.

```yaml
Type: System.String[]
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 1
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Priority

Specifies the priority of the publishing task.
If this parameter is not provided, the priority will not be changed.

```yaml
Type: System.Int32
DefaultValue: 0
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 3
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

Function : Set-AppVentiXPublishingTask
Author   : John Billekens
Copyright: (c) John Billekens Consultancy & AppVentiX
Version  : 2026.804.1515
Requires : Valid AppVentiX license


## RELATED LINKS

- [Get-AppVentiXPublishingTask](Get-AppVentiXPublishingTask.md)
- [Update-AppVentiXPublishingTaskPath](Update-AppVentiXPublishingTaskPath.md)
- [New-AppVentiXPublishingTask](New-AppVentiXPublishingTask.md)
- [Remove-AppVentiXPublishingTask](Remove-AppVentiXPublishingTask.md)
- [Copy-AppVentiXPublishingTask](Copy-AppVentiXPublishingTask.md)
- [Export-AppVentiXPublishingTaskReport](Export-AppVentiXPublishingTaskReport.md)
- [Get-AppVentiXMachineGroup](Get-AppVentiXMachineGroup.md)
