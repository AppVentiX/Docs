# HowTo: Create Common User Settings with PowerShell

This guide shows common User Settings created with the AppVentiX PowerShell module: drive mappings, printer mappings, environment variables, registry settings, files and folders, and global User State Roaming rules. Each example is a typical real-world requirement, from creating the setting to assigning it.

## Overview

| User Setting | Command |
|--------------|---------|
| Drive Mapping | `New-AppVentiXDriveMappingUserSetting` |
| Printer Mapping | `New-AppVentiXPrinterMappingUserSetting` |
| Environment Variables | `New-AppVentiXEnvironmentVariableUserSetting` |
| Registry Settings | `New-AppVentiXRegistryUserSetting` |
| Files and Folders | `New-AppVentiXFilesAndFoldersUserSetting` |
| Global User State Roaming | `New-AppVentiXGlobalUserSetting` |
| Assign to a user group | `Set-AppVentiXUserSettingsAssignment` |
| Put in a folder | `Set-AppVentiXUserSettingFolder` |

Every `New-AppVentiX*UserSetting` command returns an object with the `Id` of the new setting. Store it in a variable, you need it to assign the setting and to move it into a folder.

!!! note "About the examples"
    Each example starts with a scenario to show when a setting is useful. Server names, shares, printers, groups, machine groups and paths are placeholders. Replace them with the values from your own environment, and only use the examples that fit your situation.

## Prerequisites

- AppVentiX PowerShell module version 2026.1117.1700 or later
- A valid AppVentiX license
- Write access to the AppVentiX Configuration Store
- User Settings enabled in the [Agent Settings](../admin-guide/agent-settings/index.md) of the machine groups

```powershell
Import-Module AppVentiX

# Optional: select the site to work in, when you have more than one
Get-AppVentiXSite
Set-AppVentiXSite -Name 'Test'
```

## Settings that apply to all types

| Parameter | Default | Purpose |
|-----------|---------|---------|
| `-MachineGroupFriendlyName` | All machine groups | Apply the setting only on machines in these machine groups. |
| `-ProcessAtLogin` | `$true` | Apply at login. |
| `-ProcessAtRefresh` | `$true` | Also apply when the user refreshes the workspace. Central View enables only login for new settings. |
| `-ProcessAtReconnectAndUnlock` | `$false` | Also apply when the user reconnects or unlocks the session. |
| `-ExecutionOrder` | `0` | Lower numbers run first. Central View uses `100` for new settings. |
| `-Description` | empty | Free text shown in Central View. |

!!! warning
    Check machine group names with `Get-AppVentiXMachineGroup | Select-Object FriendlyName` before you use `-MachineGroupFriendlyName`. A name that does not exist is skipped without a warning. When none of the names exist, the setting has no machine group and is not applied anywhere.

### Reuse common parameters with splatting

When you create several settings with the same options, put those options in a hashtable once and pass it to each command with `@` ([splatting](https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_splatting)). You can combine a splatted hashtable with normal parameters.

**Scenario:** all settings for developers should only apply on the **Developer Desktops** machine group, only at login (like Central View), and with the Central View default Execution Order:

```powershell
$developerDefaults = @{
    MachineGroupFriendlyName = 'Developer Desktops'
    ProcessAtRefresh         = $false
    ExecutionOrder           = 100
}

$sourceDrive = New-AppVentiXDriveMappingUserSetting @developerDefaults -FriendlyName 'S: Source' `
    -DriveLetter 'S:' -NetworkPath '\\fileserver.domain.local\Source$' -Label 'Source'

$sourceVariable = New-AppVentiXEnvironmentVariableUserSetting @developerDefaults -FriendlyName 'SOURCE_ROOT' `
    -EnvironmentVariables @(@{ Name = 'SOURCE_ROOT'; Value = 'S:\' })
```

Changing the machine group or Execution Order for all of them is now a change in one place.

## Drive mappings

### Map a department share

**Scenario:** a project team needs its share on **P:**. Only members of the `Projects` group should get the drive.

