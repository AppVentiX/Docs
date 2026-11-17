---
category: user-settings
category_title: User Settings Commands
document type: cmdlet
external help file: AppVentiX-Help.xml
HelpUri: ''
Locale: en-US
Module Name: AppVentiX
module_version: 2026.1117.2000
ms.date: 11-17-2026
PlatyPS schema version: 2024-05-01
title: Enable-AppVentiXUserSetting
---

# Enable-AppVentiXUserSetting

## SYNOPSIS

Enables one or more AppVentiX User Settings.

## SYNTAX

### __AllParameterSets

```
Enable-AppVentiXUserSetting [-Id] <guid[]> [[-ConfigShare] <string>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,

## DESCRIPTION

Enable-AppVentiXUserSetting sets the Enabled element of a User Setting to True.
User Settings created with an older version of AppVentiX Central View have no Enabled element
and are treated as enabled.
These are not changed.
A User Setting that is already enabled is not changed.

## EXAMPLES

### EXAMPLE 1

Enable-AppVentiXUserSetting -Id '37db88b4-f9f1-47bb-b913-f0538d94158c'

Enables one User Setting.

### EXAMPLE 2

Get-AppVentiXUserSettings | Where-Object { -not $_.Enabled } | Enable-AppVentiXUserSetting

Enables all disabled User Settings.

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

### -Confirm

Prompts you for confirmation before running the cmdlet.

```yaml
Type: System.Management.Automation.SwitchParameter
DefaultValue: ''
SupportsWildcards: false
Aliases:
- cf
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

### -Id

One or more User Setting Ids (GUID).
Accepts the Id property from the pipeline, e.g.
from
Get-AppVentiXUserSettings.

```yaml
Type: System.Guid[]
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 0
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: true
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -WhatIf

Runs the command in a mode that only reports what would happen without performing the actions.

```yaml
Type: System.Management.Automation.SwitchParameter
DefaultValue: ''
SupportsWildcards: false
Aliases:
- wi
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

### System.Guid[]

## OUTPUTS

## RELATED LINKS

- [Disable-AppVentiXUserSetting](Disable-AppVentiXUserSetting.md)
- [Get-AppVentiXUserSettings](Get-AppVentiXUserSettings.md)
