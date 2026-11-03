# Convert an installer

A job converts one installer into one signed MSIX package. The Build screen and the `convert` command use the same checks and the same job. The service **AppVentiX Automated Packaging** must run.

## Before the job: read the installer

You can see what the product reads from an installer before you start a job.

=== "GUI"

    Go to **Build**. Drop an MSI or EXE on the page, or click **Choose file…**.

    The **Installer** card shows the file name, the size, the type and the full SHA-256. When the product knows the installer framework with high confidence, the type names it, for example "Windows executable · NSIS". The blue help mark beside it explains the silent switch of the framework.

    An MSI is also read for a driver and for a scheduled restart. A driver refuses the job before a worker is used.

=== "CLI"

    `inspect` shows what the Build screen shows, and what `convert` uses with no options:

    ```
    AutomatedPackaging.Cli inspect D:\installers\7z2408-x64.msi
    ```

    `check` lists what stops a conversion, as the Build screen lists it. It starts nothing:

    ```
    AutomatedPackaging.Cli check D:\installers\7z2408-x64.msi --certificate-thumbprint <thumbprint>
    ```

    `check` takes the same options as `convert`. It does not ask for a free worker. With `--machine`, it checks that worker, but not if it is busy.

## Set up the job

=== "GUI"

    The form is on the left. **Package identity** and the buttons are in a column on the right.

    **Install** shows when you select a file:

    | Setting | What it does |
    |---|---|
    | **Install mode** | Leave **Silent** selected. **Interactive** is refused |
    | **Must run on** | The target: "Windows 10 and 11", "Windows 11 only" or "Windows Server". The line "Captures on …" names the image that the target needs |
    | **The machine** | **Automatic** lets the product select a free worker when the job starts. Or select one worker. A worker that is busy then refuses the job |
    | **Signing** | The certificate or Azure profile. A self-signed certificate shows **self-signed** |
    | **Beside it** | "Include the files and folders beside the installer". Off by default |
    | **Silent arguments** | Filled in for a known framework, for example `/qn` for an MSI. Check them for your installer |
    | **MSI properties** | MSI only. `REBOOT=ReallySuppress` is ticked. **Add properties…** opens the full list of public properties |
    | **Transforms** | MSI only. Tick the `.mst` files to apply, or click **Add transform…** |
    | **Install command** | The full command as the worker runs it |
    | **Prerequisites** | **Choose…** selects prerequisites for this job only |
    | **Logs** | "Capture the install log (verbose)" is on by default. Add other log paths, one on each line |

    **Package identity**, in the right column:

    - **Publisher**, **Name** and **Version** come from an MSI. For an EXE, type them.
    - **Version** becomes four numbers, each 0 to 65535. Missing parts become zeros.
    - **Identity** is remembered. The same application gets the same identity next time, so a new package is an update.
    - **Manifest publisher** comes from the signing certificate, not from the **Publisher** field.

=== "CLI"

    ```
    AutomatedPackaging.Cli convert <installer> [options]
    ```

    | Option | Build screen | What it does |
    |---|---|---|
    | `--target <target>` | **Must run on** | `Windows10And11` (default), `Windows11Only` or `WindowsServer` |
    | `--machine <name>` | **The machine** | The worker to use, by name. See `machines`. A busy worker refuses the job |
    | `--certificate-thumbprint <thumbprint>` | **Signing** | Necessary when the host has more than one certificate |
    | `--signing-profile <id>` | **Signing** | An Azure profile that passed **Test**, instead of a certificate |
    | `--include-folder` | **Beside it** | Sends the files and folders beside the installer |
    | `--arguments <text>` | **Silent arguments** | Necessary for an EXE, for example `"/S"` |
    | `--msi-property <NAME=VALUE>` | **MSI properties** | MSI only. You can give it more than once |
    | `--transform <path>` | **Transforms** | MSI only. Applied in the order given |
    | `--prerequisite <PRQ-nnn>` | **Prerequisites** | You can give it more than once |
    | `--no-install-log` | **Logs** | Does not collect the verbose conversion log |
    | `--collect-log <path>` | **Logs** | A log file in the worker to collect. You can give it more than once |
    | `--name <text>` | **Name** | Default: the ProductName of the MSI. Necessary for an EXE |
    | `--publisher <text>` | **Publisher** | Default: the Manufacturer of the MSI |
    | `--package-version <version>` | **Version** | Default: the ProductVersion of the MSI |

    The options of the **Advanced** dialog are in the next section. [Command line](command-line.md) has all options.

## Advanced settings

These settings apply to one job.

=== "GUI"

    Click **Advanced…**. Each value shows where it comes from: "product default", or "overridden for this job". **OK** keeps the changes. **Cancel** keeps none. **Reset to defaults** clears them.

=== "CLI"

    Give the options below to `convert` or `check`.

