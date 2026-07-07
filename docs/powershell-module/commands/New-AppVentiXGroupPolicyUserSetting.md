---
category: user-settings
category_title: User Settings Commands
document type: cmdlet
external help file: AppVentiX-Help.xml
HelpUri: ''
Locale: en-US
Module Name: AppVentiX
module_version: 2026.707.1700
ms.date: 07-07-2026
PlatyPS schema version: 2024-05-01
title: New-AppVentiXGroupPolicyUserSetting
---

# New-AppVentiXGroupPolicyUserSetting

## SYNOPSIS

Creates an AppVentiX UserSetting XML file for a Group Policy configuration.

## SYNTAX

### InputObject

```
New-AppVentiXGroupPolicyUserSetting -InputObject <psobject> [-FriendlyName <string>]
 [-Description <string>] [-ExecutionOrder <int>] [-ProcessAtLogin <bool>] [-ProcessAtRefresh <bool>]
 [-ProcessAtReconnectAndUnlock <bool>] [-MachineGroupFriendlyName <string[]>]
 [-ConfigShare <string>] [<CommonParameters>]
```

### AppVentiXParamsContent

```
New-AppVentiXGroupPolicyUserSetting -FriendlyName <string> -AdmxContent <string>
 -AdmlContent <string> -PolicyInputObject <psobject[]> [-Description <string>]
 [-ExecutionOrder <int>] [-ProcessAtLogin <bool>] [-ProcessAtRefresh <bool>]
 [-ProcessAtReconnectAndUnlock <bool>] [-MachineGroupFriendlyName <string[]>]
 [-AdmxFileName <string>] [-AdmlFileName <string>] [-AdmlLanguage <string>] [-ConfigShare <string>]
 [<CommonParameters>]
```

### AppVentiXParamsFile

```
New-AppVentiXGroupPolicyUserSetting -FriendlyName <string> -AdmxFilePath <string>
 -PolicyInputObject <psobject[]> [-Description <string>] [-ExecutionOrder <int>]
 [-ProcessAtLogin <bool>] [-ProcessAtRefresh <bool>] [-ProcessAtReconnectAndUnlock <bool>]
 [-MachineGroupFriendlyName <string[]>] [-AdmlLanguage <string>] [-ConfigShare <string>]
 [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,

## DESCRIPTION

Builds and saves an AppVentiX UserSetting XML file that defines a Group Policy configuration,
including configured policies, policy elements, and registry entries.
Supports three input modes:

- AppVentiXParamsFile: ADMX/ADML supplied as file paths, policy data as PSCustomObject array
  from Get-IvantiWCPolicy -ExportFor AppVentiX.
- AppVentiXParamsContent: ADMX/ADML supplied as raw or base64 content strings, policy data
  as PSCustomObject array.
- InputObject: a fully pre-structured PSCustomObject (e.g.
from an Ivanti export pipeline).

The ADMX and ADML files are saved alongside the XML if they do not already exist at the target path.

## EXAMPLES

### EXAMPLE 1

$Policies = Get-IvantiWCPolicy -Path 'C:\temp\LAB-BB.xml' -IncludeADMFiles -ExportFor AppVentiX
$Policies | ForEach-Object {
    New-AppVentiXGroupPolicyUserSetting `
        -FriendlyName       $_.Name `
        -AdmxContent        $_.ADMXContent `
        -AdmxFileName       $_.ADMX `
        -AdmlContent        $_.ADMLContent `
        -AdmlFileName       $_.ADML `
        -PolicyInputObject  $_.AppVentiXParams
}

## PARAMETERS

### -AdmlContent

Raw or base64-encoded ADML XML content.
Used with the AppVentiXParamsContent parameter set.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: AppVentiXParamsContent
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -AdmlFileName

Override for the ADML filename.
Defaults to 'CustomPolicy.adml' when using content.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: AppVentiXParamsContent
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -AdmlLanguage

Language folder for ADML file storage (e.g.
en-US).
Defaults to 'en-US'.

```yaml
Type: System.String
DefaultValue: en-US
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: AppVentiXParamsContent
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: AppVentiXParamsFile
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -AdmxContent

