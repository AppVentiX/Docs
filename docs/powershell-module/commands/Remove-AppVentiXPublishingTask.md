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
title: Remove-AppVentiXPublishingTask
---

# Remove-AppVentiXPublishingTask

## SYNOPSIS

Removes an AppVentiX publishing task.

## SYNTAX

### ID (Default)

```
Remove-AppVentiXPublishingTask -Id <string> [-Force] [-ConfigShare <string>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### MachineGroupFriendlyname

```
Remove-AppVentiXPublishingTask -MachineGroupFriendlyname <string> [-Force] [-ConfigShare <string>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,

## DESCRIPTION

The Remove-AppVentiXPublishingTask function removes a publishing task from the AppVentiX module.
It can remove a task either by its ID or by the friendly name of the machine group associated with the task.

## EXAMPLES

### EXAMPLE 1

Remove-AppVentiXPublishingTask -Id "12345678-1234-1234-1234-123456789012"
Removes the publishing task with the specified ID.

### EXAMPLE 2

Remove-AppVentiXPublishingTask -MachineGroupFriendlyname "Production"
Removes all the publishing tasks associated with the specified machine group friendly name.

## PARAMETERS

### -ConfigShare

Specifies the path to the AppVentiX configuration share.
You can omit this parameter if the configuration store was already set with Set-AppVentiXConfigShare,
or when it can be detected automatically (for example on a machine where AppVentiX Central View is installed and configured).

```yaml
Type: System.String
DefaultValue: $Script:AppVentix.ConfigShare
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: MachineGroupFriendlyname
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

### -Force

Indicates whether to force the removal of the publishing task without confirmation.
By default, confirmation is required.
Also required to remove a seamless publishing task; you must then remove the published apps from your application publishing tool yourself.

```yaml
Type: System.Management.Automation.SwitchParameter
DefaultValue: False
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: MachineGroupFriendlyname
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

### -Id

Specifies the ID of the publishing task to be removed.

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

Specifies the friendly name of the machine group associated with the publishing task to be removed.

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

### System.String

## OUTPUTS

## RELATED LINKS

- [Get-AppVentiXPublishingTask](Get-AppVentiXPublishingTask.md)
- [New-AppVentiXPublishingTask](New-AppVentiXPublishingTask.md)
- [Set-AppVentiXPublishingTask](Set-AppVentiXPublishingTask.md)
- [Copy-AppVentiXPublishingTask](Copy-AppVentiXPublishingTask.md)
- [Export-AppVentiXPublishingTaskReport](Export-AppVentiXPublishingTaskReport.md)
- [Get-AppVentiXMachineGroup](Get-AppVentiXMachineGroup.md)
