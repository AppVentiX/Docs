---
category: configuration
category_title: Configuration Commands
document type: cmdlet
external help file: AppVentiX-Help.xml
HelpUri: ''
Locale: en-US
Module Name: AppVentiX
module_version: 2026.818.1700
ms.date: 08-19-2026
PlatyPS schema version: 2024-05-01
title: Connect-AppVentiXAzureBlobStore
---

# Connect-AppVentiXAzureBlobStore

## SYNOPSIS

Signs in to an Azure Blob Configuration Store.

## SYNTAX

### __AllParameterSets

```
Connect-AppVentiXAzureBlobStore [[-ConfigShare] <string>] [-ForceLogin] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,

## DESCRIPTION

This function is the Azure Blob equivalent of 'Set-AppVentiXConfigShare -Credential
(Get-Credential)' for an SMB store: it establishes the session's access to the
Configuration Store, here via an interactive Entra ID device-code sign-in instead of a
credential.
The resulting token is cached DPAPI-encrypted per user, so subsequent sessions
pick it up silently and only need to sign in again once it can no longer be refreshed.

No other function in this module prompts interactively for Azure sign-in - reads and writes
against an Azure Blob store only ever use a cached/silently-refreshed token, and fail with a
pointer back to this function when none is available.
Run this once per machine/user (or
again with -ForceLogin to switch accounts).

## EXAMPLES

### EXAMPLE 1

Connect-AppVentiXAzureBlobStore -ConfigShare "azure://appventix/publishing"

### EXAMPLE 2

Connect-AppVentiXAzureBlobStore -ForceLogin

## PARAMETERS

### -ConfigShare

Specifies the path to the Azure Blob Configuration Store ('azure://<account>/<container>').
Defaults to the currently configured store.

```yaml
Type: System.String
DefaultValue: $Script:AppVentiX.ConfigShare
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

### -ForceLogin

Ignores any cached token and forces a fresh interactive sign-in.

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

### System.Boolean

## RELATED LINKS

- [Set-AppVentiXConfigShare](Set-AppVentiXConfigShare.md)
