# Scheduler

The Scheduler watches applications in the WinGet community catalogue. When a new version is in the catalogue, the service downloads the installer, checks it, and adds a job to the queue. You do not start these jobs.

An item of the Scheduler is one WinGet package, with the installer to use, a recipe and a certificate. The first job of an item uses the recipe. Each later job is a new version of the job before it: it keeps the package identity and the certificate of that job.

A scheduled job counts toward the starter allowance, as every other job. When no job can start without a licence, the Scheduler downloads nothing and the item says why.

## Find a package and build it once

=== "GUI"

    On the **Build** tab, click **From WinGet…**. Type a part of the name or the ID, and click **Search**. Select the package. The list shows its installers, and one is marked **Recommended**. An installer without a SHA-256 in the catalogue cannot be selected.

    Click **Use selected**. The service downloads the installer and checks it. The window shows how much it downloaded; **Cancel** stops the download. The **Build** screen then fills from the installer, as for a file that you select. A box shows the signer of the installer, or says that it is not signed or that its signature is not valid. For an EXE-type installer, **Arguments** gets the silent switches of the catalogue. The **Silent switches** column shows the default of the type, marked "(default)", when the catalogue names none for a Nullsoft, Inno Setup or Burn installer. Arguments that you typed stay.

=== "CLI"

    The command line has no search. Find the package ID with `winget search`, or on the **Build** tab.

## Add a package to the Scheduler

=== "GUI"

    After **From WinGet…**, click **Schedule…** next to **Build**. The window shows the package, the installer, the recipe and the certificate of the **Build** screen, and the target of the first job. Read the warnings. Check **Name**: the application name of the first job when the recipe gives none. You can change it. Set the interval and up to two times of day. Read **Signer**: the signer of the installer that you downloaded, **Not signed**, or a signature that does not verify. The note under it says which later versions wait for a person. Then select **I accept the licence and terms of the vendor**, which also accepts the signer. Click **Save**.

    Check **Output**. It starts as the **Output** of the **Build** screen: **MSIX**, **AppGo** or **App Attach**. For AppGo and App Attach, choose the **Disk format**: **VHDX** or **CIM**. The window refuses what the **Build** screen refuses: AppGo, and App Attach with CIM, are for Windows 11 only (the window shows it under **Target**). An item for an `msix` or `appx` installer type makes MSIX only. An AppGo item needs no certificate.

    The item keeps the recipe, the certificate and the name. Other values of the **Build** screen, such as the arguments and the MSI properties, do not go to the item. Put them in the recipe.

=== "CLI"

    ```powershell
    AutomatedPackaging.Cli schedule add 7zip.7zip --installer-type msi --signing-profile <id> --accept-terms
    ```

    | Option | What it does |
    |---|---|
    | `--signing-profile <id>` | The certificate of the first job, from `certificates`. Needed |
    | `--accept-terms` | You accept the licence and terms of the vendor for the software that the Scheduler downloads and installs. You also accept the signer of the first version, or that it is not signed. A later version waits for a person when its signer changes or its signature does not verify. Needed: without it, the command refuses and says to add it |
    | `--recipe <name[@version]>` | A recipe of this host for the first job |
    | `--architecture <a>` | `x64` (the default), `x86`, `arm64` or `neutral` |
    | `--scope <s>` | `machine` or `user` |
    | `--installer-type <t>` | For example `msi` or `exe`. `msi` also takes an installer that the catalogue calls `wix` |
    | `--locale <l>` | For example `en-US` |
    | `--interval-hours <n>` | The hours between two checks, 1 to 744. The default is 24 |
    | `--at <HH:mm>[,<HH:mm>]` | One or two times of day, in the local time of the host |
    | `--output <format>`, `--disk-format <format>` | The output (MSIX, AppGo or App Attach) and its disk format. An AppGo item needs no `--signing-profile` |
    | `--appgo-files-gb <n>`, `--appgo-files-most <n>` | With `--output appgo`: the item's own limits on the files beside the `.appgo` file, 1 to 1024 GB and 1 to 10000 files. Without them, a job uses the values of the job before it, else Settings |
    | `--name <text>` | The application name of the first job when the recipe gives none. Without it, the name comes from the package ID |