```powershell
$projects = New-AppVentiXDriveMappingUserSetting -FriendlyName 'P: Projects' `
    -DriveLetter 'P:' -NetworkPath '\\fileserver.domain.local\Projects$' -Label 'Projects'

Set-AppVentiXUserSettingsAssignment -Id $projects.Id -ADGroup 'Projects' -Type DriveMapping
Set-AppVentiXUserSettingFolder -FolderName 'Drives' -Id $projects.Id
```

Drive mappings are tracked. When you later unassign the setting, the drive is removed from the users automatically. See [Tracked User Settings](../admin-guide/user-settings-general/index.md#tracked-user-settings).

### Hide a local drive

**Scenario:** the session hosts have a **D:** drive with a temporary or data disk that users should not browse.

```powershell
$hideD = New-AppVentiXDriveMappingUserSetting -FriendlyName 'Hide D:' -DriveLetter 'D:' -HideDrive $true

Set-AppVentiXUserSettingsAssignment -Id $hideD.Id -ADGroup 'Everyone' -Type DriveMapping
```

### Only set a label

**Scenario:** the **D:** drive should stay visible, but with a clearer name. To set a label without mapping anything, use `-DoNotExecute`:

```powershell
$labelD = New-AppVentiXDriveMappingUserSetting -FriendlyName 'Label D: Local Data' `
    -DriveLetter 'D:' -Label 'Local Data' -DoNotExecute $true
```

## Printer mappings

### Default printer per location

**Scenario:** the machines on the second floor of an office are in a machine group named **Office Floor 2**. Whoever logs on to one of those machines should get the printer on that floor as default printer.

```powershell
$printer = @{
    FriendlyName             = 'Printer Floor 2'
    PrinterPath              = '\\printserver.domain.local\Floor2-MFP'
    SetAsDefault             = $true
    MachineGroupFriendlyName = 'Office Floor 2'
}
$floor2 = New-AppVentiXPrinterMappingUserSetting @printer

Set-AppVentiXUserSettingsAssignment -Id $floor2.Id -ADGroup 'Everyone' -Type PrinterMapping
Set-AppVentiXUserSettingFolder -FolderName 'Printers' -Id $floor2.Id
```

To connect a printer only when a specific application is started, link the printer mapping to the shortcut instead of assigning it. See [Configure Prelaunch and Postlaunch Settings with PowerShell](Configure-prelaunch-and-postlaunch-settings.md).

## Environment variables

Each variable takes a `Name` and `Value`. Optional are `AppendToExisting` (default `$false`) and `Scope`, `User` (default) or `System`.

### Add a tools folder to the user PATH

**Scenario:** command line tools are installed in `C:\Tools` and users should be able to run them from any folder.

```powershell
$toolsPath = New-AppVentiXEnvironmentVariableUserSetting -FriendlyName 'PATH: Company tools' `
    -EnvironmentVariables @(
        @{ Name = 'Path'; Value = 'C:\Tools'; AppendToExisting = $true }
    )
```

!!! tip
    Test an appended variable on one machine first (`$env:Path -split ';'` in a new session) to confirm the result is what you expect before you assign it to everyone.

### Several variables in one setting

**Scenario:** developers need `JAVA_HOME` on their machines, and a user variable that points their scripts to a shared source location:

```powershell
$devVariables = New-AppVentiXEnvironmentVariableUserSetting -FriendlyName 'Developer variables' `
    -MachineGroupFriendlyName 'Developer Desktops' `
    -EnvironmentVariables @(
        @{ Name = 'JAVA_HOME'; Value = 'C:\Program Files\Eclipse Adoptium\jdk-21'; Scope = 'System' }
        @{ Name = 'SOURCE_ROOT'; Value = '\\fileserver.domain.local\Source$' }
    )

