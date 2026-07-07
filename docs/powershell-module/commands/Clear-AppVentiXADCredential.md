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
title: Clear-AppVentiXADCredential
---

# Clear-AppVentiXADCredential

## SYNOPSIS

Clears Active Directory credentials from the current PowerShell session.

## SYNTAX

### __AllParameterSets

```
Clear-AppVentiXADCredential [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,

## DESCRIPTION

The Clear-AppVentiXADCredential function removes previously set Active Directory credentials from the current PowerShell session.
It resets the PSDefaultParameterValues for all ADSI Active Directory functions by:
- Setting the Credential to an empty PSCredential object
- Resetting the Port to the default LDAP port (389)
- Clearing the Server parameter

This function is useful when you need to revert to default authentication behavior or when switching between different AD environments.
After calling this function, ADSI AD operations will use the current user's credentials and default connection settings.

## EXAMPLES

### EXAMPLE 1

Clear-AppVentiXADCredential

Clears all Active Directory credentials and connection settings from the current session.

### EXAMPLE 2

Set-AppVentiXADCredential -Credential (Get-Credential) -Server "dc01.domain.local"
PS C:\> # Perform some AD operations...
PS C:\> Clear-AppVentiXADCredential

Sets AD credentials for a specific domain controller, performs operations, then clears the credentials to revert to default behavior.

### EXAMPLE 3

Clear-AppVentiXADCredential -Verbose

Clears AD credentials with verbose output showing the clearing process.

## PARAMETERS

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutBuffer, -OutVariable, -PipelineVariable,
-ProgressAction, -Verbose, -WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

Function    : Clear-AppVentiXADCredential
Author      : John Billekens
Copyright   : (c) John Billekens Consultancy & AppVentiX
Version     : 2026.130.1000
Requires    : Valid AppVentiX license


## RELATED LINKS

- [Get-AppVentiXConfigShare](Get-AppVentiXConfigShare.md)
- [Set-AppVentiXConfigShare](Set-AppVentiXConfigShare.md)
- [Get-AppVentiXModuleVariable](Get-AppVentiXModuleVariable.md)
- [Set-AppVentiXADCredential](Set-AppVentiXADCredential.md)
