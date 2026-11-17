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
title: New-AppVentiXUserSettingFolder
---

# New-AppVentiXUserSettingFolder

## SYNOPSIS

Creates a User Setting folder in the UserSettingFolders XML file.

## SYNTAX

### __AllParameterSets

```
New-AppVentiXUserSettingFolder [-FolderName] <string> [[-ConfigShare] <string>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,

## DESCRIPTION

Adds a folder to the Folders list of the UserSettingFolders XML file at the configured
Configuration Store, as shown under Available User Settings in AppVentiX Central View.
Use a backslash for a subfolder.
Missing parent folders are created as well.
When the folder already exists, a warning is shown and nothing is changed.

## EXAMPLES

### EXAMPLE 1

New-AppVentiXUserSettingFolder -FolderName "Printers"

### EXAMPLE 2

New-AppVentiXUserSettingFolder -FolderName "Applications\Office\Add-ins"

Creates the folders "Applications", "Applications\Office" and "Applications\Office\Add-ins" when missing.

### EXAMPLE 3

"Drives", "Printers" | New-AppVentiXUserSettingFolder

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
  Position: 1
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -FolderName

The name of the folder, e.g.
"New Folder" or "New Folder\Subfolder1\Subfolder2".
Existing parent folders are matched case-insensitively and keep their casing.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 0
  IsRequired: true
  ValueFromPipeline: true
  ValueFromPipelineByPropertyName: true
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

### System.String

## OUTPUTS

### PSCustomObject with FolderName.

### System.Management.Automation.PSObject

## RELATED LINKS

- [Set-AppVentiXUserSettingFolder](Set-AppVentiXUserSettingFolder.md)
- [Get-AppVentiXUserSettings](Get-AppVentiXUserSettings.md)
