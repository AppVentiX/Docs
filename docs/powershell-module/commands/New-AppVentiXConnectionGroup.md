---
category: package
category_title: Package Commands
document type: cmdlet
external help file: AppVentiX-Help.xml
HelpUri: ''
Locale: en-US
Module Name: AppVentiX
module_version: 2026.806.1845
ms.date: 08-07-2026
PlatyPS schema version: 2024-05-01
title: New-AppVentiXConnectionGroup
---

# New-AppVentiXConnectionGroup

## SYNOPSIS

Creates a new App-V Connection Group XML file (.appg) from specified App-V packages and saves it to a content share.

## SYNTAX

### __AllParameterSets

```
New-AppVentiXConnectionGroup [-Packages] <psobject[]> [[-ConnectionGroupName] <string>]
 [[-MachineGroupFriendlyName] <string>] [[-ContentShare] <string>] [[-Priority] <int>]
 [[-ConfigShare] <string>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,

## DESCRIPTION

The New-AppVentiXConnectionGroup function creates a new App-V Connection Group XML file (.appg)
from a specified collection of App-V packages.
Connection Groups allow multiple virtual applications
to interact with each other in the same virtual environment.
The function validates each package,
extracts manifest information, and generates the connection group file in the appropriate content share
for the specified Machine Group or a custom content share location.

## EXAMPLES

### EXAMPLE 1

$packages = @(
    [PSCustomObject]@{ Path = "\\fileserver.domain.local\content\App1\App1.appv"; Optional = $false },
    [PSCustomObject]@{ Path = "\\fileserver.domain.local\content\App2\App2.appv"; Optional = $true }
)
PS C:\> New-AppVentiXConnectionGroup -Packages $packages -MachineGroupFriendlyname "Production"

Creates a connection group containing App1 (required) and App2 (optional) for the Production machine group.

### EXAMPLE 2

$packages = @(
    [PSCustomObject]@{ Path = "\\fileserver.domain.local\content\Office\Office.appv"; Optional = $false; AnyVersion = $true },
    [PSCustomObject]@{ Path = "\\fileserver.domain.local\content\Plugin\Plugin.appv"; Optional = $false }
)
PS C:\> New-AppVentiXConnectionGroup -Packages $packages -MachineGroupFriendlyname "Development" -Priority 5

Creates a high-priority connection group where any version of Office can be used with a specific Plugin version.

## PARAMETERS

### -ConfigShare

The path to the AppVentiX configuration share.
This parameter is hidden and defaults to the
script-level ConfigShare variable.

```yaml
Type: System.String
DefaultValue: $Script:AppVentix.ConfigShare
SupportsWildcards: false
Aliases: []
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

### -ConnectionGroupName

The name of the connection group.
If not specified, a name will be automatically generated based on
the included package names and versions.
If provided without a "CG_" prefix, the prefix will be added automatically.

```yaml
Type: System.String
DefaultValue: ''
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

### -ContentShare

The path to the content share where the connection group file will be saved.
Required when MachineGroupFriendlyName
is 'All Machine Groups'.
Otherwise, automatically determined from the Machine Group configuration.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
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

### -MachineGroupFriendlyName

The friendly name of the Machine Group where the connection group will be created.
Defaults to 'All Machine Groups'.
When set to 'All Machine Groups', the ContentShare parameter must be specified.

```yaml
Type: System.String
DefaultValue: All Machine Groups
SupportsWildcards: false
Aliases: []
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

### -Packages

An array of PSCustomObject items representing the packages to include in the connection group.
Each object must have the following properties:
- Path: The full path to the .appv package file (must exist)
- Optional: Boolean indicating if the package is optional in the connection group
- AnyVersion (optional): Boolean indicating if any version of the package is acceptable

```yaml
Type: System.Management.Automation.PSObject[]
DefaultValue: '@()'
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

### -Priority

The priority of the connection group.
Default is 10.
Lower numbers indicate higher priority when resolving conflicts between connection groups.

```yaml
Type: System.Int32
DefaultValue: 10
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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutBuffer, -OutVariable, -PipelineVariable,
-ProgressAction, -Verbose, -WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

Function : New-AppVentiXConnectionGroup
Author   : John Billekens
Copyright: (c) John Billekens Consultancy & AppVentiX
Version  : 2026.130.1000
Requires : Valid AppVentiX license


## RELATED LINKS

- [Add-AppVentiXPackage](Add-AppVentiXPackage.md)
- [Get-AppVentiXContentSharePackages](Get-AppVentiXContentSharePackages.md)
- [Get-AppVentiXMachineGroup](Get-AppVentiXMachineGroup.md)
- [New-AppVentiXPublishingTask](New-AppVentiXPublishingTask.md)
