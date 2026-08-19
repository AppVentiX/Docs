---
category: license
category_title: License Commands
document type: cmdlet
external help file: AppVentiX-Help.xml
HelpUri: ''
Locale: en-US
Module Name: AppVentiX
module_version: 2026.818.1700
ms.date: 08-19-2026
PlatyPS schema version: 2024-05-01
title: Get-AppVentiXLicence
---

# Get-AppVentiXLicence

## SYNOPSIS

Retrieves the details of the AppVentiX license.

## SYNTAX

### ConfigShare (Default)

```
Get-AppVentiXLicence [-ConfigShare <string>] [<CommonParameters>]
```

### License

```
Get-AppVentiXLicence -Filename <FileInfo> [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,

## DESCRIPTION

The Get-AppVentiXLicence function retrieves the details of the AppVentiX license.
It can retrieve the license details from a specified license file or from the default configuration share.

## EXAMPLES

### EXAMPLE 1

Get-AppVentiXLicence -ConfigShare "\\fileserver.domain.local\config"
Retrieves the license details from the specified configuration share.

### EXAMPLE 2

Get-AppVentiXLicence -Filename "C:\Temp\AppVentiX.lic"
Retrieves the license details from the specified license file.

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
- Name: ConfigShare
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Filename

Specifies the path to an AppVentiX.lic license file to read directly.
The path must point to a valid AppVentiX.lic file.

```yaml
Type: System.IO.FileInfo
DefaultValue: ''
SupportsWildcards: false
Aliases:
- File
- License
ParameterSets:
- Name: License
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

- [Test-AppVentiXIsLicensed](Test-AppVentiXIsLicensed.md)
- [Update-AppVentiXLicence](Update-AppVentiXLicence.md)
- [Get-AppVentiXConfigShare](Get-AppVentiXConfigShare.md)
