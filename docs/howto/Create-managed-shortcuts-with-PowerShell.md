# HowTo: Create Managed Shortcuts with PowerShell

This guide shows how to create native Start menu shortcuts (Shortcuts User Settings) with the AppVentiX PowerShell module, including the icon, file type associations and User State Roaming. It uses Microsoft Edge and Notepad++ as examples.

## Overview

| Task | Command |
|------|---------|
| Create a shortcut | `New-AppVentiXShortcutUserSetting` |
| Put it in a folder | `Set-AppVentiXUserSettingFolder` |
| Assign it to a user group | `Set-AppVentiXUserSettingsAssignment` |

A Shortcuts User Setting can hold one or more shortcuts (entries). For each entry you set the name, executable, arguments, working directory and whether it is also placed on the desktop.

!!! note "About the examples"
    The examples in this guide are scenarios to show how the commands work. Group names, folder names and installation paths are placeholders. Replace them with the values from your own environment.

## Prerequisites

- AppVentiX PowerShell module version 2026.1117.1700 or later
- A valid AppVentiX license
- Write access to the AppVentiX Configuration Store
- The application installed on the machine where you run the commands, if you want to take the icon from its executable

```powershell
Import-Module AppVentiX

# Optional: select the site to work in, when you have more than one
Get-AppVentiXSite
Set-AppVentiXSite -Name 'Test'
```

## Example 1: Microsoft Edge with file type associations

**Scenario:** users should open web pages and PDF files in Edge. In this scenario the shortcut gets the icon from `msedge.exe` and file type associations for `.htm`, `.html` and `.pdf`.

```powershell
$edgeFolder = 'C:\Program Files (x86)\Microsoft\Edge\Application'

$edgeShortcut = @{
    FriendlyName    = 'Microsoft Edge'
    IconFile        = "$edgeFolder\msedge.exe"
    ShortcutEntries = @(
        @{
            ShortcutName         = 'Microsoft Edge'
            ExecutablePath       = "$edgeFolder\msedge.exe"
            WorkingDirectory     = $edgeFolder
            FileTypeAssociations = @(
                @{ Extension = '.htm'; TypeDescription = 'HTML Document' }
                @{ Extension = '.html'; TypeDescription = 'HTML Document' }
                @{ Extension = '.pdf'; TypeDescription = 'PDF Document' }
            )
        }
    )
}
$edge = New-AppVentiXShortcutUserSetting @edgeShortcut

Set-AppVentiXUserSettingFolder -FolderName 'Applications\Browsers' -Id $edge.Id
```

!!! tip "Splatting"
    This example uses [splatting](https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_splatting): the parameters are collected in a hashtable and passed with `@` instead of `$`. Each key is a parameter name. This keeps long commands readable and lets you build or change the parameters before you run the command. The Notepad++ example below uses the classic notation with line continuations; both work the same.

About the icon:

- `-IconFile` accepts an `.exe` or `.dll`, as well as `.png` and `.ico` files. For an executable, the icon is taken from the file at each size AppVentiX stores (16, 32, 48 and 256 pixels), so it stays sharp in the Start menu and in Central View.
- The icon is read on the machine where you run the command. The path only needs to exist there.
- Without `-IconFile` the shortcut is created without an icon and a warning is shown.

About file type associations:

- The application of the shortcut becomes the default program for the listed file types, and is also offered to the user in the **Open with** menu.
- Only shortcuts that start an executable can be associated with file types.
- The extension may be written with or without the leading dot (`pdf` becomes `.pdf`).
- Each association is linked to the shortcut entry it is defined in.
- `-EnforceFileTypeAssociations` (default `$true`) reapplies the default program at every logon and refresh. This overrides a choice the user made under **Open with**. Use `-EnforceFileTypeAssociations $false` to set the default once and let users change it.

!!! warning "Protected file types"
    On Windows 10 and Windows 11, the User Choice Protection Driver (since February 2024) protects the default program for some file types, for example `.htm`, `.html` and `.pdf`. For those file types the shortcut is registered and offered under **Open with**, but it does not become the default program. Central View shows which of the configured file types are protected on the **File Type Associations** tab of the shortcut.

    In this scenario that applies to all three file types: Edge is offered under **Open with**, and the user (or the default associations of the image) decides the default program.

