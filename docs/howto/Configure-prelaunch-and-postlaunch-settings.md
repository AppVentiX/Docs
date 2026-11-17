# HowTo: Configure Prelaunch and Postlaunch Settings with PowerShell

A managed shortcut can run other User Settings right before the application starts (prelaunch) and after it closes (postlaunch). This lets you prepare a user's workspace only for the people who actually use an application, instead of applying everything to everyone at login.

This guide walks through two example scenarios with the AppVentiX PowerShell module:

- **Visual Studio Code** maps a source code share and sets an environment variable before it starts, and cleans up its cache after it closes.
- **Notepad++** connects a printer before it starts.

!!! note "About the examples"
    The scenarios in this guide are examples to show how the commands work together. Server names, shares, groups and paths such as `\\fileserver.domain.local` are placeholders. Replace them with the values from your own environment, and only use the parts that fit your situation.

For the Central View side of this feature, see [Prelaunch and Postlaunch Settings](../admin-guide/user-settings-pre-post-launch/index.md).

## How it works

- Prelaunch User Settings are processed before the application is started. Postlaunch User Settings are processed when the application has been closed.
- The Filters and Run Once settings of a linked User Setting are honored.
- Mapped drives and printers stay connected until no shortcut assigned to the user links them anymore.
- A linked User Setting cannot be assigned to user groups. It only runs through the shortcut.

These User Setting types can be linked:

| Type in Central View | Type in PowerShell | Create with PowerShell |
|----------------------|--------------------|------------------------|
| Drive Mapping | `DriveMapping` | `New-AppVentiXDriveMappingUserSetting` |
| Environment Variables | `EnvironmentVariables` | `New-AppVentiXEnvironmentVariableUserSetting` |
| External Tasks | `ExternalTasks` | Central View |
| Files and Folders | `ManageFiles` | `New-AppVentiXFilesAndFoldersUserSetting` |
| Printer Mapping | `PrinterMapping` | `New-AppVentiXPrinterMappingUserSetting` |
| Registry Settings | `RegistrySettings` | `New-AppVentiXRegistryUserSetting` |

| Task | Command |
|------|---------|
| Show the linked User Settings of shortcuts | `Get-AppVentiXShortcutLinkedUserSetting` |
| Set the linked User Settings of a shortcut | `Set-AppVentiXShortcutLinkedUserSetting` |

## Prerequisites

- AppVentiX PowerShell module version 2026.1117.1700 or later
- A valid AppVentiX license
- Write access to the AppVentiX Configuration Store
- A Shortcuts User Setting for the application, see [Create Managed Shortcuts with PowerShell](Create-managed-shortcuts-with-PowerShell.md)

```powershell
Import-Module AppVentiX

# Optional: select the site to work in, when you have more than one
Get-AppVentiXSite
Set-AppVentiXSite -Name 'Test'
```

## Example 1: Visual Studio Code

**Scenario:** an organization where developers keep their repositories on a file share (`\\fileserver.domain.local\Source$` in this example), and where internet traffic goes through TLS inspection with the organization's own root certificate. In this scenario the goals are:

- The **S:** drive is only mapped for users who start VS Code, not for every user at login.
- Extensions that use Node.js trust the organization's certificate. Node.js reads the `NODE_EXTRA_CA_CERTS` environment variable for this.
- The VS Code cache is removed when VS Code closes, so it does not grow the user profile (for example an FSLogix profile container).

If your environment has no TLS inspection, leave out the certificate variable. The drive mapping and the cleanup work on their own.

### Step 1: Create the shortcut

```powershell
$codeFolder = 'C:\Program Files\Microsoft VS Code'

$code = New-AppVentiXShortcutUserSetting -FriendlyName 'Visual Studio Code' `
    -IconFile "$codeFolder\Code.exe" `
    -ShortcutEntries @(
        @{
            ShortcutName     = 'Visual Studio Code'
            ExecutablePath   = "$codeFolder\Code.exe"
            WorkingDirectory = $codeFolder
        }
    )

Set-AppVentiXUserSettingFolder -FolderName 'Applications\Development' -Id $code.Id
```