| Setting | Option | What it does | Allowed values |
|---|---|---|---|
| First-launch capture | `--first-launch` | After the installer, starts the application once in the capture. What it writes at the first start is then in the package | On or off (default off) |
| First-launch settle time | `--settle-seconds <n>` | How long the application runs at that first start | 1 to 600 seconds (default 20) |
| Valid installer exit codes | `--exit-codes <list>` | Exit codes that mean success. 3010 and 1641 are refused here | Default `0` |
| Additional exclusions | `--exclude <path>` | Files, folders or registry keys that the capture leaves out | Fully expanded paths. `REGISTRY\MACHINE\...` for the registry |
| Minimum free disk space | `--min-free-disk-gb <n>` | Free space that the worker needs before the capture | 1 to 1024 GB (default 10) |
| Packaging tool timeout | `--timeout-minutes <n>` | How long the packaging tool can take | 5 to 480 minutes (default 40) |
| Package identity | `--package-name <name>` | The Name of the package. To Windows, a different Name is a different application | 3 to 50 characters: letters, digits, `.` and `-` |
| Export the package | `--export`, `--no-export` | Copies the package to the export location. See [Export packages](export.md) | Default: the Settings value |

Network mode shows on the Advanced dialog, and only host-only is available.

On the command line, a `--package-name` that is different from the last Name of this application is refused. Add `--change-identity` to build it. Users with the old package do not get the new package as an update.

## Start the job

=== "GUI"

    Click **Build**.

    - If **Build** is not available, the reasons show under the buttons as **Standing in the way**.
    - If **Build** in the navigation is not available, the host needs preparation first.
    - **About this installer** shows notes that block nothing. For example, an MSI that declares a service (`AP-AN-011`), or that schedules a restart (`AP-AN-010`).

    While the job runs, the Build screen shows a bar, the time and the current step. **Open in Jobs** selects the job on the **Jobs** screen. **Cancel** stops the job.

    At the end, the screen says "Built `<file>` in `<folder>`." or "Failed `<code>`: …".

=== "CLI"

    Run from an elevated prompt:

    ```
    AutomatedPackaging.Cli convert D:\installers\7z2408-x64.msi --certificate-thumbprint <thumbprint> --target Windows10And11 --export
    ```

    For an EXE, give the name, publisher, version and silent arguments:

    ```
    AutomatedPackaging.Cli convert D:\installers\setup.exe --name "Contoso Editor" --publisher Contoso --package-version 4.2 --arguments "/S" --certificate-thumbprint <thumbprint> --json
    ```

    The command shows the job log while it runs, then the result. The exit code tells a script the result: 0 is built, 1 is refused, 2 is failed. See [Exit codes](command-line.md#exit-codes).

    The first Ctrl+C cancels the job, and the service puts the worker back. A second Ctrl+C ends the program at once.

The **Jobs** screen shows each job and its log, from the window, the command line and MCP.

## The installer and its files

- **Silent arguments.** A known framework gets its usual switches. Some installers need more. An EXE with no arguments is refused, because it would wait on a dialog until the job times out.
- **The folder beside the installer.** Only the installer goes to the worker, unless you include the folder. Include it for an MSI with external `.cab` files, or a `setup.exe` with a data folder. The limits are 4 GB and 20,000 files. A drive root or a folder with a link is refused.
- **Restarts.** `REBOOT=ReallySuppress` stops an MSI from restarting the worker. Untick it only for an installer that needs it.
- **Logs.** For an MSI, an Inno Setup or a WiX Burn installer, the job also collects the log of the installer as `install.log`. A log larger than 32 MB is not collected. A job collects at most 64 files and 256 MB.

Leave the installer and its folder unchanged while the job runs. The job checks each file again when it sends it, and stops with `AP-IN-015` or `AP-IN-016` if a file changed.

## What the job does

1. It takes a free worker for the target, and puts it back to `baseline`.
2. It sends the installer to the worker, and starts the agent.
3. It runs the pre-flight checks, then the capture with the MSIX Packaging Tool.
4. It collects the logs from the worker, also when the capture fails.
5. On the host, it unpacks, checks, corrects and signs the package.
6. Smoke test: it puts the worker back to `baseline`, installs the signed package and starts the application.
7. It puts the worker back to `baseline`. It always does this: after success, failure, timeout or cancel.

A job tries again once, by itself, only after a lost connection, an agent that stopped, or a worker that stopped.

The smoke test passes when a program of the package starts and still runs a minute later. When every application of the package is a service, the smoke test starts the service instead.

## Installers that ask for a restart

The worker does not restart during a capture. When an installer exits with 3010 or 1641, the product runs the `RunOnce` work of the installer in the capture. The package then holds the result. The job succeeds with a warning that names the commands.

Two things refuse the package with `AP-IN-013`:

- files that the installer replaces or deletes at the next start,
- `RunOnceEx` work.

An installer that restarts Windows by itself fails the job with `AP-IN-009`.

## More than one job at a time

- One job runs on one worker. Two workers can run two jobs at the same time.
- With **Automatic**, the second job gets another free worker for its target.
- A job for a busy, selected worker is refused with `AP-HV-007`.
- You can close the window. The job continues in the service.
- Before a job starts, the window or the command line copies the installer to `<workingDir>\Jobs\_handover\`. The service cannot see your mapped drives.

## Where the results go

| What | Where |
|---|---|
| The package | `<workingDir>\Packages\<PackageName>_<Version>.msix` |
| Notes of the package | `<PackageName>_<Version>.notes.txt` and `.PackageInfo.json`, beside the package |
| The job log | `<workingDir>\jobs\<job id>\job.log`, and on the **Jobs** screen |
| Collected logs | `<workingDir>\jobs\<job id>\Collected files\` |

Next: [Jobs and packages](jobs.md).
