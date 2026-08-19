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
title: Get-IvantiWCNetworkDrive
---

# Get-IvantiWCNetworkDrive

## SYNOPSIS

Retrieves Ivanti Workspace Control network drive mappings from XML files.

## SYNTAX

### ByFilePath

```
Get-IvantiWCNetworkDrive -XmlFilePath <string> [-DomainFqdn <string>] [-AsJson]
 [-ExportFor <string>] [<CommonParameters>]
```

### ByPath

```
Get-IvantiWCNetworkDrive -XmlPath <string> [-DomainFqdn <string>] [-AsJson] [-ExportFor <string>]
 [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,

## DESCRIPTION

Processes Ivanti Workspace Control XML building block file(s) and extracts network drive
mapping settings, assignments, and metadata.
Supports both single large XML files and
directories containing multiple separate XML files.

## EXAMPLES

### EXAMPLE 1

Get-IvantiWCNetworkDrive -XmlFilePath "C:\Config\IvantiDrives.xml" -DomainFqdn "corp.contoso.com"

Processes a single XML file (legacy parameter usage).

### EXAMPLE 2

Get-IvantiWCNetworkDrive -XmlPath "C:\Config\NetworkDrives\" -DomainFqdn "corp.contoso.com"

Processes all XML files in the specified directory.

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
- A single XML file containing all network drive configurations
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

## RELATED LINKS

- [Import-IvantiWCNetworkDrive](Import-IvantiWCNetworkDrive.md)
