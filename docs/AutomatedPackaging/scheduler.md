# Scheduler

The Scheduler watches applications in the WinGet community catalogue. When a new version is in the catalogue, the service downloads the installer, checks it, and adds a job to the queue. You do not start these jobs.

An item of the Scheduler is one WinGet package, with the installer to use, a recipe and a certificate. The first job of an item uses the recipe. Each later job is a new version of the job before it: it keeps the package identity and the certificate of that job.

A scheduled job counts toward the starter allowance, as every other job. When no job can start without a licence, the Scheduler downloads nothing and the item says why.

## Find a package and build it once

=== "GUI"

    On the **Build** tab, click **From WinGet…**. Type a part of the name or the ID, and click **Search**. Select the package. The list shows its installers, and one is marked **Recommended**. An installer without a SHA-256 in the catalogue cannot be selected.

    Click **Use installer**. The service downloads the installer and checks it. The **Build** screen then fills from the installer, as for a file that you select. A box shows the signer of the installer, or says that it is not signed or that its signature is not valid.

=== "CLI"

    The command line has no search. Find the package ID with `winget search`, or on the **Build** tab.

## Add a package to the Scheduler

=== "GUI"

    After **From WinGet…**, click **Schedule…** under **Recipe**. The window shows the package, the installer, the recipe and the certificate of the **Build** screen, and the target of the first job. Read the warnings. Check **Name**: the application name of the first job when the recipe gives none. You can change it. Set the interval and up to two times of day, then select **I accept the licence and terms of the vendor**. Click **Save**.

    The item keeps the recipe, the certificate and the name. Other values of the **Build** screen, such as the arguments and the MSI properties, do not go to the item. Put them in the recipe.

=== "CLI"

    ```powershell
    AutomatedPackaging.Cli schedule add 7zip.7zip --installer-type msi --signing-profile <id> --accept-terms
    ```

    | Option | What it does |
    |---|---|
    | `--signing-profile <id>` | The certificate of the first job, from `certificates`. Needed |
    | `--accept-terms` | You accept the licence and terms of the vendor for the software that the Scheduler downloads and installs. Needed |
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
- The installer is an EXE (`exe`, `inno`, `nullsoft` or `burn`), and the catalogue names no silent switches for it.
- The catalogue does not answer. Nothing is added. Try again later.

### Arguments and name of the first job

The first job of an EXE installer uses the silent switches of the catalogue as its arguments, unless the recipe gives arguments. An MSI keeps the arguments of the product. A later version uses the arguments of the job before it.

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
- Each package that WinGet names as a dependency is a Framework MSIX item in [Prerequisites](prerequisites.md) (`AP-PK-028`). The product does not install an EXE or ZIP dependency for a test.

A version that fails the signature checks is not tested, and the Scheduler does not try it again. A version with a missing dependency is tried again at the next check, so you can add the framework first. A new signer holds the version, as for an installer.

The tests of one version run as one batch, with one job for each target. The version passes when all its jobs pass. See [Test a package](jobs.md#test-a-package).

## When a version is held

The Scheduler holds a new version, and does not build it, in these cases:

- The signature of its installer is not valid.
- Its signer is not the signer of the version before.
- The catalogue names a different publisher.
- An AI agent made or changed the item, and agent signing is set to **Ask**. Then a person must accept it.

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
