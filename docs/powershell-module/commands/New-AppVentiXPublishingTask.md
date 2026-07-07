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
title: New-AppVentiXPublishingTask
---

# New-AppVentiXPublishingTask

## SYNOPSIS

Creates a new AppVentiX publishing task.

## SYNTAX

### AutoLaunch (Default)

```
New-AppVentiXPublishingTask -Group <string[]> -Path <FileInfo> [-Type <string>]
 [-MachineGroupFriendlyName <string[]>] [-Priority <int>] [-AlwaysPublish] [-WhenNotExist <string>]
 [-AutoLaunch] [-DynamicUserConfigurationPath <string>] [-ConfigShare <string>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### PublishSeamless

```
New-AppVentiXPublishingTask -Group <string[]> -Path <FileInfo> [-Type <string>]
 [-MachineGroupFriendlyName <string[]>] [-Priority <int>] [-AlwaysPublish] [-WhenNotExist <string>]
 [-DynamicUserConfigurationPath <string>] [-ReturnPublishCommand] [-ConfigShare <string>] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,

## DESCRIPTION

The New-AppVentiXPublishingTask function creates a new publishing task for AppVentiX.
It allows you to specify various parameters such as the type of package, machine group, priority, name, version, group, path, and more.
The function also checks if the package exists and if AppVentiX is licensed before creating the publishing task.

## EXAMPLES

### EXAMPLE 1

New-AppVentiXPublishingTask -MachineGroupFriendlyName 'Group1' -Priority 50 -Group 'Group1' -Path '\\fileserver.domain.local\content\Package_v\Package_1.0.0.0_x64\package.msix'
Creates a new publishing task with the specified parameters, returns the ID of the new task.

### EXAMPLE 2

New-AppVentiXPublishingTask -MachineGroupFriendlyName 'Group1' -Priority 100 -Group 'Group1' -Path '\\fileserver.domain.local\content\Package_v\Package_1.0.0.0_x64\package.appattach'
Creates a new publishing task with the specified parameters, returns the ID of the new task.

### EXAMPLE 3

$params = @{
    MachineGroupFriendlyName = 'Group1'
    Priority = 50
    Group = 'Group1'
    Path = '\\fileserver.domain.local\content\Package_v\Package_1.0.0.0_x64\package.msix'
}
$newTask = New-AppVentiXPublishingTask @params
Creates a new publishing task with the specified parameters, returns the ID of the new task. We can use the output to publish the task.

## PARAMETERS

### -AlwaysPublish

Indicates whether the package should always be published.

```yaml
Type: System.Management.Automation.SwitchParameter
DefaultValue: False
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: AutoLaunch
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: PublishSeamless
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -AutoLaunch

Indicates whether to auto-launch the package.

```yaml
Type: System.Management.Automation.SwitchParameter
DefaultValue: False
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: AutoLaunch
  Position: Named
  IsRequired: false
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
Aliases: []
ParameterSets:
- Name: AutoLaunch
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: PublishSeamless
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

### -DynamicUserConfigurationPath

Specifies the path to the dynamic user configuration file.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: AutoLaunch
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: PublishSeamless
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Group

Specifies the group of the publishing task.
Example: 'domain.local\group1'

```yaml
Type: System.String[]
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: AutoLaunch
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: PublishSeamless
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -MachineGroupFriendlyName

Specifies the friendly name of the machine group.

```yaml
Type: System.String[]
DefaultValue: "@('All Machine Groups')"
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: AutoLaunch
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: PublishSeamless
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Path

Specifies the path to the package file.

```yaml
Type: System.IO.FileInfo
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: AutoLaunch
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: PublishSeamless
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Priority

Specifies the priority of the publishing task.
Default value is 100.

```yaml
Type: System.Int32
DefaultValue: 100
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: AutoLaunch
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: PublishSeamless
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -ReturnPublishCommand

Publish the task as a seamless task and return the necessary information to execute the publish command.

```yaml
Type: System.Management.Automation.SwitchParameter
DefaultValue: False
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: PublishSeamless
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Type

Deprecated.
The package type (MSIX, APPV or Sharedcontainer) is now determined from the file
extension, so this parameter is no longer needed and is ignored with a warning when supplied.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: AutoLaunch
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: PublishSeamless
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

### -WhenNotExist

Specifies the action to take when the package does not exist.
Valid values are 'Add' and 'Skip'.

```yaml
Type: System.String
DefaultValue: Add
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: AutoLaunch
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: PublishSeamless
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

## NOTES

Function : New-AppVentiXPublishingTask
Author   : John Billekens
Copyright: (c) John Billekens Consultancy & AppVentiX
Version  : 2026.409.2200
Requires : Valid AppVentiX license


## RELATED LINKS

- [Get-AppVentiXPublishingTask](Get-AppVentiXPublishingTask.md)
- [Set-AppVentiXPublishingTask](Set-AppVentiXPublishingTask.md)
- [Remove-AppVentiXPublishingTask](Remove-AppVentiXPublishingTask.md)
- [Copy-AppVentiXPublishingTask](Copy-AppVentiXPublishingTask.md)
- [Export-AppVentiXPublishingTaskReport](Export-AppVentiXPublishingTaskReport.md)
- [Get-AppVentiXMachineGroup](Get-AppVentiXMachineGroup.md)
