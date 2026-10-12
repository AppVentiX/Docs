---
category: publishing-task
category_title: Publishing Task Commands
document type: cmdlet
external help file: AppVentiX-Help.xml
HelpUri: ''
Locale: en-US
Module Name: AppVentiX
module_version: 2026.1008.1800
ms.date: 10-12-2026
PlatyPS schema version: 2024-05-01
title: New-AppVentiXPublishingTask
---

# New-AppVentiXPublishingTask

## SYNOPSIS

Creates a new AppVentiX publishing task.

## SYNTAX

### AutoLaunch (Default)

```
New-AppVentiXPublishingTask -Path <string> [-Type <string>] [-MachineGroupFriendlyName <string[]>]
 [-Priority <int>] [-ADGroup <string[]>] [-EntraIDGroup <string[]>] [-ADGroupSID <string[]>]
 [-AlwaysPublish] [-WhenNotExist <string>] [-AutoLaunch] [-DynamicUserConfigurationPath <string>]
 [-ConfigShare <string>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### PublishSeamless

```
New-AppVentiXPublishingTask -Path <string> [-Type <string>] [-MachineGroupFriendlyName <string[]>]
 [-Priority <int>] [-ADGroup <string[]>] [-EntraIDGroup <string[]>] [-ADGroupSID <string[]>]
 [-AlwaysPublish] [-WhenNotExist <string>] [-DynamicUserConfigurationPath <string>]
 [-ReturnPublishCommand] [-ConfigShare <string>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,

## DESCRIPTION

The New-AppVentiXPublishingTask function creates a new publishing task for AppVentiX.
It allows you to specify the package path, machine group, priority, AD groups, Entra ID groups, and more.
The package type, name and version are read from the package.
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
    Group = 'Everyone'
    Path = '\\fileserver.domain.local\content\Package_v\Package_1.0.0.0_x64\package.msix'
}
$newTask = New-AppVentiXPublishingTask @params
Creates a new publishing task with the specified parameters, returns the ID of the new task. We can use the output to publish the task.

### EXAMPLE 4

New-AppVentiXPublishingTask -ADGroup 'domain.local\Group1' -EntraIDGroup 'AppVentiX - Apps' -Path 'azure://appventix/content/Package_1.0.0.0_x64/Package_1.0.0.0_x64.msix'
Creates a new publishing task for an AD group and an Entra ID group, returns the ID of the new task.

### EXAMPLE 5

New-AppVentiXPublishingTask -MachineGroupFriendlyName 'Entra machines' -EntraIDGroup 'AppVentiX - Apps' -Path 'azure://appventix/content/Package_1.0.0.0_x64/Package_1.0.0.0_x64.msix'
Creates a new publishing task for an Entra ID group only, returns the ID of the new task.
No AD group is added, also not the default 'Everyone' group.

## PARAMETERS

### -ADGroup

Specify the fully qualified domain name and the groupname, e.g.
'DOMAIN.LOCAL\GROUP'.
Multiple groups can be specified by separating them with a comma.
The default value is 'Everyone'
when neither -ADGroup nor -EntraIDGroup is specified.
Example: 'domain.local\group1'
Each group must resolve to a SID in Active Directory, otherwise an error is returned and no task is created.
Alias: Group

```yaml
Type: System.String[]
DefaultValue: "@('Everyone')"
SupportsWildcards: false
Aliases:
- Group
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

### -ADGroupSID

Internal.
Known SIDs for -ADGroup, matched by position.
An empty entry is looked up in AD.

```yaml
Type: System.String[]
DefaultValue: '@()'
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
You can omit this parameter if the configuration store was already set with Set-AppVentiXConfigShare,
or when it can be detected automatically (for example on a machine where AppVentiX Central View is installed and configured).

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
Only used for APPV packages.
The path is stored relative to the Content Share it is located in.
A file outside every
Content Share is stored as a full path instead.

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

### -EntraIDGroup

Specify the display name or object ID of one or more Entra ID groups, e.g.
'AppVentiX - Apps'.
Can be combined with -ADGroup.
Requires Entra ID integration to be enabled in AppVentiX.
The groups are looked up in Microsoft Graph, which asks for a device-code sign-in when no
cached sign-in is available.
Each group must resolve to exactly one Entra ID group, otherwise
an error is returned and no task is created.
Use the object ID when the display name is not unique.
Use Connect-AppVentiXAzure to sign in beforehand.

```yaml
Type: System.String[]
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

Specifies the path to the package file, either a file system path or a path on an
Azure Blob content share ('azure://<account>/<container>/<blob>').

```yaml
Type: System.String
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

## RELATED LINKS

- [Get-AppVentiXPublishingTask](Get-AppVentiXPublishingTask.md)
- [Set-AppVentiXPublishingTask](Set-AppVentiXPublishingTask.md)
- [Remove-AppVentiXPublishingTask](Remove-AppVentiXPublishingTask.md)
- [Copy-AppVentiXPublishingTask](Copy-AppVentiXPublishingTask.md)
- [Export-AppVentiXPublishingTaskReport](Export-AppVentiXPublishingTaskReport.md)
- [Get-AppVentiXMachineGroup](Get-AppVentiXMachineGroup.md)
