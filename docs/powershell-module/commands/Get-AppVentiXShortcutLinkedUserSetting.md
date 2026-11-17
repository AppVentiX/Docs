---
category: user-settings
category_title: User Settings Commands
document type: cmdlet
external help file: AppVentiX-Help.xml
HelpUri: ''
Locale: en-US
Module Name: AppVentiX
module_version: 2026.1117.1700
ms.date: 11-17-2026
PlatyPS schema version: 2024-05-01
title: Get-AppVentiXShortcutLinkedUserSetting
---

# Get-AppVentiXShortcutLinkedUserSetting

## SYNOPSIS

Gets the linked (prelaunch and postlaunch) User Settings of Shortcuts User Settings.

## SYNTAX

### __AllParameterSets

```
Get-AppVentiXShortcutLinkedUserSetting [[-Id] <guid[]>] [[-ConfigShare] <string>]
 [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,

## DESCRIPTION

Reads the PrelaunchUserSettings and PostlaunchUserSettings of one or more Shortcuts User
Settings.
Prelaunch User Settings are processed before the application is started,
postlaunch User Settings when the application has been closed.
Without -Id, all Shortcuts User Settings are returned, also the ones without linked User Settings.
The output can be changed and piped to Set-AppVentiXShortcutLinkedUserSetting.

## EXAMPLES

### EXAMPLE 1

Get-AppVentiXShortcutLinkedUserSetting -Id "ac4cc957-c328-4258-9086-1bfb4b1ffc87"

### EXAMPLE 2

Get-AppVentiXShortcutLinkedUserSetting | Where-Object { $_.Prelaunch.UserSettingName -contains "Map Public" }

Returns the Shortcuts User Settings that run "Map Public" before the application is started.

### EXAMPLE 3

$shortcut = Get-AppVentiXShortcutLinkedUserSetting -Id "ac4cc957-c328-4258-9086-1bfb4b1ffc87"
$shortcut.Postlaunch += "83676923-069d-4bd6-b27a-332b092fa225"
$shortcut | Set-AppVentiXShortcutLinkedUserSetting

Adds a postlaunch User Setting and keeps the existing linked User Settings.

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
  Position: 1
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Id

The Id (GUID) of one or more Shortcuts User Settings.

```yaml
Type: System.Guid[]
DefaultValue: ''
SupportsWildcards: false
Aliases:
- ShortcutId
ParameterSets:
- Name: (All)
  Position: 0
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

### System.Guid[]

## OUTPUTS

### PSCustomObject with Id

### System.Management.Automation.PSObject

## RELATED LINKS

- [Set-AppVentiXShortcutLinkedUserSetting](Set-AppVentiXShortcutLinkedUserSetting.md)
- [New-AppVentiXShortcutUserSetting](New-AppVentiXShortcutUserSetting.md)
- [Get-AppVentiXUserSettings](Get-AppVentiXUserSettings.md)
