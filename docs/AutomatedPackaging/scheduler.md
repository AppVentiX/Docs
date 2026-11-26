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
- The certificate of the vendor is not revoked (`AP-PK-029`). The host service asks the certificate authority. When it gets no answer, the test runs, and the item's last check says that revocation was not checked.
- Each package that WinGet names as a dependency is a Framework MSIX item in [Prerequisites](prerequisites.md), or a runtime that the product installs from the library, such as the Visual C++ Redistributable or a .NET runtime (`AP-PK-028`). See [A runtime that a WinGet package needs](prerequisites.md#a-runtime-that-a-winget-package-needs). The product does not install other dependencies, such as PowerToys or a ZIP file, for a test.

A version that fails the signature checks is not tested, and the Scheduler does not try it again. A version with a missing dependency is tried again at the next check, so you can add the framework or download the runtime first. A new signer holds the version, as for an installer.

The tests of one version run as one batch, with one job for each target. The version passes when all its jobs pass. See [Test a package](jobs.md#test-a-package).

## When a version is held

The Scheduler holds a new version, and does not build it, in these cases:

- The signature of its installer is not valid.
- Its signer is not the signer of the version before.
- The catalogue names a different publisher.
- An AI agent made or changed the item, and agent signing is set to **Ask**. Then a person must accept it.

An item that an AI agent made or changed shows **AI agent**. Its jobs follow agent signing. When you change its interval or times, it stays an item of the agent. To make it your item, click **Take over**. The application asks first. MCP then asks the person before it changes the item.

A version whose job failed is not tried again. A newer version is.

When a person accepts a version, its signer and publisher are the ones that the next version is compared with. When only an AI agent accepted it, the job is a job of an agent, and the comparison does not change: the next version of the new signer is held again. While agent signing is set to **Ask**, the acceptance of an agent builds nothing. The version stays held with its cause.

The list updates in one minute or less after a job ends or after you remove an item.

=== "GUI"

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
