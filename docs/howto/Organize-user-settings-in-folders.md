# HowTo: Organize User Settings in Folders with PowerShell

As the number of User Settings grows, folders keep the **Available User Settings** list in AppVentiX Central View manageable. This guide shows how to create folders and subfolders, and how to move User Settings into them, using the AppVentiX PowerShell module.

## Overview

| Task | Command |
|------|---------|
| Create a folder or subfolder | `New-AppVentiXUserSettingFolder` |
| Move a User Setting into a folder | `Set-AppVentiXUserSettingFolder` |
| Find the Id of a User Setting | `Get-AppVentiXUserSettings` |

Folders are stored in the Configuration Store, so a folder you create with PowerShell shows up in Central View the next time the User Settings list is loaded, and the other way around.

## Prerequisites

- AppVentiX PowerShell module version 2026.1117.1700 or later
- A valid AppVentiX license
- Write access to the AppVentiX Configuration Store

```powershell
Import-Module AppVentiX

# Optional: select the site to work in, when you have more than one
Get-AppVentiXSite
Set-AppVentiXSite -Name 'CustomerName'
```

!!! note "About the examples"
    The folder names in this guide are examples. Use a structure that fits your organization, for example by application, department or User Setting type.

## Step 1: Create a folder

```powershell
New-AppVentiXUserSettingFolder -FolderName 'Applications'
```

The command returns the folder name. If the folder already exists, you get a warning and nothing is changed, so it is safe to run the command again in a script.

## Step 2: Create subfolders

Use a backslash to separate the levels. Parent folders that do not exist yet are created as well, so one command is enough:

```powershell
New-AppVentiXUserSettingFolder -FolderName 'Applications\Browsers'
New-AppVentiXUserSettingFolder -FolderName 'Applications\Development\Editors'
```

This results in the following structure in Central View:

```
Applications
├── Browsers
└── Development
    └── Editors
```

You can also create several folders in one go by piping the names:

```powershell
'Drives', 'Printers', 'Environment', 'Registry' | New-AppVentiXUserSettingFolder
```

!!! note
    Folder names are matched case-insensitively. When you type `applications\browsers` and the folder `Applications\Browsers` already exists, the existing folder (and its spelling) is used.

## Step 3: Move User Settings into a folder

Every User Setting has an Id. The `New-AppVentiX*UserSetting` commands return it when you create a setting. For existing settings, look it up by name:

```powershell
Get-AppVentiXUserSettings | Select-Object FriendlyName, Type, Id
```

Move a single User Setting:

```powershell
$edge = Get-AppVentiXUserSettings -FriendlyName 'Microsoft Edge'
Set-AppVentiXUserSettingFolder -FolderName 'Applications\Browsers' -Id $edge.Id
```

`Set-AppVentiXUserSettingFolder` creates the folder (and its parent folders) when needed, so you do not have to run `New-AppVentiXUserSettingFolder` first.

Move all settings of one type at once, for example all drive mappings:

```powershell
Get-AppVentiXUserSettings -Type DriveMapping | ForEach-Object {
    Set-AppVentiXUserSettingFolder -FolderName 'Drives' -Id $_.Id
}
```

Or move everything that belongs to one application, based on a naming convention:

```powershell
Get-AppVentiXUserSettings -FriendlyName 'VS Code*' | ForEach-Object {
    Set-AppVentiXUserSettingFolder -FolderName 'Applications\Development\VS Code' -Id $_.Id
}
```

Add `-PassThru` to see the result:

```powershell
Set-AppVentiXUserSettingFolder -FolderName 'Applications\Browsers' -Id $edge.Id -PassThru
```

## Good to know

- A User Setting is in one folder at a time. Running `Set-AppVentiXUserSettingFolder` again moves it.
- Empty folders are kept, the same as in Central View. Moving the last setting out of a folder does not remove the folder.
- Renaming and removing folders is done in Central View.

## Related

- [Folders in the User Settings Reference](../admin-guide/user-settings-detailed/index.md#folders)
- [New-AppVentiXUserSettingFolder](../powershell-module/commands/New-AppVentiXUserSettingFolder.md)
- [Set-AppVentiXUserSettingFolder](../powershell-module/commands/Set-AppVentiXUserSettingFolder.md)
