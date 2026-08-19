---
category: machine-group
category_title: Machine Group Commands
document type: cmdlet
external help file: AppVentiX-Help.xml
HelpUri: ''
Locale: en-US
Module Name: AppVentiX
module_version: 2026.818.1700
ms.date: 08-19-2026
PlatyPS schema version: 2024-05-01
title: Get-AppVentiXMachineGroup
---

# Get-AppVentiXMachineGroup

## SYNOPSIS

Retrieves the machine groups from the AppVentiX configuration.

## SYNTAX

### All (Default)

```
Get-AppVentiXMachineGroup [-ConfigShare <string>] [<CommonParameters>]
```

### Named

```
Get-AppVentiXMachineGroup -Name <string[]> [-ConfigShare <string>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,

## DESCRIPTION

The Get-AppVentiXMachineGroup function retrieves the machine groups from the AppVentiX config share.
It can retrieve all machine groups or a specific machine group by name.

## EXAMPLES

### EXAMPLE 1

Get-AppVentiXMachineGroup
Retrieves all machine groups from the AppVentiX configuration.

### EXAMPLE 2

Get-AppVentiXMachineGroup -Name 'Group1'
Retrieves the machine group with the name 'Group1' from the AppVentiX configuration.

## PARAMETERS

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

### -Name

(Optional) Specifies the name of the machine group to retrieve.

```yaml
Type: System.String[]
DefaultValue: ''
SupportsWildcards: false
Aliases:
- FriendlyName
- MachineGroupFriendlyName
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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutBuffer, -OutVariable, -PipelineVariable,
-ProgressAction, -Verbose, -WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## RELATED LINKS

- [Add-AppVentiXPackage](Add-AppVentiXPackage.md)
- [New-AppVentiXPublishingTask](New-AppVentiXPublishingTask.md)
- [Get-AppVentiXPublishingTask](Get-AppVentiXPublishingTask.md)
- [New-AppVentiXConnectionGroup](New-AppVentiXConnectionGroup.md)