### What the Scheduler checks when you add an item

The window, the command line and MCP use the same checks and give the same messages. The service asks the catalogue for the newest version. It refuses the item in these cases:

- No installer matches the item, or the installer has no SHA-256 in the catalogue.
- The installer is an `exe`, and the catalogue names no silent switches for it. A `nullsoft`, `inno` or `burn` installer with none uses the default of its type.
- The catalogue does not answer. Nothing is added. Try again later.

### Arguments and name of the first job

The first job of an EXE installer uses the silent switches of the catalogue as its arguments. When the catalogue names none, the job uses the default of the type: `/S` for `nullsoft`, `/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-` for `inno`, `/quiet /norestart` for `burn`. The first job shows whether the default works. It uses these switches, unless the recipe gives arguments. An MSI keeps the arguments of the product. A later version uses the arguments of the job before it.

The name comes from the package ID: `&` becomes `And`, and a character that a name cannot hold becomes `_`. A recipe's name comes first. A later version keeps the name of the job before it.

To use another character than `_`, open **Settings** > **Configuration**, card **Names of scheduled applications**. Type one letter, digit, full stop, hyphen, underscore or space, or leave the box empty to remove such characters. Click **Save replacement**. The next item that you add uses it.

## A ready-made MSIX or APPX package

Some vendors publish their application in WinGet as an MSIX or APPX package. The Scheduler does not convert such a package and does not sign it again. It tests the package of the vendor as it is, on a clean worker for each target.

=== "CLI"

    ```powershell
    AutomatedPackaging.Cli schedule add Mozilla.Firefox.MSIX --installer-type msix --accept-terms
    ```

    With `--installer-type msix` or `appx`, you do not give `--signing-profile`.

The Scheduler checks each new version before it tests it:

- The package is one `.msix` or `.appx` file. A bundle (`.msixbundle` or `.appxbundle`) is refused.
- The subject of the signing certificate is equal to the Publisher in the AppxManifest of the package (`AP-PK-026`).
- This computer trusts the signature (`AP-PK-027`).
- The host service then gets the revocation status of the certificates in that chain, but not of the root. A revoked certificate is refused (`AP-PK-029`). If the host cannot get the status in 15 seconds for each address, the test continues and the item's message gives a warning.
    - With no **Upstream proxy**, Windows gets the status itself, directly, from the CRL or OCSP addresses of each certificate.
    - With an **Upstream proxy**, the host service gets the CRL of each certificate through the proxy, and Windows checks the CRL. This check gets nothing directly. The proxy must allow the CRL addresses of the vendor's certificates, for example `crl3.digicert.com`. Most of these addresses use plain HTTP. A redirect is not followed. This check does not use OCSP: a certificate that has only an OCSP address gets the warning. The service log names each CRL address and whether the CRL came through the proxy.
    - Windows' own check of the signature (`AP-PK-027`) still asks the OCSP addresses of the certificates directly. The product does not control this request. On a host that gets to the internet only through the proxy, this request gets no answer, and the CRLs give the status. If the request gets an answer, Windows keeps it, and the revocation check can use it.
