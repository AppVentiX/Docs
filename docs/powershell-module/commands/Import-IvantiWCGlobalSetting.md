---
category: migration-ivanti
category_title: Ivanti Workspace Control Migration
document type: cmdlet
external help file: AppVentiX-Help.xml
HelpUri: ''
Locale: en-US
Module Name: AppVentiX
module_version: 2026.922.1400
ms.date: 09-22-2026
PlatyPS schema version: 2024-05-01
title: Import-IvantiWCGlobalSetting
---

# Import-IvantiWCGlobalSetting

## SYNOPSIS

Imports Ivanti Workspace Control global user preference profiles as AppVentiX User State Roaming rule sets.

## SYNTAX

### __AllParameterSets

```
Import-IvantiWCGlobalSetting [-XmlFilePath] <string> [[-MachineGroupFriendlyName] <string[]>]
 [[-ConfigShare] <string>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,

## DESCRIPTION

Uses Get-IvantiWCGlobalSetting -ExportFor AppVentiX as the data source and creates one
User State Roaming rule set per profile with New-AppVentiXGlobalUserSetting.
Existing rule sets
are kept.
Every imported rule set gets a new Id, also when a rule set with the same name
already exists.

## EXAMPLES

### EXAMPLE 1

Import-IvantiWCGlobalSetting -XmlFilePath "C:\Temp\buildingblock.xml"

Imports all enabled global user preference profiles for all machine groups.

### EXAMPLE 2

Import-IvantiWCGlobalSetting -XmlFilePath "C:\Temp\buildingblock.xml" -MachineGroupFriendlyName "Test"

Imports the profiles and assigns the rule sets to the machine group 'Test'.

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
  Position: 2
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -MachineGroupFriendlyName

One or more machine group friendly names to assign the imported rule sets to.
Defaults to 'All Machine Groups'.

```yaml
Type: System.String[]
DefaultValue: '@("All Machine Groups")'
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

### -XmlFilePath

Path to the Ivanti Workspace Control XML building block file.

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

- [Get-IvantiWCGlobalSetting](Get-IvantiWCGlobalSetting.md)
- [New-AppVentiXGlobalUserSetting](New-AppVentiXGlobalUserSetting.md)
