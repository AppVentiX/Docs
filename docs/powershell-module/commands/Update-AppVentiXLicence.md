---
category: license
category_title: License Commands
document type: cmdlet
external help file: AppVentiX-Help.xml
HelpUri: ''
Locale: en-US
Module Name: AppVentiX
module_version: 2026.707.1700
ms.date: 07-07-2026
PlatyPS schema version: 2024-05-01
title: Update-AppVentiXLicence
---

# Update-AppVentiXLicence

## SYNOPSIS

Updates the AppVentiX license file on the configuration share.

## SYNTAX

### __AllParameterSets

```
Update-AppVentiXLicence [-LicenseFilename] <string> [[-ConfigShare] <string>] [-Force]
 [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,

## DESCRIPTION

Update-AppVentiXLicence copies a new license file to the AppVentiX configuration share, replacing the
existing 'AppVentiX.lic' file.
If a license file already exists and the -Force switch is not specified,
the function issues a warning and returns the current license details without overwriting.
After a successful copy, the updated license details are returned.

## EXAMPLES

### EXAMPLE 1

Update-AppVentiXLicence -LicenseFilename 'C:\Temp\AppVentiX.lic'

Copies the specified license file to the configuration share.
If a license file already exists, a warning
is displayed and the current license details are returned without overwriting.

### EXAMPLE 2

Update-AppVentiXLicence -LicenseFilename 'C:\Temp\AppVentiX.lic' -Force

Copies the specified license file to the configuration share, overwriting any existing license file.

### EXAMPLE 3

Update-AppVentiXLicence -LicenseFilename 'C:\Temp\AppVentiX.lic' -ConfigShare '\\fileserver.domain.local\config'

Installs the license on the specified configuration share.

## PARAMETERS

### -ConfigShare

Internal parameter.
Points to the AppVentiX configuration share path.
Automatically populated from the
module configuration and does not normally need to be specified manually.

```yaml
Type: System.String
DefaultValue: $Script:AppVentix.ConfigShare
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

### -Force

When specified, overwrites an existing license file on the configuration share without prompting.

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

### -LicenseFilename

The full path to the new license file to be deployed.
The file must be accessible from the current session.

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

## NOTES

Function    : Update-AppVentiXLicence
Author      : John Billekens
Copyright   : (c) John Billekens Consultancy & AppVentiX
Version     : 2026.130.1000
Requires    : Valid AppVentiX license


## RELATED LINKS

- [Get-AppVentiXLicence](Get-AppVentiXLicence.md)
- [Test-AppVentiXIsLicensed](Test-AppVentiXIsLicensed.md)
- [Get-AppVentiXConfigShare](Get-AppVentiXConfigShare.md)
