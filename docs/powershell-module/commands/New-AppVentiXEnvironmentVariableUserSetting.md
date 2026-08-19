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
title: New-AppVentiXEnvironmentVariableUserSetting
---

# New-AppVentiXEnvironmentVariableUserSetting

## SYNOPSIS

Creates an AppVentiX UserSetting XML file for an Environment Variable configuration.

## SYNTAX

### InputObject

```
New-AppVentiXEnvironmentVariableUserSetting -InputObject <psobject> [-FriendlyName <string>]
 [-Description <string>] [-ExecutionOrder <int>] [-ProcessAtLogin <bool>] [-ProcessAtRefresh <bool>]
 [-ProcessAtReconnectAndUnlock <bool>] [-MachineGroupFriendlyName <string[]>]
 [-ConfigShare <string>] [<CommonParameters>]
```

### EnvironmentVariables

```
New-AppVentiXEnvironmentVariableUserSetting -FriendlyName <string>
 -EnvironmentVariables <hashtable[]> [-Description <string>] [-ExecutionOrder <int>]
 [-ProcessAtLogin <bool>] [-ProcessAtRefresh <bool>] [-ProcessAtReconnectAndUnlock <bool>]
 [-MachineGroupFriendlyName <string[]>] [-ConfigShare <string>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,

## DESCRIPTION

Builds and saves an AppVentiX UserSetting XML file that defines one or more environment
variables.
Supports two input modes:

- EnvironmentVariables mode: accepts an array of hashtables describing individual variables.
- InputObject mode: accepts a pre-structured PSCustomObject (e.g.
from an Ivanti export pipeline).

## EXAMPLES

## PARAMETERS

### -ConfigShare

Path to the AppVentiX config share.
Defaults to the module variable.

```yaml
Type: System.String
DefaultValue: $Script:AppVentix.ConfigShare
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

### -Description

Optional description for the UserSetting.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: InputObject
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: EnvironmentVariables
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -EnvironmentVariables

Array of hashtables describing environment variables.
Each entry must contain: Name, Value.
Optional key: AppendToExisting (bool, defaults to $false).

```yaml
Type: System.Collections.Hashtable[]
DefaultValue: '@()'
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: EnvironmentVariables
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -ExecutionOrder

Execution order for the UserSetting.
Defaults to 0.

```yaml
Type: System.Int32
DefaultValue: 0
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: InputObject
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: EnvironmentVariables
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -FriendlyName

Display name for the AppVentiX UserSetting.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: InputObject
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: EnvironmentVariables
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -InputObject

Pre-structured PSCustomObject containing environment variable metadata and entries.

```yaml
Type: System.Management.Automation.PSObject
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: InputObject
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

One or more machine group friendly names to apply the setting to.
Defaults to 'All Machine Groups'.

```yaml
Type: System.String[]
DefaultValue: '@("All Machine Groups")'
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: InputObject
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: EnvironmentVariables
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -ProcessAtLogin

Whether the setting is applied at login.
Defaults to $true.

```yaml
Type: System.Boolean
DefaultValue: True
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: InputObject
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: EnvironmentVariables
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -ProcessAtReconnectAndUnlock

Whether the setting is applied at reconnect and unlock.
Defaults to $false.

```yaml
Type: System.Boolean
DefaultValue: False
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: InputObject
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: EnvironmentVariables
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -ProcessAtRefresh

Whether the setting is applied at refresh.
Defaults to $true.

```yaml
Type: System.Boolean
DefaultValue: True
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: InputObject
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: EnvironmentVariables
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

- [Get-AppVentiXUserSettings](Get-AppVentiXUserSettings.md)
- [New-AppVentiXDriveMappingUserSetting](New-AppVentiXDriveMappingUserSetting.md)
- [New-AppVentiXGroupPolicyUserSetting](New-AppVentiXGroupPolicyUserSetting.md)
- [New-AppVentiXPrinterMappingUserSetting](New-AppVentiXPrinterMappingUserSetting.md)
- [New-AppVentiXRegistryUserSetting](New-AppVentiXRegistryUserSetting.md)
- [New-AppVentiXShortcutUserSetting](New-AppVentiXShortcutUserSetting.md)
- [Set-AppVentiXUserSettingFolder](Set-AppVentiXUserSettingFolder.md)
- [Set-AppVentiXUserSettingsAssignment](Set-AppVentiXUserSettingsAssignment.md)
