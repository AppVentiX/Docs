---
category: publishing-task
category_title: Publishing Task Commands
document type: cmdlet
external help file: AppVentiX-Help.xml
HelpUri: ''
Locale: en-US
Module Name: AppVentiX
module_version: 2026.818.1700
ms.date: 08-19-2026
PlatyPS schema version: 2024-05-01
title: Update-AppVentiXPublishingTaskPath
---

# Update-AppVentiXPublishingTaskPath

## SYNOPSIS

Adds the Content Share relative path to the publishing tasks.

## SYNTAX

### __AllParameterSets

```
Update-AppVentiXPublishingTaskPath [[-ConfigShare] <string>] [-PassThru] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,

## DESCRIPTION

The Update-AppVentiXPublishingTaskPath function adds a RelativePath element to every
publishing task in AppVentiX-PublishingTasks.xml, next to the existing Path element.

A publishing task stores the full package path, for example
"\\lab.local\appventix\content\App_1.0.1.0_x64\App_1.0.1.0_x64.msix".
The leading part of
that path is already configured per Machine Group, so the remainder
"App_1.0.1.0_x64\App_1.0.1.0_x64.msix" is stored as well.
The AppVentiX Agent decides which
of the two it uses, so a task keeps working on Agent versions that do not know the
RelativePath element yet.

The Path element keeps the full path.
The one exception is a task that already holds a
relative path in Path, from before the RelativePath element existed: that path is resolved
back to a full path and stored in both elements, so the task works on every Agent version.

All Task elements are handled: the tasks under Packages, ConnectionGroups and
SharedContainers, in both GlobalPublishingTasks and UserPublishingTasks.

The function is safe to run more than once.
A RelativePath that is already correct is left
alone, one that no longer matches the Path is refreshed, and a package that is not located in
any configured Content Share is reported and keeps its full path only.
A timestamped backup
of AppVentiX-PublishingTasks.xml is written before any change is saved.

## EXAMPLES

### EXAMPLE 1

Update-AppVentiXPublishingTaskPath -WhatIf
Shows which publishing tasks would get a relative path, without changing anything.

### EXAMPLE 2

Update-AppVentiXPublishingTaskPath
Adds the Content Share relative path to all publishing tasks.

### EXAMPLE 3

Update-AppVentiXPublishingTaskPath -PassThru | Format-Table Name, Status, Path, RelativePath
Adds the relative paths and returns a per task overview of the result.

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
- Name: (All)
  Position: 0
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Confirm

Prompts you for confirmation before running the cmdlet.

```yaml
Type: System.Management.Automation.SwitchParameter
DefaultValue: ''
SupportsWildcards: false
Aliases:
- cf
ParameterSets:
- Name: (All)
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -PassThru

Returns a result object per publishing task, describing the full path, the relative path and
the resulting status.

```yaml
Type: System.Management.Automation.SwitchParameter
DefaultValue: False
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -WhatIf

Runs the command in a mode that only reports what would happen without performing the actions.

```yaml
Type: System.Management.Automation.SwitchParameter
DefaultValue: ''
SupportsWildcards: false
Aliases:
- wi
ParameterSets:
- Name: (All)
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

## OUTPUTS

### System.Management.Automation.PSObject

## RELATED LINKS

- [Get-AppVentiXPublishingTask](Get-AppVentiXPublishingTask.md)
- [New-AppVentiXPublishingTask](New-AppVentiXPublishingTask.md)
- [Get-AppVentiXMachineGroup](Get-AppVentiXMachineGroup.md)