### Step 2: Create the prelaunch settings

```powershell
$sourceDrive = New-AppVentiXDriveMappingUserSetting -FriendlyName 'VS Code - Source drive' `
    -DriveLetter 'S:' -NetworkPath '\\fileserver.domain.local\Source$' -Label 'Source Code'

$caVariable = New-AppVentiXEnvironmentVariableUserSetting -FriendlyName 'VS Code - Root CA certificate' `
    -EnvironmentVariables @(
        @{ Name = 'NODE_EXTRA_CA_CERTS'; Value = '\\fileserver.domain.local\Certificates$\root-ca.pem' }
    )
```

### Step 3: Create the postlaunch setting

A Files and Folders User Setting with two **Delete** actions removes the cache folders:

```powershell
$clearCache = New-AppVentiXFilesAndFoldersUserSetting -FriendlyName 'VS Code - Clear cache' `
    -FileOperations @(
        @{ Action = 'Delete'; Path = '%APPDATA%\Code\Cache' }
        @{ Action = 'Delete'; Path = '%APPDATA%\Code\CachedData' }
    )
```

!!! tip
    A setting you created in Central View can be linked as well. Look up its Id by name, for example for an External Tasks setting:

    ```powershell
    $task = Get-AppVentiXUserSettings -Type ExternalTasks -FriendlyName 'VS Code - Cleanup script'
    ```

### Step 4: Link the settings to the shortcut

```powershell
$linkParams = @{
    Id         = $code.Id
    Prelaunch  = $sourceDrive.Id, $caVariable.Id
    Postlaunch = $clearCache.Id
    PassThru   = $true
}
Set-AppVentiXShortcutLinkedUserSetting @linkParams
```

`-Prelaunch` and `-Postlaunch` take one or more Ids. The list keeps the order you give.

!!! tip "Splatting"
    The parameters are collected in a hashtable and passed with `@linkParams` ([splatting](https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_splatting)). A switch such as `-PassThru` becomes `PassThru = $true`. The same command without splatting:

    ```powershell
    Set-AppVentiXShortcutLinkedUserSetting -Id $code.Id -Prelaunch $sourceDrive.Id, $caVariable.Id `
        -Postlaunch $clearCache.Id -PassThru
    ```

Keep the linked settings together in a folder, the same way Central View puts settings it creates from the Prelaunch and Postlaunch tabs in the **Linked** folder:

```powershell
foreach ($setting in $sourceDrive, $caVariable, $clearCache) {
    Set-AppVentiXUserSettingFolder -FolderName 'Linked\VS Code' -Id $setting.Id
}
```

### Step 5: Assign the shortcut

Only the shortcut is assigned. The linked settings run through it.

```powershell
Set-AppVentiXUserSettingsAssignment -Id $code.Id -ADGroup 'App - Visual Studio Code' -Type Shortcuts
```

## Example 2: Notepad++ with a printer

**Scenario:** support engineers print log files from Notepad++ on a follow-me print queue (`\\printserver.domain.local\FollowMe` in this example). The printer is connected when they start Notepad++, so it does not have to be mapped for everyone at login.

```powershell
$printer = New-AppVentiXPrinterMappingUserSetting -FriendlyName 'Notepad++ - FollowMe printer' `
    -PrinterPath '\\printserver.domain.local\FollowMe'

$npp = Get-AppVentiXUserSettings -Type Shortcuts -FriendlyName 'Notepad++'

