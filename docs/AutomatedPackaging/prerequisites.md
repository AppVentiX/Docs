# Prerequisites

Some applications need a runtime before they start: the Visual C++ runtime, WebView2, a .NET runtime or a Windows feature. A prerequisite installs such a runtime on the worker, **outside** the package. You can put it on an image, or on one job.

!!! warning "A prerequisite is not in the package"
    Each machine that gets the package needs the same prerequisites first. The notes of the package say which ones.

## The library

**Prerequisites**, in the navigation, holds the library. Each item gets an ID when you add it, for example `PRQ-001`. An ID is never used again, also not after you remove the item. You manage the library in the application window. The command line uses the IDs.

The list has two groups:

- **Library**: the items stored on this host.
- **Offered, not downloaded**: items that the product can download from the vendor.

Select an item to see its facts, how it installs, and **Used by**: the images, jobs and items that use it.

The screen opens at once. While it reads the library and the files of each item, a ring shows above the list.

A newer version of the product can store an item of a kind that this version does not know. You can see this after you go back to an earlier version, or restore a backup from a newer one. The list does not show such an item, and a message names it. The product keeps the item and its files as they are. An image or a job that asks for it is refused, with that reason. Update the product to use the item again.

![The Prerequisites screen, with a Visual C++ item selected](images/prerequisites.png)

### Download from the vendor

Select an item under **Offered, not downloaded**, then click **Download**. The product keeps the file only when Windows accepts it as signed by Microsoft. Where the vendor publishes a hash, the hash must also match.

| Item | Source |
|---|---|
| Visual C++ v14 Redistributable (x64, x86) | Microsoft's permanent links |
| Edge WebView2 Runtime (x64, x86) | The Evergreen standalone installer |
| .NET Framework 4.8.1 | The offline installer |
| .NET Desktop Runtime 8.0 and 10.0 (x64) | Microsoft's .NET release data |
| PowerShell 7 (x64) | The PowerShell release on GitHub |

After the download, check the **On the target** text of the item, under **Edit…**.

**Check for updates**, under the list, asks the vendors for newer versions of these items. An item with an update shows an arrow, and **Update to …**.

### Add your own

Click **Add a prerequisite…**. An item has one of four types:

| Type | What runs |
|---|---|
| **EXE installer** | The file, with its arguments |
| **MSI package** | `msiexec /i <file> <arguments>`, with `/qn`, `/norestart` and a log added |
| **PowerShell script** | The script, in Windows PowerShell 5.1 or PowerShell 7 (**Engine**) |
| **Windows feature** | DISM turns on a feature of Windows, such as .NET Framework 3.5. See [A Windows feature](#a-windows-feature) |

**Items must install offline.** A worker has no route to the internet. A web installer fails.

The important fields:

| Field | What it is for |
|---|---|
| **Vendor**, **Name**, **Version** | What the item is |
| **Files** | The installer and the files it reads. **Select files…** copies them to `<workingDir>\Distro\Prerequisites\PRQ-nnn` |
| **Arguments** | The silent switches |
| **Success codes** | The exit codes that mean success, for example `0` |
| **Minutes allowed** | 1 to 240 minutes, default 30 |
| **Restart allowed** | When ticked, exit code 3010 or 1641 restarts the worker |
| **Detected by** | How the product finds the item: a file, a registry value, an MSI product code, or a script |
| **Needs first** | Items that this item needs first |
| **On the target** | What a target machine needs. This text goes into the notes of each package |

Click **Save**. The product records the hash of the files. A file changed by hand in `Distro\Prerequisites` stops the item with `AP-PK-012`.

To change the files, select **New version…**. The item keeps its ID.

### A Windows feature

Some applications need a feature of Windows that is off, such as .NET Framework 3.5. Select the type **Windows feature**. Then select the feature in **Feature**, or type its name as DISM knows it, for example `NetFx3`. `Get-WindowsOptionalFeature -Online` shows the names.

- The item has no files and no arguments. The source is the Windows installation ISO of the worker, which the worker keeps as a DVD. The product gives DISM the folder `sources\sxs` of that DVD, with `/LimitAccess`.
- The product finds the item by the state of the feature.
- DISM exits with 3010 when the feature needs a restart. **Restart allowed** is ticked for a new item.
- When **On the target** is empty, the notes of the package say "The Windows feature `<feature>`, enabled."

For .NET Framework 3.5 on Windows 10 and 11, use this type. The offline installer of Microsoft exits with 1603 there.

When an MSI needs .NET Framework 3.5 before it installs, the Build screen and `inspect` say so under **About this installer**, and name the feature `NetFx3`.

If DISM does not find the files, the item fails. The message names the Windows release of the worker and its DVDs. Rebuild the worker from its media if the DVD is missing.

**Limits.** A feature whose files are not in Windows and not in `sources\sxs` cannot be installed. Windows capabilities, such as language packs or RSAT tools, are not supported.

## On an image

Prerequisites on an image install at step 7, before hardening. Use this for a runtime that many applications need: it installs once.

=== "GUI"

    On the **Build a worker** card, or on the card of an image, click **Prerequisites: Select…** and tick the items. On an existing image, click **Update** to install what you added.

=== "CLI"

    ```
    AutomatedPackaging.Cli worker build PKGMGR-002 --medium Windows11-25H2 --kms-server kms.example.com --prerequisite PRQ-001 --prerequisite PRQ-003
    ```

    `worker update` keeps the prerequisites of the image.

An update cannot remove a prerequisite from a machine. **Rebuild from media** builds a new Windows with exactly the selected items. A failure at step 7 is `AP-IM-022`.

## For one job

=== "GUI"

    On the **Build** screen, click **Prerequisites: Select…**.

=== "CLI"

    ```
    AutomatedPackaging.Cli convert D:\installers\app.msi --certificate-thumbprint <thumbprint> --prerequisite PRQ-002
    ```

For a job with prerequisites:

1. The worker goes back to `baseline`, and the items install. An item that the image has is not installed again.
2. The worker restarts once. A short calibration adds what the items changed to the exclusions of the job.
3. The worker makes the checkpoint `prerequisites`. The capture then does not see the items.
4. The smoke test uses the `prerequisites` checkpoint, so the package is tested with its prerequisites.
5. At the end, the worker goes back to `baseline`.

The items install again for each job. A failure is `AP-IN-014`.
