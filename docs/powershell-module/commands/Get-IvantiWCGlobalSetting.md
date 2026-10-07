---
category: migration-ivanti
category_title: Ivanti Workspace Control Migration
document type: cmdlet
external help file: AppVentiX-Help.xml
HelpUri: ''
Locale: en-US
Module Name: AppVentiX
module_version: 2026.1006.1100
ms.date: 10-07-2026
PlatyPS schema version: 2024-05-01
title: Get-IvantiWCGlobalSetting
---

# Get-IvantiWCGlobalSetting

## SYNOPSIS

Retrieves Ivanti Workspace Control global user preference (Zero Profile) settings from XML files.

## SYNTAX

### ByFilePath

```
Get-IvantiWCGlobalSetting -XmlFilePath <string> [-AsJson] [-ExportFor <string>] [<CommonParameters>]
```

### ByPath

```
Get-IvantiWCGlobalSetting -XmlPath <string> [-AsJson] [-ExportFor <string>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,

## DESCRIPTION

Processes Ivanti Workspace Control XML building block file(s) and extracts the global user
preference profiles ("Zero Profiles"), converting each enabled profile's capture settings
(folder, file and registry rules) into AppVentiX User State Roaming capture rules.
Supports
both a single XML file and a directory containing multiple XML files.

## EXAMPLES

### EXAMPLE 1

Get-IvantiWCGlobalSetting -XmlFilePath "C:\Config\GlobalSettings.xml"

Processes a single XML file (legacy parameter usage).

### EXAMPLE 2

Get-IvantiWCGlobalSetting -XmlPath "C:\Config\GlobalSettings\" -AsJson

Processes all XML files in the specified directory and outputs as JSON.

## PARAMETERS

### -AsJson

Switch to output the results as JSON format instead of PowerShell objects.

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

### -ExportFor

Target system for export.
Valid value: AppVentiX.

```yaml
Type: System.String
DefaultValue: AppVentiX
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

### -XmlFilePath

(Legacy parameter) Path to a single Ivanti Workspace Control XML building block file.
This parameter is maintained for backward compatibility.
Use -XmlPath instead.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: ByFilePath
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -XmlPath

Path to either a single XML file or a directory containing multiple XML files.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: ByPath
  Position: Named
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
