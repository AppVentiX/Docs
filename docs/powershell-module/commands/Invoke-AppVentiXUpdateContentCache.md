---
category: uncategorized
category_title: Other Commands
document type: cmdlet
external help file: AppVentiX-Help.xml
HelpUri: ''
Locale: en-US
Module Name: AppVentiX
module_version: 2026.1117.2000
ms.date: 11-17-2026
PlatyPS schema version: 2024-05-01
title: Invoke-AppVentiXUpdateContentCache
---

# Invoke-AppVentiXUpdateContentCache

## SYNOPSIS

Updates the AppVentiX Central View content cache of a site.

## SYNTAX

### __AllParameterSets

```
Invoke-AppVentiXUpdateContentCache [[-SiteName] <string>] [[-SiteGuid] <string>]
 [[-ContentShare] <string[]>] [[-MachineGroupFriendlyName] <string>] [[-LogPath] <string>]
 [[-TimeoutMinutes] <int>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,

## DESCRIPTION

The Invoke-AppVentiXUpdateContentCache function runs AppVentiX Central View with
-updatecontentcache to scan the Content Stores of a site and publish the inventory.
Central
View writes a ContentCache.json to each Content Store (in the root, or in a ContentCache
folder when the root is not writable) and logs to
%ProgramData%\AppVentiX-CentralView\Logs\ContentCacheUpdate.log.

This only works on the machine where AppVentiX Central View is installed and configured.

Without -SiteName or -SiteGuid the site of the current Configuration Store is used.
Without
-ContentShare or -MachineGroupFriendlyName all Content Stores of the site are updated.

Returns the summary from Central View, the per Content Store results are in its 'shares'
property.
Any exit code other than 0 throws a terminating error, the summary (when Central View
returned one) is in the TargetObject of the error.

    1  A Content Store failed
    2  Configuration, access or license problem
    3  Skipped, another console published a newer inventory
    4  Several sites found and no settings file given
    5  Timed out

## EXAMPLES

### EXAMPLE 1

Invoke-AppVentiXUpdateContentCache

Updates all Content Stores of the site of the current Configuration Store.

### EXAMPLE 2

Invoke-AppVentiXUpdateContentCache -SiteName 'Azure' -ContentShare '\\fs01.domain.local\Content$'

### EXAMPLE 3

$result = Invoke-AppVentiXUpdateContentCache -MachineGroupFriendlyName 'VDI' -TimeoutMinutes 30
$result.shares

### EXAMPLE 4

try {
    Invoke-AppVentiXUpdateContentCache -LogPath 'C:\Temp\ContentCache.log'
} catch {
    $_.TargetObject.shares
}

Shows the per Content Store results when the update failed.

## PARAMETERS

### -ContentShare

One or more Content Store paths to update, instead of all Content Stores of the site.

```yaml
Type: System.String[]
DefaultValue: ''
SupportsWildcards: false
Aliases:
- ContentStore
- Share
ParameterSets:
- Name: (All)
  Position: 2
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -LogPath

Path of a log file for Central View to write to.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 4
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -MachineGroupFriendlyName

Updates the Content Stores of this Machine Group, use 'All Machine Groups' for all Machine
Groups.
Can be combined with -ContentShare.
Only available for the site of the current
Configuration Store.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases:
- MachineGroup
- FriendlyName
ParameterSets:
- Name: (All)
  Position: 3
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -SiteGuid

The SiteGuid of the site to update, see Get-AppVentiXSite.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases:
- Guid
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

### -SiteName

The SiteName of the site to update, see Get-AppVentiXSite.
Use 'Default' for the default site.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases:
- Name
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

### -TimeoutMinutes

Maximum duration of the update in minutes.
Central View uses 120 minutes by default.

```yaml
Type: System.Int32
DefaultValue: 0
SupportsWildcards: false
Aliases:
- Timeout
ParameterSets:
- Name: (All)
  Position: 5
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

### System.Management.Automation.PSObject

## RELATED LINKS

- [Get-AppVentiXContentStorePackage](Get-AppVentiXContentStorePackage.md)
- [Get-AppVentiXSite](Get-AppVentiXSite.md)
