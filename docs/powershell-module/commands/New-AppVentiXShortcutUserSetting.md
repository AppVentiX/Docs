---
category: user-settings
category_title: User Settings Commands
document type: cmdlet
external help file: AppVentiX-Help.xml
HelpUri: ''
Locale: en-US
Module Name: AppVentiX
module_version: 2026.922.1400
ms.date: 09-22-2026
PlatyPS schema version: 2024-05-01
title: New-AppVentiXShortcutUserSetting
---

# New-AppVentiXShortcutUserSetting

## SYNOPSIS

Creates an AppVentiX UserSetting XML file for a Shortcuts configuration.

## SYNTAX

### InputObject

```
New-AppVentiXShortcutUserSetting -InputObject <psobject> [-FriendlyName <string>]
 [-Description <string>] [-ExecutionOrder <int>] [-ProcessAtLogin <bool>] [-ProcessAtRefresh <bool>]
 [-ProcessAtReconnectAndUnlock <bool>] [-MachineGroupFriendlyName <string[]>] [-IconFile <string>]
 [-CaptureRules <hashtable[]>] [-EnforceFileTypeAssociations <bool>] [-ConfigShare <string>]
 [<CommonParameters>]
```

### ShortcutEntries

```
New-AppVentiXShortcutUserSetting -FriendlyName <string> -ShortcutEntries <hashtable[]>
 [-Description <string>] [-ExecutionOrder <int>] [-ProcessAtLogin <bool>] [-ProcessAtRefresh <bool>]
 [-ProcessAtReconnectAndUnlock <bool>] [-MachineGroupFriendlyName <string[]>] [-IconFile <string>]
 [-CaptureRules <hashtable[]>] [-EnforceFileTypeAssociations <bool>] [-ConfigShare <string>]
 [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,

## DESCRIPTION

Builds and saves an AppVentiX UserSetting XML file that defines one or more shortcuts,
including executable path, arguments, working directory, desktop placement, and icon data.
Supports two input modes:

- ShortcutEntries mode: accepts an array of hashtables describing individual shortcut entries.
- InputObject mode: accepts a pre-structured PSCustomObject (e.g.
from Get-IvantiWCShortcut),
  which includes shortcut metadata and icon data (base64) ready for direct use.

Icon data handling:
- If the InputObject or ShortcutEntry already contains base64 icon data, it is used as-is.
- If icon data is absent and an IconFile path is provided, the function generates all icon
  sizes (16, 32, 48, 256 and default 32) from that file.
- If neither is available, a warning is issued and icon fields are left empty.

## EXAMPLES

### EXAMPLE 1

New-AppVentiXShortcutUserSetting -FriendlyName "Notepad++" -ShortcutEntries @(
    @{
        ShortcutName         = "Notepad++"
        ExecutablePath       = "C:\Program Files\Notepad++\notepad++.exe"
        FileTypeAssociations = @(@{ Extension = ".txt" })
    }
) -CaptureRules @(
    @{ Kind = "Folder"; Path = "%APPDATA%\Notepad++" }
    @{ Kind = "Registry"; Path = "HKCU\Software\Notepad++" }
)

## PARAMETERS

### -CaptureRules

Array of hashtables describing User State Roaming capture rules.
UserStateRoaming is enabled
when at least one rule is provided.
Each rule must contain: Kind (Folder, File or Registry), Path.
Optional keys: Exclude, IncludeSubfolders (default True), Enabled (default True), Description,
RuleId (generated when omitted).

```yaml
Type: System.Collections.Hashtable[]
DefaultValue: '@()'
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: InputObject
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: ShortcutEntries
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
- Name: ShortcutEntries
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -EnforceFileTypeAssociations

Whether the file type associations are enforced.
Defaults to $true.
Written as False when no
file type associations are defined.

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
- Name: ShortcutEntries
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
- Name: ShortcutEntries
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
- Name: ShortcutEntries
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -IconFile

Path to a PNG, ICO, or EXE file used as icon source when icon data is absent in the entries.
The function will generate all required icon sizes from this file.

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
- Name: ShortcutEntries
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -InputObject

Pre-structured PSCustomObject containing shortcut metadata and entries.
Optional properties CaptureRules and EnforceFileTypeAssociations are used when the matching
parameter is not specified.

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
- Name: ShortcutEntries
  Position: Named
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
- Name: InputObject
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: ShortcutEntries
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

Whether the setting is applied at reconnect and unlock.
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
- Name: ShortcutEntries
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

Whether the setting is applied at refresh.
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
- Name: ShortcutEntries
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -ShortcutEntries

Array of hashtables describing shortcut entries.
Each entry must contain: ShortcutName, ExecutablePath.
Optional keys: Arguments, WorkingDirectory, PlaceOnDesktop, IconData, IconData16, IconData32,
IconData48, IconData256, IconFile, EntryId (generated when omitted), FileTypeAssociations.
FileTypeAssociations is an array of hashtables or objects with Extension and optional
TypeDescription, linked to the EntryId of the entry they are defined in.
FileAssociations with
Extension and Description (Get-IvantiWCApplication output) is accepted as well.

```yaml
Type: System.Collections.Hashtable[]
DefaultValue: '@()'
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: ShortcutEntries
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

- [Get-AppVentiXUserSettings](Get-AppVentiXUserSettings.md)
- [New-AppVentiXDriveMappingUserSetting](New-AppVentiXDriveMappingUserSetting.md)
- [New-AppVentiXEnvironmentVariableUserSetting](New-AppVentiXEnvironmentVariableUserSetting.md)
- [New-AppVentiXGroupPolicyUserSetting](New-AppVentiXGroupPolicyUserSetting.md)
- [New-AppVentiXPrinterMappingUserSetting](New-AppVentiXPrinterMappingUserSetting.md)
- [New-AppVentiXRegistryUserSetting](New-AppVentiXRegistryUserSetting.md)
- [Set-AppVentiXUserSettingFolder](Set-AppVentiXUserSettingFolder.md)
- [Set-AppVentiXUserSettingsAssignment](Set-AppVentiXUserSettingsAssignment.md)
