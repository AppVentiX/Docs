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
title: Add-AppVentiXPackage
---

# Add-AppVentiXPackage

## SYNOPSIS

Adds an App-V or MSIX package to an AppVentiX machine group content share.

## SYNTAX

### __AllParameterSets

```
Add-AppVentiXPackage [-PackageFilename] <string> [[-MachineGroupFriendlyName] <string>]
 [[-ContentShare] <string>] [[-ConfigShare] <string>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,

## DESCRIPTION

The Add-AppVentiXPackage function adds an App-V (.appv) or MSIX (.msix) package to an AppVentiX machine group's content share.
It validates the package file, checks licensing, manages machine group associations, and copies the package to the appropriate content share location.

The function performs the following operations:
- Validates that the package file exists and has a supported extension (.appv or .msix)
- Verifies that AppVentiX is properly licensed
- Retrieves the specified machine group configuration
- Validates the content share configuration (handles single or multiple content shares)
- Extracts package metadata from the manifest
- Creates a destination folder and copies the package to the content share

## EXAMPLES

### EXAMPLE 1

Add-AppVentiXPackage -PackageFilename "C:\Packages\MyApp_1.0.0.0_x64.msix" -MachineGroupFriendlyName "Production"

Adds the MSIX package to the Production machine group's content share (assuming the machine group has only one content share defined).

### EXAMPLE 2

Add-AppVentiXPackage -PackageFilename "C:\Packages\MyApp.appv" -MachineGroupFriendlyName "Development" -ContentShare "\\server\dev-packages"

Adds the App-V package to the Development machine group's specific content share when multiple content shares are defined.

### EXAMPLE 3

Add-AppVentiXPackage -PackageFilename "C:\Packages\Office365_16.0.12345.msix" -MachineGroup "All"

Adds the Office 365 MSIX package to the "All" machine group using the MachineGroup alias parameter.

## PARAMETERS

### -ConfigShare

Specifies the AppVentiX configuration share path.
By default, uses the configuration share from the module's current session variable.
This parameter is hidden from normal parameter discovery.

```yaml
Type: System.String
DefaultValue: $Script:AppVentix.ConfigShare
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

### -ContentShare

Specifies the content share path when the machine group has multiple content shares defined.
This parameter is required when the machine group has more than one content share.
If omitted and only one content share exists, that content share will be used automatically.

```yaml
Type: System.String
DefaultValue: ''
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

### -MachineGroupFriendlyName

Specifies the friendly name of the machine group to which the package will be added.
This parameter has aliases: MachineGroup, FriendlyName

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases:
- MachineGroup
- FriendlyName
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

### -PackageFilename

Specifies the full path to the App-V or MSIX package file to add.
The file must exist and have either a .appv or .msix extension.

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

Function    : Add-AppVentiXPackage
Author      : John Billekens
Copyright   : (c) John Billekens Consultancy & AppVentiX
Version     : 2026.130.1000
Requires    : Valid AppVentiX license


## RELATED LINKS

- [Get-AppVentiXContentSharePackages](Get-AppVentiXContentSharePackages.md)
- [New-AppVentiXConnectionGroup](New-AppVentiXConnectionGroup.md)
- [Get-AppVentiXMachineGroup](Get-AppVentiXMachineGroup.md)
- [New-AppVentiXPublishingTask](New-AppVentiXPublishingTask.md)
