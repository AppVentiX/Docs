---
category: migration-appv
category_title: App-V Management Migration
document type: cmdlet
external help file: AppVentiX-Help.xml
HelpUri: ''
Locale: en-US
Module Name: AppVentiX
module_version: 2026.806.1845
ms.date: 08-07-2026
PlatyPS schema version: 2024-05-01
title: Import-AppVManagementPackage
---

# Import-AppVManagementPackage

## SYNOPSIS

Imports App-V Management packages into AppVentiX as publishing tasks.

## SYNTAX

### MatchWithMachineGroup (Default)

```
Import-AppVManagementPackage -MatchPackageWithMachineGroup [-SQLServer <string>]
 [-SQLInstance <string>] [-SQLDatabase <string>] [-SQLCredential <pscredential>]
 [-PublishingMachineGroupFriendlyName <string[]>] [-GUI] [-CachePackages] [-ThrottleLimit <int>]
 [-ConfigShare <string>] [<CommonParameters>]
```

### MachineGroupName

```
Import-AppVManagementPackage -MachineGroupFriendlyName <string> [-SQLServer <string>]
 [-SQLInstance <string>] [-SQLDatabase <string>] [-SQLCredential <pscredential>]
 [-PublishingMachineGroupFriendlyName <string[]>] [-GUI] [-CachePackages] [-ThrottleLimit <int>]
 [-ConfigShare <string>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,

## DESCRIPTION

Import-AppVManagementPackage retrieves packages from an App-V Management SQL database and converts them into
AppVentiX publishing tasks.
The function matches package URLs against the configured AppVentiX Content Stores
and optionally associates packages with the appropriate Machine Groups based on Content Store location.
The target Machine Group can be resolved automatically (-MatchPackageWithMachineGroup) or pinned to a specific
group (-MachineGroupFriendlyName), and the group(s) a package is published to can be set independently with
-PublishingMachineGroupFriendlyName.
If a Deployment Configuration XML is present in the database, it is saved as an .appd file alongside the package.

## EXAMPLES

### EXAMPLE 1

Import-AppVManagementPackage

Imports all enabled App-V packages from the local SQL Server ('localhost', database 'AppVManagement')
and publishes them to All Machine Groups.

### EXAMPLE 2

Import-AppVManagementPackage -SQLServer 'sql01' -SQLDatabase 'AppVManagement' -MatchPackageWithMachineGroup

Imports all enabled App-V packages from SQL Server 'sql01' and associates each package with the corresponding
AppVentiX Machine Group based on its Content Store location.

### EXAMPLE 3

Import-AppVManagementPackage -SQLServer 'sql01' -GUI -MatchPackageWithMachineGroup

Displays a selection window listing all available packages so the user can choose which ones to import,
then associates them with the appropriate Machine Group.

## PARAMETERS

### -CachePackages

When specified, package manifest identity fields read from the Content Stores are cached in memory for
the duration of the PowerShell session and reused on subsequent runs, so unchanged packages are not
re-read.
The cache is keyed on file path, last write time and size (a repackaged file is always
re-read), is module-scoped, and is cleared when the module is reimported.
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

Internal parameter.
Points to the AppVentiX configuration share path.
Automatically populated from the
module configuration and does not normally need to be specified manually.

```yaml
Type: System.String
DefaultValue: $Script:AppVentiX.ConfigShare
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

### -GUI

When specified, displays a graphical selection window allowing the user to manually choose which packages
to import.

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

The friendly name of the AppVentiX Machine Group the packages are matched to.
If not specified,
packages are matched to All Machine Groups.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: MachineGroupName
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -MatchPackageWithMachineGroup

When specified, attempts to match each package to the appropriate AppVentiX Machine Group based on its
Content Store location.
If no match is found, the package is published to all Machine Groups.

```yaml
Type: System.Management.Automation.SwitchParameter
DefaultValue: False
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: MatchWithMachineGroup
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -PublishingMachineGroupFriendlyName

The friendly name(s) of the AppVentiX Machine Group(s) to which the packages are published.
If not specified,
packages are published to the same Machine Group as matched by the Content Store location.

```yaml
Type: System.String[]
DefaultValue: ''
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

### -SQLCredential

A PSCredential object for SQL Server authentication.
Use [System.Management.Automation.PSCredential]::Empty
for Windows authentication (default).

```yaml
Type: System.Management.Automation.PSCredential
DefaultValue: '[System.Management.Automation.PSCredential]::Empty'
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

### -SQLDatabase

The name of the App-V Management database.
Default: 'AppVManagement'.

```yaml
Type: System.String
DefaultValue: AppVManagement
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

### -SQLInstance

The SQL Server instance name (optional).
Leave empty for the default instance.

```yaml
Type: System.String
DefaultValue: ''
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

### -SQLServer

The name or IP address of the SQL Server hosting the App-V Management database.
Default: 'localhost'.

```yaml
Type: System.String
DefaultValue: localhost
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

### -ThrottleLimit

The maximum number of package manifests to read concurrently from the Content Stores when retrieving
AppVentiX Content Store packages.
Reading manifests over a (usually remote) share is network-latency
bound and benefits from parallelism.
Default: 16.
Increase on high-latency shares; decrease to reduce
load on the file server.

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

### System.Management.Automation.PSObject

## NOTES

Function    : Import-AppVManagementPackage
Author      : John Billekens
Copyright   : (c) John Billekens Consultancy & AppVentiX
    Version  : 2026.721.2230
Requires    : SqlServer PowerShell module


## RELATED LINKS

- [Test-AppVManagementSQLConnection](Test-AppVManagementSQLConnection.md)
- [Get-AppVManagementPackage](Get-AppVManagementPackage.md)
- [Get-AppVManagementConnectionGroup](Get-AppVManagementConnectionGroup.md)
- [Import-AppVManagementConnectionGroup](Import-AppVManagementConnectionGroup.md)
- [New-AppVentiXPublishingTask](New-AppVentiXPublishingTask.md)
- [New-AppVentiXConnectionGroup](New-AppVentiXConnectionGroup.md)
