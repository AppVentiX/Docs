---
category: migration-ivanti
category_title: Ivanti Workspace Control Migration
document type: cmdlet
external help file: AppVentiX-Help.xml
HelpUri: ''
Locale: en-US
Module Name: AppVentiX
module_version: 2026.707.1700
ms.date: 07-07-2026
PlatyPS schema version: 2024-05-01
title: Get-IvantiWCEnvironmentVariable
---

# Get-IvantiWCEnvironmentVariable

## SYNOPSIS

Retrieves Ivanti Workspace Control variable configurations from XML files.

## SYNTAX

### ByFilePath

```
Get-IvantiWCEnvironmentVariable -XmlFilePath <string> [-DomainFqdn <string>] [-AsJson]
 [-ExportFor <string>] [<CommonParameters>]
```

### ByPath

```
Get-IvantiWCEnvironmentVariable -XmlPath <string> [-DomainFqdn <string>] [-AsJson]
 [-ExportFor <string>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,

## DESCRIPTION

Processes Ivanti Workspace Control XML building block file(s) and extracts variable
settings, assignments, and metadata.
Supports both single large XML files and
directories containing multiple separate XML files.

## EXAMPLES

### EXAMPLE 1

Get-IvantiWCEnvironmentVariable -XmlFilePath "C:\Config\IvantiVars.xml"

Processes a single XML file (legacy parameter usage).

### EXAMPLE 2

Get-IvantiWCEnvironmentVariable -XmlPath "C:\Config\Variables\" -AsJson

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

### -DomainFqdn

Domain FQDN to append to non-FQDN SMB paths.

```yaml
Type: System.String
DefaultValue: ''
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

Target system for export: AppVentiX or WEM.

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

Path to either:
- A single XML file containing all variable configurations
- A directory containing multiple XML files

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

## NOTES

Function  : Get-IvantiWCEnvironmentVariable
Author    : John Billekens
Copyright : (c) John Billekens Consultancy
Version   : 2026.130.945


## RELATED LINKS

- [Import-IvantiWCEnvironmentVariable](Import-IvantiWCEnvironmentVariable.md)
