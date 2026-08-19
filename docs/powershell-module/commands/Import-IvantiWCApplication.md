---
category: migration-ivanti
category_title: Ivanti Workspace Control Migration
document type: cmdlet
external help file: AppVentiX-Help.xml
HelpUri: ''
Locale: en-US
Module Name: AppVentiX
module_version: 2026.818.1700
ms.date: 08-19-2026
PlatyPS schema version: 2024-05-01
title: Import-IvantiWCApplication
---

# Import-IvantiWCApplication

## SYNOPSIS

Imports application shortcuts from Ivanti Workspace Control XML configuration into AppVentiX.

## SYNTAX

### __AllParameterSets

```
Import-IvantiWCApplication [-XmlFilePath] <string> [[-MachineGroupFriendlyName] <string>]
 [[-ConfigShare] <string>] [-GUI] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,

## DESCRIPTION

Extracts application definitions from an Ivanti WC XML file and creates corresponding
AppVentiX Shortcut UserSetting XML files.
Optionally presents a GUI for selective import.
Processes Active Directory group assignments and places imported items in the
'Migrated User Settings' folder.

Uses Get-IvantiWCApplication -ExportFor AppVentiX as the data source.
Icon data (base64)
is included in the AppVentiXApplicationParams from the source function.

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
  Position: 2
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -GUI

When specified, displays a graphical selection grid for interactive selection.

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

### -MachineGroupFriendlyName

Friendly name of the machine group to assign the imported settings to.
Defaults to 'All Machine Groups'.

```yaml
Type: System.String
DefaultValue: All Machine Groups
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

Path to the Ivanti Workspace Control XML building block file, or a directory containing
multiple XML files (one per application).

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

- [Get-IvantiWCApplication](Get-IvantiWCApplication.md)
