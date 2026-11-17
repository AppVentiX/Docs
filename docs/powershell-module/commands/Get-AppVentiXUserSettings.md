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
title: Get-AppVentiXUserSettings
---

# Get-AppVentiXUserSettings

## SYNOPSIS

Retrieves the AppVentiX User Settings from the configuration share.

## SYNTAX

### __AllParameterSets

```
Get-AppVentiXUserSettings [[-Type] <string[]>] [[-Id] <guid[]>] [[-FriendlyName] <string[]>]
 [[-ConfigShare] <string>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,

## DESCRIPTION

The Get-AppVentiXUserSettings function reads the User Setting XML files from the AppVentiX
configuration share and returns them as objects.
You can retrieve all User Settings or filter
on type, Id and FriendlyName.
Filters can be combined.
Type and Id are matched on the file name, so only the matching files are read.
This is faster,
especially for an Azure Blob Configuration Store.

## EXAMPLES

### EXAMPLE 1

Get-AppVentiXUserSettings

Retrieves all User Settings from the AppVentiX configuration share.

### EXAMPLE 2

Get-AppVentiXUserSettings -Type DriveMapping, PrinterMapping

Retrieves only the Drive Mapping and Printer Mapping User Settings.

### EXAMPLE 3

Get-AppVentiXUserSettings -FriendlyName 'VS Code*'

Retrieves the User Settings whose name starts with "VS Code".

### EXAMPLE 4

Get-AppVentiXUserSettings -Type Shortcuts -FriendlyName 'Notepad++'

Retrieves the Shortcuts User Setting named Notepad++.
Only the Shortcuts files are read.

### EXAMPLE 5

Get-AppVentiXUserSettings -Id 'ac4cc957-c328-4258-9086-1bfb4b1ffc87'

Retrieves one User Setting by Id.

## PARAMETERS

### -ConfigShare

Specifies the path to the AppVentiX configuration share.
You can omit this parameter if the configuration store was already set with Set-AppVentiXConfigShare,
or when it can be detected automatically (for example on a machine where AppVentiX Central View is installed and configured).

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

### -FriendlyName

One or more User Setting names.
Wildcards are supported, e.g.
'VS Code*'.
Not case-sensitive.

```yaml
Type: System.String[]
DefaultValue: ''
SupportsWildcards: true
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

One or more User Setting Ids (GUID).
Accepts the Id property from the pipeline.

```yaml
Type: System.Guid[]
DefaultValue: ''
SupportsWildcards: false
Aliases: []
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

### -Type

One or more User Setting types to retrieve: DriveMapping, EnvironmentVariables, ExternalTasks
(External Tasks), GroupPolicy, ManageFiles (Files and Folders), PrinterMapping, RegistrySettings,
Shortcuts, or All.
Defaults to All.
Alias: Setting.

```yaml
Type: System.String[]
DefaultValue: All
SupportsWildcards: false
Aliases:
- Setting
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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutBuffer, -OutVariable, -PipelineVariable,
-ProgressAction, -Verbose, -WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Guid[]

## OUTPUTS

### System.Management.Automation.PSObject

## RELATED LINKS

- [New-AppVentiXDriveMappingUserSetting](New-AppVentiXDriveMappingUserSetting.md)
- [New-AppVentiXEnvironmentVariableUserSetting](New-AppVentiXEnvironmentVariableUserSetting.md)
- [New-AppVentiXGroupPolicyUserSetting](New-AppVentiXGroupPolicyUserSetting.md)
- [New-AppVentiXPrinterMappingUserSetting](New-AppVentiXPrinterMappingUserSetting.md)
- [New-AppVentiXRegistryUserSetting](New-AppVentiXRegistryUserSetting.md)
- [New-AppVentiXShortcutUserSetting](New-AppVentiXShortcutUserSetting.md)
- [Set-AppVentiXUserSettingFolder](Set-AppVentiXUserSettingFolder.md)
- [Set-AppVentiXUserSettingsAssignment](Set-AppVentiXUserSettingsAssignment.md)
