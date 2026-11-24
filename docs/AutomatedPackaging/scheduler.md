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

    After **From WinGet…**, click **Schedule…** under **Recipe**. The window shows the package, the installer, the recipe and the certificate of the **Build** screen, and the target of the first job. Read the warnings. Set the interval and up to two times of day, then select **I accept the licence and terms of the vendor**. Click **Save**.

    The item keeps the recipe and the certificate. Other values of the **Build** screen, such as the arguments and the MSI properties, do not go to the item. Put them in the recipe.

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

## When a version is held

The Scheduler holds a new version, and does not build it, in these cases:

- The signature of its installer is not valid.
- Its signer is not the signer of the version before.
- The catalogue names a different publisher.
- An AI agent made or changed the item, and agent signing is set to **Ask**. Then a person must accept it.

A version whose job failed is not tried again. A newer version is.

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

The service connects to the WinGet catalogue directly. If this host reaches the internet only through a proxy, write it in **Upstream proxy** (see [Internet for a worker](worker-internet.md)). The Scheduler uses it too.
