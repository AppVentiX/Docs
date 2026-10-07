---
category: user-settings
category_title: User Settings Commands
document type: cmdlet
external help file: AppVentiX-Help.xml
HelpUri: ''
Locale: en-US
Module Name: AppVentiX
module_version: 2026.1006.1100
ms.date: 10-07-2026
PlatyPS schema version: 2024-05-01
title: New-AppVentiXGlobalUserSetting
---

# New-AppVentiXGlobalUserSetting

## SYNOPSIS

Creates an AppVentiX global user setting.

## SYNTAX

### __AllParameterSets

```
New-AppVentiXGlobalUserSetting [-Type] <string> [-Settings] <psobject>
 [[-MachineGroupFriendlyName] <string[]>] [[-ConfigShare] <string>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,

## DESCRIPTION

Adds one global user setting of the specified type to its file in the Configuration Store.
The file is created when it does not exist yet.
Existing entries are kept.

Supported types:
- UserStateRoaming: appends a RuleSet to AppVentiX-UserStateRoamingRules.xml.
The rule set always
  gets a new Id, also when a rule set with the same name already exists.

## EXAMPLES

### EXAMPLE 1

New-AppVentiXGlobalUserSetting -Type UserStateRoaming -Settings @{
    Name         = "Notepad++"
    CaptureRules = @(
        @{ Kind = "Folder"; Path = "%APPDATA%\Notepad++" }
        @{ Kind = "Registry"; Path = "HKCU\Software\Notepad++" }
    )
}

## PARAMETERS

### -ConfigShare

Path to the AppVentiX Configuration Store.
Defaults to the module variable.

```yaml
Type: System.String
DefaultValue: $Script:AppVentix.ConfigShare
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

### -MachineGroupFriendlyName

One or more machine group friendly names to assign the setting to.
Defaults to 'All Machine Groups'.

```yaml
Type: System.String[]
DefaultValue: '@("All Machine Groups")'
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

### -Settings

Hashtable or PSCustomObject with the setting data.
UserStateRoaming: Name (mandatory), Description, Enabled (default True) and CaptureRules.
CaptureRules is an array of hashtables or objects with Kind (Folder, File or Registry) and Path.
Optional capture rule keys: Exclude, IncludeSubfolders (default True), Enabled (default True),
Description.

```yaml
Type: System.Management.Automation.PSObject
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

### -Type

Type of the global user setting.
Valid values: UserStateRoaming.

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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutBuffer, -OutVariable, -PipelineVariable,
-ProgressAction, -Verbose, -WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## RELATED LINKS

- [Import-IvantiWCGlobalSetting](Import-IvantiWCGlobalSetting.md)
