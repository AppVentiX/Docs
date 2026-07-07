---
category: configuration
category_title: Configuration Commands
document type: cmdlet
external help file: AppVentiX-Help.xml
HelpUri: ''
Locale: en-US
Module Name: AppVentiX
module_version: 2026.707.1700
ms.date: 07-07-2026
PlatyPS schema version: 2024-05-01
title: Set-AppVentiXConfigShare
---

# Set-AppVentiXConfigShare

## SYNOPSIS

Sets the path to the AppVentiX configuration share.

## SYNTAX

### Default (Default)

```
Set-AppVentiXConfigShare -ConfigShare <string> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Credential

```
Set-AppVentiXConfigShare -ConfigShare <string> -Credential <pscredential> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,

## DESCRIPTION

This function sets the path to the AppVentiX configuration share.
It checks if the specified path exists and has access.
If the path is valid and the AppVentiX license is valid, it sets the path as the configuration share.

## EXAMPLES

### EXAMPLE 1

Set-AppVentiXConfigShare -ConfigShare "\\fileserver.domain.local\config"

### EXAMPLE 2

Set-AppVentiXConfigShare -ConfigShare "\\fileserver.domain.local\config" -Credential (Get-Credential)

Maps the configuration share with the provided credentials before setting it as the default for the session.

## PARAMETERS

### -ConfigShare

Specifies the path to the AppVentiX configuration share.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: Credential
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: Default
  Position: Named
  IsRequired: true
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

### -Credential

Specifies the credentials used to map and access the configuration share.
When provided, the share is mapped with these credentials before it is set as the default for the session.

```yaml
Type: System.Management.Automation.PSCredential
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: Credential
  Position: Named
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

Function : Set-AppVentiXConfigShare
Author   : John Billekens
Copyright: (c) John Billekens Consultancy & AppVentiX
Version  : 2026.130.1000
Requires : Valid AppVentiX license


## RELATED LINKS

- [Get-AppVentiXConfigShare](Get-AppVentiXConfigShare.md)
- [Get-AppVentiXModuleVariable](Get-AppVentiXModuleVariable.md)
- [Set-AppVentiXADCredential](Set-AppVentiXADCredential.md)
- [Clear-AppVentiXADCredential](Clear-AppVentiXADCredential.md)
