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
title: Get-IvantiWCRegistry
---

# Get-IvantiWCRegistry

## SYNOPSIS

Reads and parses Ivanti Workspace Control registry sets from a Building Block XML file or a
standalone .reg file.

## SYNTAX

### __AllParameterSets

```
Get-IvantiWCRegistry [-Path] <string> [[-ExportFor] <string>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,

## DESCRIPTION

Accepts either:
- An Ivanti Workspace Control Building Block XML file: extracts every <registry type="registry">
  node, decodes the hex-encoded registryfile, and parses it.
Name and description are taken
  from the <name> and <description> XML elements.
- A standalone .reg file: parses it directly.
Name and description are read from the
  ;<PFNAME> and ;<PFDESC> comment tags if present.

Each value entry is returned as a structured object with its registry hive, key, value name,
value data, value type, and an optional per-value description captured from the ;<PF>...</PF>
comment tag that may follow the value line.

Supports all standard .reg value types:
- REG_SZ        (quoted string or hex(1):)
- REG_EXPAND_SZ (hex(2):)
- REG_BINARY    (hex: / hex(3):)
- REG_DWORD     (dword: / hex(4):)
- REG_MULTI_SZ  (hex(7):)
- REG_QWORD     (qword: / hex(b):)

## EXAMPLES

### EXAMPLE 1

# From a Building Block XML
Get-IvantiWCRegistry -Path 'C:\temp\LAB-BB.xml'

### EXAMPLE 2

# From a standalone .reg file, exported for AppVentiX
Get-IvantiWCRegistry -Path 'C:\temp\registry.reg' -ExportFor AppVentiX

## PARAMETERS

### -ExportFor

Target export format.
'AppVentiX' adds the AppVentiXParams property to each output object.

```yaml
Type: System.String
DefaultValue: AppVentiX
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

### -Path

Path to an Ivanti Workspace Control Building Block XML file or a standalone .reg file.

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

- [Import-IvantiWCRegistry](Import-IvantiWCRegistry.md)