Raw or base64-encoded ADMX XML content.
Used with the AppVentiXParamsContent parameter set.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: AppVentiXParamsContent
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -AdmxFileName

Override for the ADMX filename stored in the XML.
Derived from AdmxFilePath if not specified.
Defaults to 'CustomPolicy.admx' when using content.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: AppVentiXParamsContent
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -AdmxFilePath

Path to the ADMX file on disk.
The matching ADML file is expected at the same path with .adml extension.
Used with the AppVentiXParamsFile parameter set.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: AppVentiXParamsFile
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -ConfigShare

Path to the AppVentiX config share.
Defaults to the module variable.

```yaml
Type: System.String
DefaultValue: $Script:AppVentix.ConfigShare
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

### -Description

Optional description for the UserSetting.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: InputObject
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: AppVentiXParamsContent
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: AppVentiXParamsFile
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -ExecutionOrder

Execution order for the UserSetting.
Defaults to 0.

```yaml
Type: System.Int32
DefaultValue: 0
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: InputObject
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: AppVentiXParamsContent
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: AppVentiXParamsFile
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -FriendlyName

Display name for the AppVentiX UserSetting.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: InputObject
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: AppVentiXParamsContent
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: AppVentiXParamsFile
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -InputObject

Fully pre-structured PSCustomObject containing all policy metadata, ADMX/ADML content and entries.

```yaml
Type: System.Management.Automation.PSObject
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: InputObject
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -MachineGroupFriendlyName

One or more machine group friendly names to apply the setting to.
Defaults to 'All Machine Groups'.

```yaml
Type: System.String[]
DefaultValue: '@("All Machine Groups")'
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: InputObject
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: AppVentiXParamsContent
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: AppVentiXParamsFile
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -PolicyInputObject

Array of PSCustomObject items from Get-IvantiWCPolicy -ExportFor AppVentiX (the AppVentiXParams
property).
Each object must contain: PolicyName, PolicyDisplayName, PolicyKey, PolicyValueName,
Enabled, Elements, RegistryEntries.

```yaml
Type: System.Management.Automation.PSObject[]
DefaultValue: '@()'
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: AppVentiXParamsContent
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: AppVentiXParamsFile
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -ProcessAtLogin

Whether the policy is applied at login.
Defaults to $true.

```yaml
Type: System.Boolean
DefaultValue: True
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: InputObject
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: AppVentiXParamsContent
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: AppVentiXParamsFile
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -ProcessAtReconnectAndUnlock

Whether the policy is applied at reconnect and unlock.
Defaults to $false.

```yaml
Type: System.Boolean
DefaultValue: False
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: InputObject
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: AppVentiXParamsContent
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: AppVentiXParamsFile
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -ProcessAtRefresh

Whether the policy is applied at refresh.
Defaults to $true.

```yaml
Type: System.Boolean
DefaultValue: True
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: InputObject
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: AppVentiXParamsContent
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: AppVentiXParamsFile
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

Function  : New-AppVentiXGroupPolicyUserSetting
Author    : John Billekens
Copyright : (c) John Billekens Consultancy & AppVentiX
Version   : 2026.321.1000


## RELATED LINKS

- [Get-AppVentiXUserSettings](Get-AppVentiXUserSettings.md)
- [New-AppVentiXDriveMappingUserSetting](New-AppVentiXDriveMappingUserSetting.md)
- [New-AppVentiXEnvironmentVariableUserSetting](New-AppVentiXEnvironmentVariableUserSetting.md)
- [New-AppVentiXPrinterMappingUserSetting](New-AppVentiXPrinterMappingUserSetting.md)
- [New-AppVentiXRegistryUserSetting](New-AppVentiXRegistryUserSetting.md)
- [New-AppVentiXShortcutUserSetting](New-AppVentiXShortcutUserSetting.md)
- [Set-AppVentiXUserSettingFolder](Set-AppVentiXUserSettingFolder.md)
- [Set-AppVentiXUserSettingsAssignment](Set-AppVentiXUserSettingsAssignment.md)
