# Install

The installer is `AutomatedPackaging-<version>.msi`, for example `AutomatedPackaging-0.2.41.msi`. It installs the program to `%ProgramFiles%\Automated Packaging`, always.

## Before you start: two runtimes

Install two runtimes from Microsoft first. Get them on Microsoft's page [Download .NET 10.0](https://dotnet.microsoft.com/download/dotnet/10.0):

1. In the section **.NET Desktop Runtime 10.0.n**, download the **x64** installer for Windows.
2. In the section **ASP.NET Core Runtime 10.0.n**, download the **x64** installer for Windows.
3. Run both installers. `n` is the newest patch.

If a runtime is missing, the MSI stops before it installs anything. It says "Automated Packaging needs the .NET 10 Desktop Runtime (x64)…" or "Automated Packaging needs the ASP.NET Core 10 Runtime (x64)…". Install that runtime, then start the MSI again.

## Run the installer

=== "GUI"

    1. Start `AutomatedPackaging-<version>.msi`.
    2. Read the welcome page and accept the licence.
    3. On the folder page, select the **working directory**. The default is `C:\AutomatedPackaging`.
    4. On the **Improvement data** page, select **Off**, **Minimal** or **All**. Off is selected. See [Improvement data](settings.md#improvement-data).
    5. On the **Ready to install** page, click **Install**.
    6. Complete the installation.

    !!! note
        The folder page uses the standard WiX folder dialog, so it can look like the program folder. The folder that you select is the working directory.

=== "CLI"

    Install with no user interface. Give the working directory with `WORKINGDIR`:

    ```
    msiexec /i AutomatedPackaging-<version>.msi /qn WORKINGDIR=D:\AutomatedPackaging
    ```

    Without `WORKINGDIR`, the installer uses the value of an earlier installation, or `C:\AutomatedPackaging`.

    The installer asks which improvement data this host keeps: **Off**, **Minimal** or **All**. Off is selected. For an unattended installation, add `IMPROVEMENTDATA=Off`, `Minimal` or `All`.

The installer also creates the working directory, closed from the start, before it starts the service. Only `Administrators`, `SYSTEM` and `Hyper-V Administrators` can change it. The virtual machines can write in it. When the folder is already there, the installer does not change it.

An upgrade does not stop for a folder that is already there. An installation on a host that had the product before does not stop either. Host preparation checks the folder in **Working directory access**. See [Folder access](prepare-host.md#folder-access).

A first installation on a host checks a folder that is already there. It stops if an account that is not an administrator owns the folder, can write it, or can replace it from a folder above. It also stops if the folder holds a link. The installer then names the folder and each problem, and installs nothing. If nothing in the folder is yours, delete it. If it holds files that you need, move them to a different folder, then delete it. Then run the installer again. You can also give the installer a different working directory.

**The working directory must be a folder, not a drive.** A first installation with the root of a drive, for example `WORKINGDIR=D:\`, stops and installs nothing. Run the installer again and give a folder, for example `D:\AutomatedPackaging`. A host that already has the root of a drive as its working directory keeps it at an upgrade.

When the service starts, it examines the working directory again. The window and the command line do this too when they start. If the folder is not safe, none of them writes in it. See [Troubleshooting](troubleshooting.md#running-a-job).

## Check the installation

| Check | Correct result |
|---|---|
| The Start menu | **Automated Packaging** is there |
| **Services** (`services.msc`) | **AppVentiX Automated Packaging** shows **Running**, with startup type **Automatic** |
| The registry, `HKLM\Software\AppVentiX\Automated Packaging` | The value `WorkingDirectory` holds the folder that you selected |
| `net localgroup "AppVentiX Packaging Operators"` | The group exists. It has no members yet |

If the service is not running, start it in **Services**. If it does not start, read `<workingDir>\Logs\service-<date>.log`.

## Select the working directory with care

The working directory holds tens of gigabytes of media and all worker disks. **You cannot change it after the installation.** The installer writes it to the registry, `HKLM\Software\AppVentiX\Automated Packaging`, value `WorkingDirectory`. The product reads that value. An upgrade keeps the value.

## What the installer does

- It installs the application, the command line, the host preparation wizard and the MCP relay.
- It adds the Windows service **AppVentiX Automated Packaging**. The service runs every job.
- It creates the local group **AppVentiX Packaging Operators**, empty. Members can use the product from MCP clients.
- It creates the data folder `%ProgramData%\AppVentiX\Automated Packaging`. Only `Administrators`, `SYSTEM` and `Hyper-V Administrators` can change it.

If the data folder is already there and is not safe, the installation stops. Nothing is installed. The message names the folder and each problem: an owner that is not an administrator, write access for other accounts, or a refused file.

- If nothing in the folder is yours, delete the folder.
- If it holds data of this product, run host preparation and apply **Data folder access**. Delete each file that it names. Then start the installer again.

## Uninstall

Uninstalling keeps the working directory, the data folder, the channel certificate authority and the `WorkingDirectory` registry value. A later installation then finds the same folder.

A first installation that fails removes its changes, but two empty folders can stay. These are
the data folder and, when the installation made it, the working directory. Only administrators
can change them. The next installation examines them and uses them. You can also delete them.

Uninstalling removes `NT SERVICE\AutomatedPackaging` from `Administrators` and from `Hyper-V Administrators`. It also removes the inbound firewall rules that host preparation made. These are the rules named "Automated Packaging DNS sinkhole", "Automated Packaging worker channel", and "Automated Packaging KMS relay", with or without "(service)" or "(command line)". A rule with one of these names for a different program stays, and so do all other rules. The group `AppVentiX Packaging Operators` stays, with its members. An upgrade removes none of these. When a first installation fails, the installer also removes the service from `Administrators`.

**An upgrade cannot change the working directory.** If the host has a working directory and the installation gives a different one, the installation stops and names both folders. A silent installation ends with that error. Remove `WORKINGDIR=` from the command line, or give the folder that the host has.

## What lives where

The application creates these folders under the working directory. It does this at host preparation, and again each time it starts. A folder that you delete comes back empty.

```
<workingDir>\
  _import\<release>\   drop folders: put the two ISOs of a release here
  Distro\
    OS\<release>\ISO   prepared installation media (the product fills this)
    OS\<release>\FOD   prepared capture driver media (the product fills this)
    Tools\             the MSIX Packaging Tool bundle and its licence (you fill this)
    Prerequisites\     the files of the prerequisites library
  Tools\               the packaging tools of the host; adksetup.exe goes here too
  Workers\<name>\      one folder for each worker, with its disks
  jobs\<job id>\       one folder for each job
  Packages\            finished packages
  Logs\                logs of the application, the service and the preparations
```

Each folder that you fill has a `.what-goes-here.txt` note.

The data folder `%ProgramData%\AppVentiX\Automated Packaging` holds:

| File or folder | What it holds |
|---|---|
| `automatedpackaging.db` | Jobs, images, workers and package identities |
| `agent-channel.json` | The worker listener: address, port, certificate thumbprints, the worker list and the worker limits |
| `host.json` | Host settings, for example the managed name prefix, housekeeping and export |
| `secrets\` | Worker passwords, encrypted, one file for each worker |
| `certificates\` | Channel certificates. Never your signing key |
| `diagnostics\` | Support information files |

Next: [Prepare the host](prepare-host.md).