Set-AppVentiXUserSettingsAssignment -Id $devVariables.Id -ADGroup 'Developers' -Type EnvironmentVariables
```

## Registry settings

Each entry needs a `RootKey` (`HKCU` or `HKLM`) and a `KeyPath`. Optional are `ValueName`, `ValueData`, `ValueType` and `Action`.

| `ValueType` | Registry type |
|-------------|---------------|
| `String` | REG_SZ (default) |
| `ExpandString` | REG_EXPAND_SZ |
| `DWord` | REG_DWORD |
| `MultiString` | REG_MULTI_SZ |
| `Binary` | REG_BINARY |

`Action` is `Set` (default) to create or change a value, or `Remove` to delete it. With `Remove` and no `ValueName` the whole key is removed.

!!! note
    Central View also supports REG_QWORD. Create those entries in Central View.

### Show file extensions in File Explorer

**Scenario:** users should see file extensions in File Explorer, so they can tell a `.pdf` from a `.pdf.exe`.

```powershell
$fileExtensions = New-AppVentiXRegistryUserSetting -FriendlyName 'Explorer: show file extensions' `
    -RegistryEntries @(
        @{ RootKey = 'HKCU'; KeyPath = 'Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced'; ValueName = 'HideFileExt'; ValueData = '0'; ValueType = 'DWord' }
    )

Set-AppVentiXUserSettingsAssignment -Id $fileExtensions.Id -ADGroup 'Everyone' -Type RegistrySettings
```

### Stop OneDrive from starting at login

**Scenario:** OneDrive is not used on the shared session hosts, so it should not start at login. Remove its autostart entry for the user:

```powershell
$noOneDrive = New-AppVentiXRegistryUserSetting -FriendlyName 'OneDrive: no autostart' `
    -RegistryEntries @(
        @{ RootKey = 'HKCU'; KeyPath = 'Software\Microsoft\Windows\CurrentVersion\Run'; ValueName = 'OneDrive'; Action = 'Remove' }
    )
```

## Files and folders

A Files and Folders User Setting copies or deletes one or more files or folders. Each operation has an `Action`:

| Action | Keys |
|--------|------|
| `Copy` | `SourcePath` and `DestinationPath` (file or folder). Optional `AlwaysOverwrite` and `OnlyNewer`, the **Overwrite** and **Only Newer** options in Central View. By default only `OnlyNewer` is set. |
| `Delete` | `Path`, the file or folder to delete. |

Use `-RunOnce $true` to run the operations only once per user. As a best practice, keep Copy and Delete actions in separate User Settings.

### Distribute Word templates

**Scenario:** the organization maintains its Word templates on a file share. Users should get new and updated templates, without a full copy at every login.

```powershell
$templates = New-AppVentiXFilesAndFoldersUserSetting -FriendlyName 'Word templates' `
    -FileOperations @(
        @{ Action = 'Copy'; SourcePath = '\\fileserver.domain.local\Templates$\Word'; DestinationPath = '%APPDATA%\Microsoft\Templates' }
    )

Set-AppVentiXUserSettingsAssignment -Id $templates.Id -ADGroup 'Everyone' -Type ManageFiles
```

The copy uses the default **Only Newer** option, so only files that changed on the share are copied again.

### Provide a starting configuration once

**Scenario:** new users should start with the default settings file of an application, but they may change it afterwards. The file is copied once and never overwritten again for that user.

```powershell
$appDefaults = New-AppVentiXFilesAndFoldersUserSetting -FriendlyName 'App defaults (once)' -RunOnce $true `
    -FileOperations @(
        @{ Action = 'Copy'; SourcePath = '\\fileserver.domain.local\Defaults$\App\settings.json'; DestinationPath = '%APPDATA%\App\settings.json' }
    )
```

### Clean up after a migration

**Scenario:** an application was replaced, and its old data folder in the user profile only takes up space. The folder is removed once per user.

```powershell
$cleanup = New-AppVentiXFilesAndFoldersUserSetting -FriendlyName 'Remove OldApp data' -RunOnce $true `
    -FileOperations @(
        @{ Action = 'Delete'; Path = '%LOCALAPPDATA%\OldApp' }
    )

Set-AppVentiXUserSettingsAssignment -Id $cleanup.Id -ADGroup 'Everyone' -Type ManageFiles
```

