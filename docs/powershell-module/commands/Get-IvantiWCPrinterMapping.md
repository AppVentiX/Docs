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
title: Get-IvantiWCPrinterMapping
---

# Get-IvantiWCPrinterMapping

## SYNOPSIS

Parses Ivanti Workspace Control XML file(s) to extract printer mappings.

## SYNTAX

### ByFilePath

```
Get-IvantiWCPrinterMapping -XmlFilePath <string> [-DomainFqdn <string>] [-AsJson]
 [-ExportFor <string>] [<CommonParameters>]
```

### ByPath

```
Get-IvantiWCPrinterMapping -XmlPath <string> [-DomainFqdn <string>] [-AsJson] [-ExportFor <string>]
 [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,

## DESCRIPTION

This function reads specified Ivanti Workspace Control XML export file(s), filters for printer mappings,
and transforms the data into structured PowerShell objects or a single JSON string.

Supports both single large XML files and directories containing multiple separate XML files.

It processes each printer mapping to:
- Convert the printer's SMB path to a Fully Qualified Domain Name (FQDN) using a helper function.
- Determine if it's the default printer.
- Extract associated access control objects (users and groups).
- Collect other metadata like comments, location, and driver names.

## EXAMPLES

### EXAMPLE 1

Get-IvantiWCPrinterMapping -XmlFilePath "C:\IvantiConfig\Printers.xml" -DomainFqdn "corp.contoso.com"

Description
-----------
This command processes the 'Printers.xml' file (legacy parameter usage).

### EXAMPLE 2

Get-IvantiWCPrinterMapping -XmlPath "C:\IvantiConfig\Printers\" -DomainFqdn "corp.contoso.com"

Description
-----------
This command processes all XML files in the specified directory.

### EXAMPLE 3

Get-IvantiWCPrinterMapping -XmlPath "C:\IvantiConfig\Printers.xml" -DomainFqdn "corp.contoso.com" -AsJson | Out-File -FilePath "C:\Output\printers.json"

Description
-----------
This command processes the XML file and outputs as JSON to a file.

## PARAMETERS

### -AsJson

If specified, the function collects all results and outputs them as a single, multi-line JSON string.
Otherwise, it streams each printer mapping object to the pipeline as it's processed.

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

Specifies the domain FQDN (e.g., 'corp.domain.com') to append to any printer SMB paths that are not already fully qualified.

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
- A single XML file containing all printer configurations
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

- [Import-IvantiWCPrinterMapping](Import-IvantiWCPrinterMapping.md)