- Each package that WinGet names as a dependency is a Framework MSIX item in [Prerequisites](prerequisites.md), or a runtime that the product installs from the library, such as the Visual C++ Redistributable or a .NET runtime (`AP-PK-028`). The message names the library entry with its vendor, as the **Prerequisites** list shows it. For `Microsoft.DotNet.DesktopRuntime.8`, download "Microsoft .NET Desktop Runtime 8.0 (x64)". See [A runtime that a WinGet package needs](prerequisites.md#a-runtime-that-a-winget-package-needs). The product does not install other dependencies, such as PowerToys or a ZIP file, for a test.

A version that fails the signature checks is not tested, and the Scheduler does not try it again. A version with a missing dependency is tried again at the next check, so you can add the framework or download the runtime first. A new signer holds the version, as for an installer.

The tests of one version run as one batch, with one job for each target. The version passes when all its jobs pass. See [Test a package](jobs.md#test-a-package).

When a test passes and **Settings > Export** is on, the package goes to the export folder. It goes into the folder `<Name>_<Version>_<Architecture>`, as an exported conversion does. The file `SourceInfo.txt` is beside it. It says where the package came from: the source (WinGet), the package ID, the version, the installer URL and the SHA-256 of the file. It also names the publisher, the test job and the target. The package keeps the vendor's signature. The product did not build it and did not sign it. A test that failed exports nothing. A test that you start from the **Test a package** window, the command line or MCP exports nothing.

A later pass of the same version, and the test on another target, put the same file there again and replace it and `SourceInfo.txt`. The product never replaces another package. If the folder holds a package with the same name and version and other bytes, and `SourceInfo.txt` does not name its SHA-256, the product exports nothing. The job still passed, and it carries a warning with `AP-PK-010` that says which file it kept. Remove or rename that file, then test again. A conversion that you export into that folder later removes `SourceInfo.txt`.

## Change a scheduled item

You can change an item after you add it. The package, the source and the installer stay as they are. To change them, remove the item and add it again. A change goes through the checks of an add, with the same words. The next job of the item uses a changed certificate, recipe or output, also for a new version.

An item that an AI agent added or changed last keeps the mark **AI agent**. You can change its schedule and its output. To change its recipe or its certificate, take over the item first.

=== "GUI"

    1. On the **Scheduler** screen, select the item.
    2. Click **Edit**. The **Edit scheduled item** window opens, filled with the item.
    3. Change what you need:
        - **Enabled**: clear it to stop the checks of the item.
        - **Interval (hours)**: 1 to 744.
        - **Times of day**: none, or one or two times as `HH:mm`.
        - **Recipe** and **Certificate**. When the item has no certificate, **Certificate** shows the certificate of the job that was built last. The next job signs with that certificate. If you keep it, the item continues to use the certificate of its last job.
        - **Output** and **Disk format**. An AppGo item signs nothing, so its certificate goes.
        - **AppGo files** (an AppGo item only): the limits on the files beside the `.appgo` file that the next job uses. They are the item's own, else those of the job built last, else those of Settings. Leave them as shown, and nothing changes. Type other values (1 to 1024 GB, 1 to 10000 files), and each next job uses them. Type the values that the item followed, and the item follows them again.
        - **Arguments**: the installer arguments that the next job uses. They are the item's own. Else they are those of the recipe, when its start part has arguments and no job was built since you selected the recipe. Else they are those of the job built last, or before the first job the silent switches of the catalogue. If the service does not answer, the box is empty. Leave them as shown, and nothing changes. Type other arguments, one line of 2000 characters or fewer, and each next job uses them, over the catalogue, the recipe and the job before. Clear the box, or type the arguments that the item followed, and the item follows them again. A vendor's MSIX or APPX item has no **Arguments**.
    4. Click **Save**.

    The window does not ask you to accept the terms again. You accepted them when you added the item. If somebody changes the item while the window is open, **Save** refuses. Close the window and click **Edit** again.

=== "CLI"

    ```powershell
    AutomatedPackaging.Cli schedule change <item-id> [options]
    ```

    | Option | What it does |
    |---|---|
    | `--enabled on\|off` | `off` stops the checks of the item. `on` starts them again |
    | `--interval-hours <n>` | The hours between two checks, 1 to 744 |
    | `--at <HH:mm>[,<HH:mm>]` | One or two times of day. `--at ""` removes the times |
    | `--recipe <name[@version]>` | Another recipe of this host |
    | `--no-recipe` | Removes the recipe of the item. Not with `--recipe` |
    | `--signing-profile <id>` | Another certificate: an ID from `certificates` |
    | `--output msix\|appgo\|appattach` | Another output |
    | `--disk-format vhdx\|cim` | The disk format of an AppGo or App Attach item. When `--output` changes without it, VHDX |
    | `--appgo-files-gb <n>` | The item's own limit for all files beside the `.appgo` file, 1 to 1024 GB. AppGo items only |
    | `--appgo-files-most <n>` | The item's own limit for the number of files beside the `.appgo` file, 1 to 10000. AppGo items only |
    | `--arguments <text>` | The item's own installer arguments, one line of 2000 characters or fewer. They win over the catalogue, the recipe and the job before. `--arguments ""` removes them |
    | `--json` | Writes the item after the change as JSON |

    An option that you do not give keeps the value of the item. Exit code 0 when the item is changed or nothing changed, 1 when the change was refused.

    When the output changes from AppGo, the item's own AppGo files limits go. `schedule add` takes `--appgo-files-gb` and `--appgo-files-most` too.

    AI agents use the MCP tool `change_scheduled_item`. It takes `output`, `diskFormat`, `appGoFilesGigabytes`, `appGoFilesMost` and `arguments` too, on an item of an AI agent only. An empty `arguments` removes the item's own.

## Build a version again

The Scheduler does not try again a version whose job failed or was cancelled. **Build again** builds it. It has no command-line form.

=== "GUI"

    1. On the **Scheduler** screen, select the item.
    2. Click **Build again**. The tip of the button names the version.

    **Build again** takes the newer of the version built last and the version whose job failed or was cancelled. The job follows the rules of a new version: the Scheduler can hold it, and an AI agent's item follows agent signing. A version that was built before gets a higher package version.

    **Build again** is not available when the item has no version yet, when a version is held, or while a job of the item waits or runs. The tip of the button says why. If the catalogue does not list the version any more, the last check of the item says so.

In the window, a right-click on a row of the Scheduler list opens a menu with **Edit**, **Build again** and the other actions of the buttons. See [The right-click menu of a list](jobs.md#the-right-click-menu-of-a-list).

## When a version is held

The Scheduler holds a new version, and does not build it, in these cases:

- The signature of its installer is not valid.
- Its signer is not the signer of the version before.
- The catalogue names a different publisher.
- An AI agent made or changed the item, and agent signing is set to **Ask**. Then a person must accept it.

An item that an AI agent made or changed shows **AI agent**. Its jobs follow agent signing. When you change its interval or times, it stays an item of the agent. To make it your item, click **Take over**. The application asks first. An AI agent then cannot change the item, and MCP asks the person before it removes the item.

A version whose job failed is not tried again. A newer version is.

When a person accepts a version, its signer and publisher are the ones that the next version is compared with. When only an AI agent accepted it, the job is a job of an agent, and the comparison does not change: the next version of the new signer is held again. While agent signing is set to **Ask**, the acceptance of an agent builds nothing. The version stays held with its cause.

The list updates in one minute or less after a job ends or after you remove an item.

=== "GUI"

    The **Scheduler** tab shows one row for each item. The row shows the **Package**, its **Source** (WinGet), **Enabled** and the version built last. It also shows the last check and the next check, in local time.

    **Output** shows what the jobs of the item make: MSIX, AppGo or App Attach, with the disk format. A ready-made MSIX or APPX shows **Vendor package**. **Certificate** shows the certificate that the next job signs with. This is the certificate of the item. If the item has no certificate, it is the certificate of the job that was built last. An AppGo item shows **Not signed**, and a vendor package shows **Vendor signature**. If this host does not have the certificate, the column shows its thumbprint and "(not on this host)".

    On the **Scheduler** tab (Ctrl+2), the item shows a warning. Select it. Click **Accept** to build the version, or **Reject**. A rejected version is not tried again. **Check now** checks the selected item; **Check all** checks every item.

=== "CLI"

    ```powershell
    AutomatedPackaging.Cli schedule list
    AutomatedPackaging.Cli schedule accept <item-id> <version>
    AutomatedPackaging.Cli schedule reject <item-id> <version>
    AutomatedPackaging.Cli schedule check
    ```

## Internet for the host

The service connects to the WinGet catalogue directly. If this host reaches the internet only through a proxy, write it in **Upstream proxy** (see [Internet for a worker](worker-internet.md)). The Scheduler uses it too. The proxy can be on the local network. With a proxy, the proxy decides which addresses the service reaches.
