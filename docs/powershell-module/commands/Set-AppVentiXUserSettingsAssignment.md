---
category: user-settings
category_title: User Settings Commands
document type: cmdlet
external help file: AppVentiX-Help.xml
HelpUri: ''
Locale: en-US
Module Name: AppVentiX
module_version: 2026.818.1700
ms.date: 08-19-2026
PlatyPS schema version: 2024-05-01
title: Set-AppVentiXUserSettingsAssignment
---

# Set-AppVentiXUserSettingsAssignment

## SYNOPSIS

Assigns a user setting to an Active Directory group in AppVentiX.

## SYNTAX

### __AllParameterSets

```
Set-AppVentiXUserSettingsAssignment [-Id] <string> [-ADGroup] <string> [[-DomainFQDN] <string>]
 [[-ADGroupSID] <string>] [-Type] <string> [[-ConfigShare] <string>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,

## DESCRIPTION

Set-AppVentiXUserSettingsAssignment assigns a specific user setting (identified by Id and Type)
to an Active Directory group.
If the AD group does not yet exist in the User Settings Assignments
file, a new entry is created.
If the assignment already exists, no changes are made.

Supports the special built-in group "Everyone" in addition to standard AD groups.
The function requires a valid AppVentiX license.

## EXAMPLES

### EXAMPLE 1

Set-AppVentiXUserSettingsAssignment -Id "abc123" -ADGroup "Finance" -Type "DriveMapping"

Assigns the drive mapping with Id "abc123" to the Finance AD group.

### EXAMPLE 2

Set-AppVentiXUserSettingsAssignment -Id "def456" -ADGroup "Everyone" -Type "EnvironmentVariables"

Assigns the environment variable setting with Id "def456" to all users.

## PARAMETERS

### -ADGroup

The name of the Active Directory group to assign the user setting to.
Use "Everyone" to assign to all users regardless of group membership.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 1
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -ADGroupSID

The Security Identifier (SID) of the AD group.
If not specified, the SID is
resolved automatically by querying Active Directory.

```yaml
Type: System.String
DefaultValue: ''
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

### -ConfigShare

The path to the AppVentiX configuration share.
Defaults to the value configured in the module.

```yaml
Type: System.String
DefaultValue: $Script:AppVentiX.ConfigShare
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 5
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -DomainFQDN

The fully qualified domain name (FQDN) of the Active Directory domain.
If not specified, the current domain FQDN is resolved automatically.

```yaml
Type: System.String
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

The unique identifier of the user setting to assign.

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
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Type

The type of user setting to assign.
Valid values are:
EnvironmentVariables, PrinterMapping, DriveMapping, GroupPolicy, RegistrySettings, Shortcuts.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 4
  IsRequired: true
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

- [Get-AppVentiXUserSettings](Get-AppVentiXUserSettings.md)
- [New-AppVentiXDriveMappingUserSetting](New-AppVentiXDriveMappingUserSetting.md)
- [New-AppVentiXEnvironmentVariableUserSetting](New-AppVentiXEnvironmentVariableUserSetting.md)
- [New-AppVentiXGroupPolicyUserSetting](New-AppVentiXGroupPolicyUserSetting.md)
- [New-AppVentiXPrinterMappingUserSetting](New-AppVentiXPrinterMappingUserSetting.md)
- [New-AppVentiXRegistryUserSetting](New-AppVentiXRegistryUserSetting.md)
- [New-AppVentiXShortcutUserSetting](New-AppVentiXShortcutUserSetting.md)
- [Set-AppVentiXUserSettingFolder](Set-AppVentiXUserSettingFolder.md)