Set-AppVentiXShortcutLinkedUserSetting -Id $npp.Id -Prelaunch $printer.Id
Set-AppVentiXUserSettingFolder -FolderName 'Linked\Notepad++' -Id $printer.Id
```

## Change the linked settings later

`Set-AppVentiXShortcutLinkedUserSetting` replaces the list you pass and leaves the other list alone. The easiest way to make a small change is to read the current links, change them and write them back.

Show the linked settings of a shortcut:

```powershell
Get-AppVentiXShortcutLinkedUserSetting -Id $code.Id
```

```
Id           : 3f0c2a51-...
FriendlyName : Visual Studio Code
Prelaunch    : {@{UserSettingId=...; UserSettingType=DriveMapping; UserSettingName=VS Code - Source drive}, ...}
Postlaunch   : {@{UserSettingId=...; UserSettingType=ManageFiles; UserSettingName=VS Code - Clear cache}}
```

Add a prelaunch setting and keep the existing ones. Continuing the VS Code scenario, Git (used from the VS Code terminal and source control view) also has to trust the organization's certificate:

```powershell
$gitCa = New-AppVentiXEnvironmentVariableUserSetting -FriendlyName 'VS Code - Git CA certificate' `
    -EnvironmentVariables @(
        @{ Name = 'GIT_SSL_CAINFO'; Value = '\\fileserver.domain.local\Certificates$\root-ca.pem' }
    )

$links = Get-AppVentiXShortcutLinkedUserSetting -Id $code.Id
$links.Prelaunch += $gitCa.Id
$links | Set-AppVentiXShortcutLinkedUserSetting
```

Remove one prelaunch setting:

```powershell
$links = Get-AppVentiXShortcutLinkedUserSetting -Id $code.Id
$links.Prelaunch = @($links.Prelaunch | Where-Object UserSettingName -ne 'VS Code - Root CA certificate')
$links | Set-AppVentiXShortcutLinkedUserSetting
```

Remove all postlaunch settings, without touching the prelaunch settings:

```powershell
Set-AppVentiXShortcutLinkedUserSetting -Id $code.Id -Postlaunch @()
```

Find every shortcut that maps the source drive before it starts:

```powershell
Get-AppVentiXShortcutLinkedUserSetting |
    Where-Object { $_.Prelaunch.UserSettingName -contains 'VS Code - Source drive' } |
    Select-Object FriendlyName, Id
```

When the links did not change, nothing is written.

## Settings that are assigned to user groups

A linked User Setting cannot be assigned to user groups. When you link a setting that is still assigned, you are asked to unassign it, the same question Central View asks:

```
'Map Public' is assigned to 1 user group(s). Linked user settings cannot be assigned to user groups.
Unassign it now and link it?
```

- Answer **Yes** to remove the user group assignments and link the setting.
- Answer **No** to cancel. Nothing is changed.
- Add `-Force` to unassign without the question. Use this in scripts and scheduled tasks, where nobody can answer.

```powershell
Set-AppVentiXShortcutLinkedUserSetting -Id $code.Id -Prelaunch $sourceDrive.Id -Force
```

The other way around is blocked as well. `Set-AppVentiXUserSettingsAssignment` returns an error for a setting that is linked to a shortcut:

```
User setting 'VS Code - Source drive' is linked to a shortcut (prelaunch) and cannot be assigned to a user group.
```

## Troubleshooting

| Message | Cause |
|---------|-------|
| `User Setting '...' is of type 'GroupPolicy' and cannot be linked.` | Only the six types in the table at the top of this page can be linked. |
| `Shortcuts User Setting '...' not found.` | The `-Id` is not the Id of a Shortcuts User Setting. Check it with `Get-AppVentiXUserSettings`. |
| `Prelaunch User Setting '...' not found.` | The Id of the setting to link does not exist in the Configuration Store. |
| The command stops at the unassign question | The session is not interactive. Use `-Force`. |

## Related

- [Prelaunch and Postlaunch Settings](../admin-guide/user-settings-pre-post-launch/index.md)
- [Create Managed Shortcuts with PowerShell](Create-managed-shortcuts-with-PowerShell.md)
- [Get-AppVentiXShortcutLinkedUserSetting](../powershell-module/commands/Get-AppVentiXShortcutLinkedUserSetting.md)
- [Set-AppVentiXShortcutLinkedUserSetting](../powershell-module/commands/Set-AppVentiXShortcutLinkedUserSetting.md)
