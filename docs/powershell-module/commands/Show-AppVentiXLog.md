---
category: diagnostics
category_title: Diagnostics Commands
document type: cmdlet
external help file: AppVentiX-Help.xml
HelpUri: ''
Locale: en-US
Module Name: AppVentiX
module_version: 2026.818.1700
ms.date: 08-19-2026
PlatyPS schema version: 2024-05-01
title: Show-AppVentiXLog
---

# Show-AppVentiXLog

## SYNOPSIS

Displays an AppVentiX JSONL log (debug log or audit trail) in a read-only grid.

## SYNTAX

### __AllParameterSets

```
Show-AppVentiXLog [[-LogType] <string>] [-Path <string>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,

## DESCRIPTION

Reads an AppVentiX JSONL log file and shows it in a Select-ObjectFromGrid window
using -ViewOnly.

With -LogType Debug (the default) it reads 'AppVentiX-PS-Debug.jsonl' written by
Write-AppVentiXDebugLog.
Each row shows Timestamp, MachineName, ElapsedMs,
ProcessId, Level, Function and Message.

With -LogType Audit it reads the audit trail ('AuditTrail.jsonl') written by the
AppVentiX console and this module.
Each row shows Timestamp, MachineName,
Username, Feature and Action.

For both types, the remaining fields (the debug log's structured fields, the
audit trail's Details text, and the Error block when present) are shown as an
expandable details panel that appears when a row is selected.

## EXAMPLES

### EXAMPLE 1

Show-AppVentiXLog

Shows the debug log from the currently configured debug log path.

### EXAMPLE 2

Show-AppVentiXLog -LogType Audit

Shows the audit trail from the connected Configuration Store.

### EXAMPLE 3

Show-AppVentiXLog -Path 'C:\Temp\AuditTrail.jsonl'

Shows that specific file; the log type (audit trail) is detected automatically
from the fields in the file.

### EXAMPLE 4

Show-AppVentiXLog -Path 'C:\Temp'

Shows 'C:\Temp\AppVentiX-PS-Debug.jsonl'.

## PARAMETERS

### -LogType

The log to show: Auto (default), Debug or Audit.

With Auto, the type is detected from the file given via -Path: first by the
fields present in the entries (Feature and Action mean an audit trail, Level and
ElapsedMs mean a debug log), then by the file name.
When -Path points to a
directory that only contains an audit trail, Audit is assumed.
Without -Path,
Auto shows the debug log.

```yaml
Type: System.String
DefaultValue: Auto
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 0
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Path

Either the directory containing the log file, or a direct path to a .jsonl file.
For -LogType Debug this defaults to the path from the current session's
Enable-AppVentiXDebugLogging call.
For -LogType Audit it defaults to the audit
folder of the connected Configuration Store.
If no default is available for the
chosen log type, Path is required.

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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutBuffer, -OutVariable, -PipelineVariable,
-ProgressAction, -Verbose, -WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## RELATED LINKS

- [Enable-AppVentiXDebugLogging](Enable-AppVentiXDebugLogging.md)
- Write-AppVentiXDebugLog
