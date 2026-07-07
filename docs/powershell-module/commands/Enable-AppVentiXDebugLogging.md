---
category: diagnostics
category_title: Diagnostics Commands
document type: cmdlet
external help file: AppVentiX-Help.xml
HelpUri: ''
Locale: en-US
Module Name: AppVentiX
module_version: 2026.707.1700
ms.date: 07-07-2026
PlatyPS schema version: 2024-05-01
title: Enable-AppVentiXDebugLogging
---

# Enable-AppVentiXDebugLogging

## SYNOPSIS

Enables AppVentiX PowerShell debug logging.

## SYNTAX

### __AllParameterSets

```
Enable-AppVentiXDebugLogging [-Path] <string> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,

## DESCRIPTION

Turns on debug logging for the AppVentiX module.
When enabled, crucial steps in supported
functions are written as JSON Lines (JSONL) to 'AppVentiX-PS-Debug.jsonl' in the directory
specified by -Path.
Each entry records a timestamp, the elapsed milliseconds since the
previous entry, the calling function, a message, and optional structured data.

This is separate from the AppVentiX audit log.
It is intended for troubleshooting and
performance analysis (for example, identifying slow steps during package import).

Logging stays enabled for the current PowerShell session until Disable-AppVentiXDebugLogging
is called or the session ends.
The state is held in module scope, not in a global variable.

## EXAMPLES

### EXAMPLE 1

Enable-AppVentiXDebugLogging -Path 'C:\Temp'

Enables debug logging and writes entries to 'C:\Temp\AppVentiX-PS-Debug.jsonl'.

## PARAMETERS

### -Confirm

Prompts you for confirmation before running the cmdlet.

```yaml
Type: System.Management.Automation.SwitchParameter
DefaultValue: ''
SupportsWildcards: false
Aliases:
- cf
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

### -Path

The directory where 'AppVentiX-PS-Debug.jsonl' will be written.
The directory is created
if it does not exist.

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

### -WhatIf

Runs the command in a mode that only reports what would happen without performing the actions.

```yaml
Type: System.Management.Automation.SwitchParameter
DefaultValue: ''
SupportsWildcards: false
Aliases:
- wi
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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutBuffer, -OutVariable, -PipelineVariable,
-ProgressAction, -Verbose, -WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

Function  : Enable-AppVentiXDebugLogging
Author    : John Billekens Consultancy
Copyright : Copyright (c) AppVentiX
Version   : 1.0
Requires  : Valid AppVentiX license


## RELATED LINKS

- [Disable-AppVentiXDebugLogging](Disable-AppVentiXDebugLogging.md)