!!! note
    The file type associations in this guide are part of a native Shortcuts User Setting. Central View can also create file type associations as an MSIX package, see [File Type Association](../admin-guide/user-settings-detailed/index.md#file-type-association).

## Example 2: Notepad++ with User State Roaming

**Scenario:** users work on non-persistent machines and want to keep their Notepad++ settings between sessions. Notepad++ stores its settings in `%APPDATA%\Notepad++`, so without roaming they are lost at logoff. In this scenario a capture rule saves and restores that folder for the user.

```powershell
$npp = New-AppVentiXShortcutUserSetting -FriendlyName 'Notepad++' `
    -IconFile 'C:\Program Files\Notepad++\notepad++.exe' `
    -ShortcutEntries @(
        @{
            ShortcutName         = 'Notepad++'
            ExecutablePath       = 'C:\Program Files\Notepad++\notepad++.exe'
            WorkingDirectory     = 'C:\Program Files\Notepad++'
            FileTypeAssociations = @(
                @{ Extension = '.txt'; TypeDescription = 'Text Document' }
                @{ Extension = '.log'; TypeDescription = 'Log File' }
            )
        }
    ) `
    -CaptureRules @(
        @{ Kind = 'Folder'; Path = '%APPDATA%\Notepad++'; Description = 'Notepad++ settings' }
    )

Set-AppVentiXUserSettingFolder -FolderName 'Applications\Development\Editors' -Id $npp.Id
```

Each capture rule needs a `Kind` (`Folder`, `File` or `Registry`) and a `Path`. Optional keys are `Exclude`, `IncludeSubfolders` (default `True`), `Enabled` (default `True`) and `Description`. User State Roaming is enabled automatically when at least one rule is given.

## More shortcut options

| Entry key | Purpose |
|-----------|---------|
| `ShortcutName` | Name in the Start menu. Prefix it with a folder name to create a Start menu subfolder, for example `Development\Notepad++`. |
| `Arguments` | Command line arguments, for example `--new-window`. |
| `PlaceOnDesktop` | `$true` to also place the shortcut on the desktop. |
| `WorkingDirectory` | Working directory of the shortcut. |

Other useful parameters of `New-AppVentiXShortcutUserSetting`:

| Parameter | Purpose |
|-----------|---------|
| `-MachineGroupFriendlyName` | Limit the shortcut to one or more machine groups. Defaults to all machine groups. Check the names with `Get-AppVentiXMachineGroup`: a name that does not exist is skipped without a warning. |
| `-ProcessAtRefresh` | Also apply the setting when the user refreshes the workspace. Defaults to `$true`. |
| `-ExecutionOrder` | Lower numbers run first. Defaults to `0`. Central View uses `100` for new settings. |

## Assign the shortcut

A shortcut is only applied when it is assigned to users. Assign it to an Active Directory group, or to `Everyone`:

```powershell
Set-AppVentiXUserSettingsAssignment -Id $edge.Id -ADGroup 'Everyone' -Type Shortcuts
Set-AppVentiXUserSettingsAssignment -Id $npp.Id -ADGroup 'App - Notepad++' -Type Shortcuts
```

The domain is added to the group name automatically. Entra ID groups can be assigned in Central View.

## Verify

Open Central View and select **User Settings**. The shortcuts are in the folders you chose. Open a shortcut to check the icon on the **Shortcuts** tab, the associations on the **File Type Associations** tab and the rules on the **User State Roaming** tab.

## Related

- [Configure Prelaunch and Postlaunch Settings with PowerShell](Configure-prelaunch-and-postlaunch-settings.md)
- [Shortcuts in the User Settings Reference](../admin-guide/user-settings-detailed/index.md#shortcuts)
- [New-AppVentiXShortcutUserSetting](../powershell-module/commands/New-AppVentiXShortcutUserSetting.md)
