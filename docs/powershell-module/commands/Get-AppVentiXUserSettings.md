---
category: user-settings
category_title: User Settings Commands
document type: cmdlet
external help file: AppVentiX-Help.xml
HelpUri: ''
Locale: en-US
Module Name: AppVentiX
module_version: 2026.707.1700
ms.date: 07-07-2026
PlatyPS schema version: 2024-05-01
title: Get-AppVentiXUserSettings
---

# Get-AppVentiXUserSettings

## SYNOPSIS

Retrieves the AppVentiX User Settings from the configuration share.

## SYNTAX

### __AllParameterSets

```
Get-AppVentiXUserSettings [[-Setting] <string>] [[-ConfigShare] <string>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,

## DESCRIPTION

The Get-AppVentiXUserSettings function reads the User Setting XML files from the AppVentiX
configuration share and returns them as objects.
You can retrieve all User Settings or filter
on a specific setting type.

## EXAMPLES

### EXAMPLE 1

Get-AppVentiXUserSettings

Retrieves all User Settings from the AppVentiX configuration share.

### EXAMPLE 2

Get-AppVentiXUserSettings -Setting DriveMapping

Retrieves only the Drive Mapping User Settings.

## PARAMETERS

### -ConfigShare

Specifies the path to the AppVentiX configuration share.
You can omit this parameter if Set-AppVentiXConfigShare has been called.

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

### -Setting

Specifies the type of User Setting to retrieve.
Valid values are 'All', 'DriveMapping', 'EnvironmentVariables' and 'PrinterMapping'.
Defaults to 'All'.

```yaml
Type: System.String
DefaultValue: All
SupportsWildcards: false
Aliases: []
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

## OUTPUTS

## NOTES

Function    : Get-AppVentiXUserSettings
Author      : John Billekens
Copyright   : (c) John Billekens Consultancy & AppVentiX
Version     : 2026.130.1000
Requires    : Valid AppVentiX license


## RELATED LINKS

- [New-AppVentiXDriveMappingUserSetting](New-AppVentiXDriveMappingUserSetting.md)
- [New-AppVentiXEnvironmentVariableUserSetting](New-AppVentiXEnvironmentVariableUserSetting.md)
- [New-AppVentiXGroupPolicyUserSetting](New-AppVentiXGroupPolicyUserSetting.md)
- [New-AppVentiXPrinterMappingUserSetting](New-AppVentiXPrinterMappingUserSetting.md)
- [New-AppVentiXRegistryUserSetting](New-AppVentiXRegistryUserSetting.md)
- [New-AppVentiXShortcutUserSetting](New-AppVentiXShortcutUserSetting.md)
- [Set-AppVentiXUserSettingFolder](Set-AppVentiXUserSettingFolder.md)
- [Set-AppVentiXUserSettingsAssignment](Set-AppVentiXUserSettingsAssignment.md)
