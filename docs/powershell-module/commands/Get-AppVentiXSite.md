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
title: Get-AppVentiXSite
---

# Get-AppVentiXSite

## SYNOPSIS

Retrieves the AppVentiX sites configured in Central View.

## SYNTAX

### All (Default)

```
Get-AppVentiXSite [-Path <string>] [<CommonParameters>]
```

### Named

```
Get-AppVentiXSite -Name <string[]> [-Path <string>] [<CommonParameters>]
```

### SiteGuid

```
Get-AppVentiXSite -SiteGuid <string[]> [-Path <string>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,

## DESCRIPTION

The Get-AppVentiXSite function reads the Central View settings files (Settings*.xml) and
returns one object per site.
Central View can manage multiple sites, each pointing to its
own Configuration Store, so this data is only available on the machine where AppVentiX
Central View is installed and configured.

## EXAMPLES

### EXAMPLE 1

Get-AppVentiXSite

Retrieves all sites configured in AppVentiX Central View on the local machine.

### EXAMPLE 2

Get-AppVentiXSite -Name 'Customer B'

### EXAMPLE 3

Get-AppVentiXSite -SiteGuid '684552ee-7c5c-4e4a-b2b6-6597a6e24bda'

## PARAMETERS

### -Name

(Optional) Specifies the SiteName of the site to retrieve.

```yaml
Type: System.String[]
DefaultValue: ''
SupportsWildcards: false
Aliases:
- SiteName
ParameterSets:
- Name: Named
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Path

Specifies the path to a Central View settings file.
Only the parent folder is used, all
Settings*.xml files in that folder are read.
Defaults to the Central View settings file in
the local ProgramData folder.

```yaml
Type: System.String
DefaultValue: $Script:AppVentiX.CentralViewSettingsFilename
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

### -SiteGuid

(Optional) Specifies the SiteGuid of the site to retrieve.

```yaml
Type: System.String[]
DefaultValue: ''
SupportsWildcards: false
Aliases:
- Guid
ParameterSets:
- Name: SiteGuid
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

### System.Management.Automation.PSObject

## RELATED LINKS

- [Set-AppVentiXSite](Set-AppVentiXSite.md)
- [Get-AppVentiXConfigShare](Get-AppVentiXConfigShare.md)
- [Set-AppVentiXConfigShare](Set-AppVentiXConfigShare.md)
