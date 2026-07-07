---
category: package
category_title: Package Commands
document type: cmdlet
external help file: AppVentiX-Help.xml
HelpUri: ''
Locale: en-US
Module Name: AppVentiX
module_version: 2026.707.1700
ms.date: 07-07-2026
PlatyPS schema version: 2024-05-01
title: Get-AppVentiXContentSharePackages
---

# Get-AppVentiXContentSharePackages

## SYNOPSIS

Retrieves packages from the AppVentiX content shares.

## SYNTAX

### All (Default)

```
Get-AppVentiXContentSharePackages [-IncludeDependencies] [-CachePackages] [-ThrottleLimit <int>]
 [-ConfigShare <string>] [<CommonParameters>]
```

### Named

```
Get-AppVentiXContentSharePackages [-MachineGroupFriendlyName <string>] [-IncludeDependencies]
 [-CachePackages] [-ThrottleLimit <int>] [-ConfigShare <string>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,

## DESCRIPTION

The Get-AppVentiXContentSharePackages function scans the content shares configured for machine groups
and retrieves information about App-V (.appv), MSIX (.msix), and connection group (.appg) packages.
It returns package details including name, version, publisher, and connection group membership.

## EXAMPLES

### EXAMPLE 1

Get-AppVentiXContentSharePackages
Retrieves all packages from all machine group content shares.

### EXAMPLE 2

Get-AppVentiXContentSharePackages -MachineGroupFriendlyName 'Production'
Retrieves packages from the content shares of the 'Production' machine group.

### EXAMPLE 3

Get-AppVentiXContentSharePackages -IncludeDependencies
Retrieves all packages including those in Dependencies folders.

## PARAMETERS

### -CachePackages

(Optional) When specified, package manifest identity fields are cached in memory for the
duration of the PowerShell session and reused on subsequent calls, avoiding a re-read of
packages that have not changed.
The cache is keyed on the file path together with its last
write time and size, so a repackaged file (new content) is always re-read.
The cache is
module-scoped (not accessible outside the module) and is cleared when the module is
reimported.
Off by default.

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

### -ConfigShare

Specifies the path to the AppVentiX configuration share.
You can omit this parameter if Set-AppVentiXConfigShare has been called.

```yaml
Type: System.String
DefaultValue: $Script:AppVentiX.ConfigShare
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: Named
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: All
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -IncludeDependencies

(Optional) When specified, includes packages located in Dependencies folders.
By default, dependency packages are excluded from the results.

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

### -MachineGroupFriendlyName

(Optional) Specifies the friendly name of the machine group to retrieve packages from.
If not specified, packages from all machine groups are retrieved.

```yaml
Type: System.String
DefaultValue: All Machine Groups
SupportsWildcards: false
Aliases:
- FriendlyName
ParameterSets:
- Name: Named
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -ThrottleLimit

(Optional) Specifies the maximum number of package manifests to read concurrently from the
content share.
Reading a manifest opens the package archive over the (usually remote) share,
so scanning is network-latency bound and benefits from parallelism.
Defaults to 16.
Increase on high-latency shares; decrease to reduce load on the file server.

```yaml
Type: System.Int32
DefaultValue: 16
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

## NOTES

Function : Get-AppVentiXContentSharePackages
Author   : John Billekens
Copyright: (c) John Billekens Consultancy & AppVentiX
Version  : 2026.707.1400
Requires : Valid AppVentiX license


## RELATED LINKS

- [Add-AppVentiXPackage](Add-AppVentiXPackage.md)
- [New-AppVentiXConnectionGroup](New-AppVentiXConnectionGroup.md)
- [Get-AppVentiXMachineGroup](Get-AppVentiXMachineGroup.md)
- [New-AppVentiXPublishingTask](New-AppVentiXPublishingTask.md)
