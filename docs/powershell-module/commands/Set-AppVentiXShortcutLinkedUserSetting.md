---
category: user-settings
category_title: User Settings Commands
document type: cmdlet
external help file: AppVentiX-Help.xml
HelpUri: ''
Locale: en-US
Module Name: AppVentiX
module_version: 2026.1117.2000
ms.date: 11-17-2026
PlatyPS schema version: 2024-05-01
title: Set-AppVentiXShortcutLinkedUserSetting
---

# Set-AppVentiXShortcutLinkedUserSetting

## SYNOPSIS

Sets the linked (prelaunch and postlaunch) User Settings of a Shortcuts User Setting.

## SYNTAX

### __AllParameterSets

```
Set-AppVentiXShortcutLinkedUserSetting [-Id] <guid> [[-Prelaunch] <Object[]>]
 [[-Postlaunch] <Object[]>] [[-ConfigShare] <string>] [-Force] [-PassThru] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,

## DESCRIPTION

Replaces the PrelaunchUserSettings and/or PostlaunchUserSettings of a Shortcuts User Setting.
Prelaunch User Settings are processed before the application is started, postlaunch User
Settings when the application has been closed.
Only the list of a given parameter is replaced.
An empty list removes all linked User Settings of that phase.

Only Drive Mapping, Environment Variables, External Tasks, Files and Folders, Printer Mapping
and Registry Settings User Settings can be linked.

A linked User Setting cannot be assigned to user groups.
When a User Setting to link is
assigned to one or more user groups, you are asked to unassign it, as AppVentiX Central View
does.
Use -Force to unassign without asking.
When you decline, nothing is changed.

## EXAMPLES

### EXAMPLE 1

Set-AppVentiXShortcutLinkedUserSetting -Id "ac4cc957-c328-4258-9086-1bfb4b1ffc87" -Prelaunch "f2d4c639-a348-4324-ae90-176ad83e4244", "befb465c-0413-4657-88df-68252902e734" -Postlaunch "83676923-069d-4bd6-b27a-332b092fa225"

### EXAMPLE 2

Set-AppVentiXShortcutLinkedUserSetting -Id "ac4cc957-c328-4258-9086-1bfb4b1ffc87" -Postlaunch @()

Removes all postlaunch User Settings.
The prelaunch User Settings are not changed.

### EXAMPLE 3

$shortcut = Get-AppVentiXShortcutLinkedUserSetting -Id "ac4cc957-c328-4258-9086-1bfb4b1ffc87"
$shortcut.Prelaunch = @($shortcut.Prelaunch | Where-Object UserSettingName -ne "Set Var")
$shortcut | Set-AppVentiXShortcutLinkedUserSetting

Removes one prelaunch User Setting and keeps the others.

### EXAMPLE 4

$driveMapping = Get-AppVentiXUserSettings -Type DriveMapping -FriendlyName "Map Public"
Set-AppVentiXShortcutLinkedUserSetting -Id "ac4cc957-c328-4258-9086-1bfb4b1ffc87" -Prelaunch $driveMapping.Id -Force

Links a drive mapping as prelaunch User Setting and unassigns it from user groups without asking.

## PARAMETERS

### -ConfigShare

Path to the ConfigShare.
Defaults to the module-configured ConfigShare.

```yaml
Type: System.String
DefaultValue: $Script:AppVentiX.ConfigShare
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

### -Force

Unassigns linked User Settings from user groups without asking.

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

### -Id

The Id (GUID) of the Shortcuts User Setting.

```yaml
Type: System.Guid
DefaultValue: ''
SupportsWildcards: false
Aliases:
- ShortcutId
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

### -PassThru

Returns the linked User Settings of the Shortcuts User Setting after the change.

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

### -Postlaunch

The User Settings to run when the application has been closed, in order.
Accepts Ids (GUID)
or the objects from the Postlaunch property of Get-AppVentiXShortcutLinkedUserSetting.

```yaml
Type: System.Object[]
DefaultValue: ''
SupportsWildcards: false
Aliases:
- PostlaunchId
ParameterSets:
- Name: (All)
  Position: 2
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: true
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Prelaunch

The User Settings to run before the application is started, in order.
Accepts Ids (GUID)
or the objects from the Prelaunch property of Get-AppVentiXShortcutLinkedUserSetting.

```yaml
Type: System.Object[]
DefaultValue: ''
SupportsWildcards: false
Aliases:
- PrelaunchId
ParameterSets:
- Name: (All)
  Position: 1
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: true
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

### System.Guid

### System.Object[]

## OUTPUTS

### System.Management.Automation.PSObject

## RELATED LINKS

- [Get-AppVentiXShortcutLinkedUserSetting](Get-AppVentiXShortcutLinkedUserSetting.md)
- [New-AppVentiXShortcutUserSetting](New-AppVentiXShortcutUserSetting.md)
- [Set-AppVentiXUserSettingsAssignment](Set-AppVentiXUserSettingsAssignment.md)