To clean up after a specific application closes, link a Files and Folders setting to its shortcut as postlaunch setting. See [Configure Prelaunch and Postlaunch Settings with PowerShell](Configure-prelaunch-and-postlaunch-settings.md).

## Global User State Roaming rules

Roaming rules can be part of a Shortcuts User Setting, see [Create Managed Shortcuts with PowerShell](Create-managed-shortcuts-with-PowerShell.md#example-2-notepad-with-user-state-roaming). Global rules are not tied to a shortcut, which suits tools that are part of the base image.

**Scenario:** Windows Terminal is part of the base image of non-persistent machines, and users want to keep their terminal settings between sessions:

```powershell
New-AppVentiXGlobalUserSetting -Type UserStateRoaming -Settings @{
    Name         = 'Windows Terminal'
    Description  = 'Roam Windows Terminal settings'
    CaptureRules = @(
        @{ Kind = 'Folder'; Path = '%LOCALAPPDATA%\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState' }
    )
}
```

## Assignments

`Set-AppVentiXUserSettingsAssignment` assigns a setting to an Active Directory group or to `Everyone`. The `-Type` must match the type of the setting:

| User Setting | `-Type` |
|--------------|---------|
| Drive Mapping | `DriveMapping` |
| Printer Mapping | `PrinterMapping` |
| Environment Variables | `EnvironmentVariables` |
| Registry Settings | `RegistrySettings` |
| Shortcuts | `Shortcuts` |
| Group Policy | `GroupPolicy` |
| External Tasks | `ExternalTasks` |
| Files and Folders | `ManageFiles` |

The domain is added to the group name when you leave it out. Entra ID groups can be assigned in Central View. A setting that is linked to a shortcut as prelaunch or postlaunch setting cannot be assigned to user groups.

## Combine settings with Execution Order

Settings run from the lowest to the highest Execution Order. Give settings that others depend on a lower number.

**Scenario:** a reporting application writes its output to the path in the `REPORT_OUTPUT` variable, which points to a mapped drive. The drive is mapped first, then the variable is set:

```powershell
$dataDrive = New-AppVentiXDriveMappingUserSetting -FriendlyName 'R: Reports' `
    -DriveLetter 'R:' -NetworkPath '\\fileserver.domain.local\Reports$' -ExecutionOrder 10

$reportVariable = New-AppVentiXEnvironmentVariableUserSetting -FriendlyName 'REPORT_OUTPUT' `
    -EnvironmentVariables @(@{ Name = 'REPORT_OUTPUT'; Value = 'R:\Output' }) -ExecutionOrder 20
```

## Find and review settings

```powershell
# All User Settings
Get-AppVentiXUserSettings | Select-Object FriendlyName, Type, Id

# One or more types
Get-AppVentiXUserSettings -Type DriveMapping, PrinterMapping

# By name, wildcards are allowed
Get-AppVentiXUserSettings -FriendlyName 'P: Projects'
Get-AppVentiXUserSettings -FriendlyName 'Printer*'

# By Id
Get-AppVentiXUserSettings -Id $projects.Id

# Only drive mappings, with their details
Get-AppVentiXUserSettings -Type DriveMapping | ForEach-Object {
    [PSCustomObject]@{
        Name        = $_.FriendlyName
        Drive       = $_.Settings.DriveMapping.DriveLetter
        NetworkPath = $_.Settings.DriveMapping.NetworkPath
    }
}
```

!!! tip
    `-Type` and `-Id` only read the matching files, which is noticeably faster with many User Settings, especially on an Azure Blob Configuration Store. Combine `-Type` with `-FriendlyName` when you know the type.

## Related

- [Organize User Settings in Folders with PowerShell](Organize-user-settings-in-folders.md)
- [Create Managed Shortcuts with PowerShell](Create-managed-shortcuts-with-PowerShell.md)
- [Import User Settings from Ivanti Workspace Control](Import-user-settings-from-Ivanti-Workspace-Control.md)
- [User Settings Reference](../admin-guide/user-settings-detailed/index.md)
