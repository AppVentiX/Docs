---
category: user-settings
category_title: User Settings Commands
document type: cmdlet
external help file: AppVentiX-Help.xml
HelpUri: ''
Locale: en-US
Module Name: AppVentiX
module_version: 2026.1117.1700
ms.date: 11-17-2026
PlatyPS schema version: 2024-05-01
title: Set-AppVentiXUserSettingFolder
---

# Set-AppVentiXUserSettingFolder

## SYNOPSIS

Assigns a UserSetting to a folder in the UserSettingFolders XML file.

## SYNTAX

### __AllParameterSets

```
Set-AppVentiXUserSettingFolder [-FolderName] <string> [-Id] <guid> [[-ConfigShare] <string>]
 [-PassThru] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,

## DESCRIPTION

Creates or updates the UserSettingFolders XML file at the configured ConfigShare location.
Adds the FolderName (and its parent folders) to the Folders list if not already present, and
creates or updates the Assignment for the given UserSettingId.
Existing assignments are updated
when the FolderName changes.
Empty folders are kept, like AppVentiX Central View does.

## EXAMPLES

### EXAMPLE 1

Set-AppVentiXUserSettingFolder -FolderName "Printers" -Id "9e429a7c-46de-4026-8faf-5b043bf272f0"

### EXAMPLE 2

Set-AppVentiXUserSettingFolder -FolderName "Printers" -Id "9e429a7c-46de-4026-8faf-5b043bf272f0" -PassThru

### EXAMPLE 3

Set-AppVentiXUserSettingFolder -FolderName "Applications\Office" -Id "9e429a7c-46de-4026-8faf-5b043bf272f0"

Assigns the UserSetting to subfolder "Office" of folder "Applications".
Both folders are created when missing.

## PARAMETERS

### -ConfigShare

Path to the ConfigShare.
Defaults to the module-configured ConfigShare.

```yaml
Type: System.String
DefaultValue: $Script:AppVentiX.ConfigShare
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

### -FolderName

The name of the folder to assign the UserSetting to.
Use a backslash for a subfolder,
e.g.
"New Folder\Subfolder1".
Missing parent folders are created.
An existing folder is
matched case-insensitively and keeps its casing.

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

### -Id

The UserSettingID (GUID) of the UserSetting to assign.

```yaml
Type: System.Guid
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 1
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -PassThru

When specified, returns a PSCustomObject with UserSettingId and FolderName upon success.

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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutBuffer, -OutVariable, -PipelineVariable,
-ProgressAction, -Verbose, -WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## RELATED LINKS

- [Get-AppVentiXUserSettings](Get-AppVentiXUserSettings.md)
- [New-AppVentiXUserSettingFolder](New-AppVentiXUserSettingFolder.md)
- [New-AppVentiXDriveMappingUserSetting](New-AppVentiXDriveMappingUserSetting.md)
- [New-AppVentiXEnvironmentVariableUserSetting](New-AppVentiXEnvironmentVariableUserSetting.md)
- [New-AppVentiXGroupPolicyUserSetting](New-AppVentiXGroupPolicyUserSetting.md)
- [New-AppVentiXPrinterMappingUserSetting](New-AppVentiXPrinterMappingUserSetting.md)
- [New-AppVentiXRegistryUserSetting](New-AppVentiXRegistryUserSetting.md)
- [New-AppVentiXShortcutUserSetting](New-AppVentiXShortcutUserSetting.md)
- [Set-AppVentiXUserSettingsAssignment](Set-AppVentiXUserSettingsAssignment.md)
