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
    4. On the **Ready to install** page, click **Install**.
    5. Complete the installation.

    !!! note
        The folder page uses the standard WiX folder dialog, so it can look like the program folder. The folder that you select is the working directory.

=== "CLI"

    Install with no user interface. Give the working directory with `WORKINGDIR`:

    ```
    msiexec /i AutomatedPackaging-<version>.msi /qn WORKINGDIR=D:\AutomatedPackaging
    ```

    Without `WORKINGDIR`, the installer uses the value of an earlier installation, or `C:\AutomatedPackaging`.

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
