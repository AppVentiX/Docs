---
category: configuration
category_title: Configuration Commands
document type: cmdlet
external help file: AppVentiX-Help.xml
HelpUri: ''
Locale: en-US
Module Name: AppVentiX
module_version: 2026.806.1845
ms.date: 08-07-2026
PlatyPS schema version: 2024-05-01
title: Set-AppVentiXSite
---

# Set-AppVentiXSite

## SYNOPSIS

Selects an AppVentiX Central View site as the active Configuration Store for this session.

## SYNTAX

### SiteGuid (Default)

```
Set-AppVentiXSite [-SiteGuid <string>] [<CommonParameters>]
```

### InputObject

```
Set-AppVentiXSite -InputObject <psobject> [<CommonParameters>]
```

### Name

```
Set-AppVentiXSite -Name <string> [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,

## DESCRIPTION

The Set-AppVentiXSite function looks up an AppVentiX Central View site (by pipeline object,
name or GUID) and sets that site's Configurationshare as the active Configuration Store for
the session, using Set-AppVentiXConfigShare.

This is only useful on the machine where AppVentiX Central View is installed and configured,
see Get-AppVentiXSite.

## EXAMPLES

### EXAMPLE 1

Set-AppVentiXSite

Selects the default AppVentiX Central View site.

### EXAMPLE 2

Set-AppVentiXSite -Name 'Customer B'

### EXAMPLE 3

Get-AppVentiXSite | Where-Object SiteName -EQ 'Azure' | Set-AppVentiXSite

## PARAMETERS

### -InputObject

A site object as returned by Get-AppVentiXSite.

```yaml
Type: System.Management.Automation.PSObject
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: InputObject
  Position: Named
  IsRequired: true
  ValueFromPipeline: true
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Name

The SiteName of the site to select.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases:
- SiteName
ParameterSets:
- Name: Name
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -SiteGuid

The SiteGuid of the site to select.
When omitted (the default), the default site is
selected, i.e.
the site that has no SiteGuid.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases:
- Guid
ParameterSets:
- Name: SiteGuid
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

### System.Management.Automation.PSObject

## OUTPUTS

## NOTES

Function : Set-AppVentiXSite
Author   : John Billekens
Copyright: (c) John Billekens Consultancy & AppVentiX
Version  : 2026.804.1515
Requires : AppVentiX Central View installed


## RELATED LINKS

- [Get-AppVentiXSite](Get-AppVentiXSite.md)
- [Get-AppVentiXConfigShare](Get-AppVentiXConfigShare.md)
- [Set-AppVentiXConfigShare](Set-AppVentiXConfigShare.md)
