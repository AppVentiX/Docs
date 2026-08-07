---
category: license
category_title: License Commands
document type: cmdlet
external help file: AppVentiX-Help.xml
HelpUri: ''
Locale: en-US
Module Name: AppVentiX
module_version: 2026.806.1845
ms.date: 08-07-2026
PlatyPS schema version: 2024-05-01
title: Test-AppVentiXIsLicensed
---

# Test-AppVentiXIsLicensed

## SYNOPSIS

Checks if the AppVentiX license is valid.

## SYNTAX

### __AllParameterSets

```
Test-AppVentiXIsLicensed [[-ConfigShare] <string>] [-Force] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,

## DESCRIPTION

The Test-AppVentiXIsLicensed function checks if the AppVentiX license is valid.
It retrieves the license details and compares the expiration date with the current date.
If the license is expired or about to expire within 30 days, a warning message is displayed.
If the license is valid, the function returns $true; otherwise, it returns $false.

## EXAMPLES

### EXAMPLE 1

Test-AppVentiXIsLicensed -ConfigShare "\\fileserver.domain.local\config" -Force
Checks if the license is valid for the AppVentiX configuration share "\\fileserver.domain.local\config" and forces the validation.

## PARAMETERS

### -ConfigShare

Specifies the path to the AppVentiX configuration share.
You can omit this parameter if the configuration store was already set with Set-AppVentiXConfigShare,
or when it can be detected automatically (for example on a machine where AppVentiX Central View is installed and configured).

```yaml
Type: System.String
DefaultValue: $Script:AppVentix.ConfigShare
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

### -Force

Forces the license validation even if it has already been validated.

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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutBuffer, -OutVariable, -PipelineVariable,
-ProgressAction, -Verbose, -WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.Boolean

## NOTES

Function : Test-AppVentiXIsLicensed
Author   : John Billekens
Copyright: (c) John Billekens Consultancy & AppVentiX
Version  : 2026.130.1000
Requires : Valid AppVentiX license


## RELATED LINKS

- [Get-AppVentiXLicence](Get-AppVentiXLicence.md)
- [Update-AppVentiXLicence](Update-AppVentiXLicence.md)
- [Get-AppVentiXConfigShare](Get-AppVentiXConfigShare.md)
