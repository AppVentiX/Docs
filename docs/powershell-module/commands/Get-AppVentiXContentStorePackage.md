---
category: package
category_title: Package Commands
document type: cmdlet
external help file: AppVentiX-Help.xml
HelpUri: ''
Locale: en-US
Module Name: AppVentiX
module_version: 2026.818.1700
ms.date: 08-19-2026
PlatyPS schema version: 2024-05-01
title: Get-AppVentiXContentStorePackage
---

# Get-AppVentiXContentStorePackage

## SYNOPSIS

Retrieves packages from the AppVentiX content shares.

## SYNTAX

### All (Default)

```
Get-AppVentiXContentStorePackage [-IncludeDependencies] [-ListOnly] [-CachePackages]
 [-ThrottleLimit <int>] [-ConfigShare <string>] [<CommonParameters>]
```

### Named

```
Get-AppVentiXContentStorePackage [-MachineGroupFriendlyName <string>] [-IncludeDependencies]
 [-ListOnly] [-CachePackages] [-ThrottleLimit <int>] [-ConfigShare <string>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,

## DESCRIPTION

The Get-AppVentiXContentStorePackage function scans the content shares configured for machine groups
and retrieves information about App-V (.appv), MSIX (.msix), and connection group (.appg) packages.
It returns package details including name, version, publisher, and connection group membership.

Content shares may be SMB paths or 'azure://<account>/<container>[/<prefix>]' Azure Blob paths.
For an Azure content share, manifest reads download each package to a local temp file first
(a ZIP archive needs a local, seekable file to open), so scanning many/large packages over
an Azure content share is slower than over SMB.

## EXAMPLES

### EXAMPLE 1

Get-AppVentiXContentStorePackage
Retrieves all packages from all machine group content shares.

### EXAMPLE 2

Get-AppVentiXContentStorePackage -MachineGroupFriendlyName 'Production'
Retrieves packages from the content shares of the 'Production' machine group.

### EXAMPLE 3

Get-AppVentiXContentStorePackage -IncludeDependencies
Retrieves all packages including those in Dependencies folders.

### EXAMPLE 4

Get-AppVentiXContentStorePackage -ListOnly
Lists Type/Filename/Fullname for every package without opening any manifests.

## PARAMETERS

### -CachePackages

(Optional) When specified, package manifest identity fields are cached in memory for the
duration of the PowerShell session and reused on subsequent calls, avoiding a re-read of
packages that have not changed.
The cache is keyed on the file name together with its last
write time and size, so a repackaged file (new content) is always re-read, and identical
files synced across multiple content shares are only read once.
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
You can omit this parameter if the configuration store was already set with Set-AppVentiXConfigShare,
or when it can be detected automatically (for example on a machine where AppVentiX Central View is installed and configured).

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

### -ListOnly

(Optional) When specified, only lists what is present (Type, Filename, Fullname,
MachineGroup, LastUpdated) - manifests are not opened and connection groups are not
resolved, so Name/Version/Publisher/PackageId/VersionId/MemberOf stay empty.
This skips
every manifest/connection-group read (for an Azure content share, the per-package temp
download too), so it is much faster when you only need to see what packages exist.

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

## RELATED LINKS

- [Add-AppVentiXPackage](Add-AppVentiXPackage.md)
- [New-AppVentiXConnectionGroup](New-AppVentiXConnectionGroup.md)
- [Get-AppVentiXMachineGroup](Get-AppVentiXMachineGroup.md)
- [New-AppVentiXPublishingTask](New-AppVentiXPublishingTask.md)
