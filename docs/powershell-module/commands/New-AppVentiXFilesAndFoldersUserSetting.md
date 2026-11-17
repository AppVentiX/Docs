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
title: New-AppVentiXFilesAndFoldersUserSetting
---

# New-AppVentiXFilesAndFoldersUserSetting

## SYNOPSIS

Creates an AppVentiX Files and Folders UserSetting to copy or delete files and folders.

## SYNTAX

### __AllParameterSets

```
New-AppVentiXFilesAndFoldersUserSetting [-FriendlyName] <string> [[-Description] <string>]
 [[-ExecutionOrder] <int>] [[-Enabled] <bool>] [[-ProcessAtLogin] <bool>]
 [[-ProcessAtRefresh] <bool>] [[-ProcessAtReconnectAndUnlock] <bool>]
 [[-MachineGroupFriendlyName] <string[]>] [-FileOperations] <hashtable[]> [[-RunOnce] <bool>]
 [[-ConfigShare] <string>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,

## DESCRIPTION

Builds and saves an AppVentiX UserSetting XML file of type ManageFiles ("Files and Folders" in
AppVentiX Central View) with one or more file operations.
Each operation copies a file or folder,
or deletes a file or folder.
Operations are written in the given order.

## EXAMPLES

### EXAMPLE 1

New-AppVentiXFilesAndFoldersUserSetting -FriendlyName "Copy templates" -FileOperations @(
    @{ Action = "Copy"; SourcePath = "\\fileserver.domain.local\Templates$\Word"; DestinationPath = "%APPDATA%\Microsoft\Templates" }
)

### EXAMPLE 2

New-AppVentiXFilesAndFoldersUserSetting -FriendlyName "VS Code - Clear cache" -FileOperations @(
    @{ Action = "Delete"; Path = "%APPDATA%\Code\Cache" }
    @{ Action = "Delete"; Path = "%APPDATA%\Code\CachedData" }
)

### EXAMPLE 3

New-AppVentiXFilesAndFoldersUserSetting -FriendlyName "Default signature" -RunOnce $true -FileOperations @(
    @{ Action = "Copy"; SourcePath = "\\fileserver.domain.local\Signatures$\Default.htm"; DestinationPath = "%APPDATA%\Microsoft\Signatures\Default.htm"; AlwaysOverwrite = $true }
)

## PARAMETERS

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
  Position: 10
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

### -Enabled

Whether the User Setting is enabled.
Defaults to $true.
Use Disable-AppVentiXUserSetting or Enable-AppVentiXUserSetting to change it later.

```yaml
Type: System.Boolean
DefaultValue: True
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

### -ExecutionOrder

Execution order for the UserSetting.
Defaults to 100, like AppVentiX Central View.

```yaml
Type: System.Int32
DefaultValue: 100
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

### -FileOperations

Array of hashtables describing the file operations.
Each entry must contain an Action: Copy or Delete.
Copy: SourcePath and DestinationPath (file or folder).
Optional keys, the Overwrite and Only Newer
options in Central View: AlwaysOverwrite (bool, defaults to $false) and OnlyNewer (bool, defaults to
the opposite of AlwaysOverwrite).
Delete: Path, the file or folder to delete (DestinationPath is accepted as well).

```yaml
Type: System.Collections.Hashtable[]
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 8
  IsRequired: true
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

### -MachineGroupFriendlyName

One or more machine group friendly names to apply the setting to.
Defaults to 'All Machine Groups'.

```yaml
Type: System.String[]
DefaultValue: '@("All Machine Groups")'
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 7
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -ProcessAtLogin

Whether the setting is applied at login.
Defaults to $true.

```yaml
Type: System.Boolean
DefaultValue: True
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

### -ProcessAtReconnectAndUnlock

Whether the setting is applied at reconnect and unlock.
Defaults to $false.

```yaml
Type: System.Boolean
DefaultValue: False
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 6
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -ProcessAtRefresh

Whether the setting is applied at refresh.
Defaults to $true.

```yaml
Type: System.Boolean
DefaultValue: True
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

### -RunOnce

Whether the operations are executed only once per user.
Defaults to $false.

```yaml
Type: System.Boolean
DefaultValue: False
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 9
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

## RELATED LINKS

- [Get-AppVentiXUserSettings](Get-AppVentiXUserSettings.md)
- [Set-AppVentiXShortcutLinkedUserSetting](Set-AppVentiXShortcutLinkedUserSetting.md)
- [Set-AppVentiXUserSettingFolder](Set-AppVentiXUserSettingFolder.md)
- [Set-AppVentiXUserSettingsAssignment](Set-AppVentiXUserSettingsAssignment.md)
