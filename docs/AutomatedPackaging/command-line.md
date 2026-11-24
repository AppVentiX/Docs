# Command line

`AutomatedPackaging.Cli.exe` converts one installer for each call into a signed MSIX package. It does the same checks and the same job as the **Build** screen. It also builds, updates and removes workers, as the **Workers** screen does.

The program is in the installation folder, by default `C:\Program Files\Automated Packaging`. The installer does not add the folder to `PATH`. Use the full path, or run it from that folder.

```
AutomatedPackaging.Cli <command> [arguments]
```

`AutomatedPackaging.Cli --help` shows a short form of this page.

## Before you run it

- **Run it from an elevated prompt.** The program does not ask for elevation itself. If it is not elevated, it says so and exits with code 3.
- **The service must run.** `convert` gives the job to the service **AppVentiX Automated Packaging**, and follows it to its end. With the service stopped, `convert` exits with code 3.
- **Close the window for worker and image commands.** One program at a time changes workers. These commands exit with code 3 while the window is open. `check`, `inspect`, `certificates` and `machines` can run beside the window.
- **Keep the working directory safe.** When the program starts, it examines the working directory as the service does. An account that is not an administrator must not own it or change it, and it must hold no link. If it is not safe, the program writes nothing in it, and its log goes to the data folder. Each command that uses the working directory then exits with code 3 and names each problem. `certificates`, `machines`, `exclusions`, `repair-rules`, `recipe` and `improvement` use only the data folder, and they still run. See [Troubleshooting](troubleshooting.md#running-a-job).
- **Prepare the host first.** The command line uses the settings of the host: workers, images, certificates and the export location.

Before it converts, `convert` finds jobs that a stopped program left. It marks them **Abandoned**, and shows a warning for each. It does not touch their workers. Revert them on the **Jobs** screen.

## Commands

| Command | What it does |
|---|---|
| `convert <installer> [options]` | Converts an MSI or EXE into a signed MSIX package on a worker. Shows the job log, then the result |
| `batch <file> [--no-wait] [--json]` | Adds the installers of a batch file to the queue, all of them or none. Then it waits for each job and shows the result of the batch. See [The queue and batches](#the-queue-and-batches) |
| `status <job-id\|batch-id> [--wait] [--json]` | Shows a job or a batch: waiting, running, or how it ended. With `--wait`, it waits for the end and gives the exit code of `convert` or `batch` |
| `check <installer> [options]` | Lists what stops a conversion, as the Build screen lists it. Starts nothing. It asks what the job asks before it starts. Can somebody who is not an administrator change the signing tools, the packages or the jobs folder (`AP-SG-010`)? Is there an image and a worker for the target? Must the image be updated (`AP-IM-023`)? For an interactive job, does the image have **Finish packaging** (`AP-IM-024`)? Does the image record the engine (`AP-IM-026`)? Does its agent have each feature that the job uses (`AP-IM-030`)? With `--machine`, it asks about the image of that worker. It does not ask for a free worker |
| `inspect <installer> [--certificate-thumbprint <thumbprint> \| --signing-profile <id>] [--json]` | Shows what the Build screen shows about an installer, and what `convert` uses with no options. It names the source of the name, publisher and version. An MSI gives its ProductName, Manufacturer and ProductVersion. An EXE gives the ProductName, CompanyName and ProductVersion of its version resource |
| `certificates [--json]` | Lists the certificates and the Azure Artifact Signing profiles that this host can sign with |
| `machines [--json]` | Lists the workers: name, image, Windows release, target, state and activation |
| `worker build <name> [options]` | Builds a worker and its image, as **Build a worker** does |
| `worker update <name> [options]` | Updates a worker, as **Update** does |
| `worker remove <name> [--confirm]` | Removes a worker and its disks, or a machine from **Incomplete machines** |
| `image forget <image-id>` | Forgets an image record that no worker uses |
| `recipe validate <file> [--json]` | Checks a recipe file and changes nothing. It does not need an elevated prompt. See [Recipes](recipes.md) |
| `recipe add <file> [--json]` | Adds a recipe file to the recipes of this host. A name and version that the host has keep their content (`AP-IM-029`) |
| `recipe list [--json]` | Lists the recipes of this host. `--recipe` takes these names |
| `recipe export <job-id> --out <file> [--name <name>] [--version <n>] [--json]` | Writes the settings of a finished job as a recipe file of format version 2 (`.aprecipe`). The file has no signing, no host paths and no machine. It does not write over a file. See [Recipes](recipes.md) |
| `schedule list [--json]` | Lists the items of the Scheduler: the WinGet package, the version built last, how the last check ended and when the next check is. See [Scheduler](scheduler.md) |
| `schedule add <winget-id> --signing-profile <id> --accept-terms [options]` | Adds a WinGet package to the Scheduler. The service checks it and builds each new version. See [Scheduler](scheduler.md) for the options |
| `schedule remove <item-id> [--json]` | Removes an item from the Scheduler. Its jobs stay in **Jobs** |
| `schedule check [<item-id>] [--json]` | Asks the service to check one item, or every item, in the next minute |
| `schedule accept <item-id> <version> [--json]` | Builds a version that the Scheduler holds |
| `schedule reject <item-id> <version> [--json]` | Does not build a version that the Scheduler holds, and does not try it again |
| `sign-for-release <job-id> [--confirm] [--json]` | Signs the package of a job that an AI agent built with a test certificate, as **Sign for release…** does. Without `--confirm`, it shows what it signs and signs nothing. See [Sign a package for release](jobs.md#sign-a-package-for-release) |
| `resign <package> [options]` | Signs an `.msix` or `.appx` file with a certificate of this host, as **Re-sign a package…** does. Options: `--certificate-thumbprint`, `--signing-profile`, `--package-version`, `--json`. See [Re-sign a package](jobs.md#re-sign-a-package) |
| `exclusions list [--json]` | Lists every layer of the exclusion list: the built-in rules with their IDs and states, the rules of this host, and the sets of each image. See [Exclusions](settings.md#exclusions) |
| `exclusions add <rule> [--note <text>]` | Adds a rule to the list of this host. It gets the next `HO-` ID |
| `exclusions change <HO-nnn> <rule> [--note <text>]` | Changes a rule of this host. The ID stays |
| `exclusions remove <HO-nnn>` | Removes a rule of this host. The ID is not used again |
| `exclusions turn-off <FL-nnn\|BI-nnn> [--confirm]` | Turns off a built-in rule on this host. Without `--confirm`, it shows the warning and changes nothing. `FL-001` and `FL-002` stay on |
| `exclusions turn-on <FL-nnn\|BI-nnn>` | Turns on a built-in rule again |
| `exclusions export <file>` | Writes the rules of this host and the built-in rules that are off to a new file |
| `exclusions import <file> [--confirm] [--json]` | Adds the rules of a file that `exclusions export` or **Export…** made. It skips the rules that the list has already. It turns off the built-in rules that the file turned off. If the file turns off a built-in rule that is on, give `--confirm`. Without it, the command names the rules, shows the warning and changes nothing. A file with one bad rule adds nothing. |
| `repair-rules list [--json]` | Lists the installer repair rules: the built-in rules with their states, then the rules of this host. See [Installer repair rules](settings.md#installer-repair-rules) |
| `repair-rules add <key> [<key> ...] --reason <text> [--case <text>]` | Adds a repair rule to this host. It gets the next `IH-` ID |
| `repair-rules remove <IH-nnn>` | Removes a repair rule of this host. The ID is not used again |
| `repair-rules turn-off <IR-nnn>` | Turns off a built-in repair rule on this host. The next job keeps the rows that it removes |
| `repair-rules turn-on <IR-nnn>` | Turns on a built-in repair rule again |
| `improvement [--json]` | Shows the improvement data level of this host: Off, Minimal or All, and how many records the outbox has. If a policy of your organisation limits the level, it says "Set by your organisation" |
| `improvement set <Off\|Minimal\|All> [--json]` | Sets the improvement data level, as **Settings > Diagnostics** does. A level above the policy of your organisation is refused with exit code 1. Off removes the records. The level is also written for the question at an upgrade. See [Improvement data](settings.md#improvement-data) |
| `backup <folder> [--json]` | Backs up the job history and the settings of this host to a new folder. It holds no passwords and no certificates. See [Back up, restore and move](backup-restore.md) |
| `restore <folder> [--confirm] [--json]` | Checks a backup against this host and tells what a restore would do. With `--confirm`, it restores the backup. Stop the service and close the application first |
| `help` | Shows the usage. Also `--help`, `-h` and `-?` |
| `version` | Shows the version. Also `--version` |

## Options for convert and check

First, the program fills in what the installer tells, as the Build screen does. The ProductName, Manufacturer and ProductVersion of an MSI become the name, publisher and version, unless an option gives a different value. For an EXE, the ProductName, CompanyName and ProductVersion of its version resource do the same. A version that a package cannot have stays empty, so give it. An EXE that only wraps the installer, such as Adobe's self-extractor, gives none of them.

| Option | What it does |
|---|---|
| `--from-capture <job-id>` | Continue from the capture of an earlier job that failed with `AP-PK-005`. The new job does not run the installer; it installs the prerequisites of the earlier job. It packs that capture with the program of `--application`, given by its whole path in the package. See [Select the program of a capture](jobs.md#select-the-program-of-a-capture) |
| `--from-job <job-id>` | Build a new version of the application of an earlier job. The job must have built a package. The job gives the settings, and the other options change them. See [Build a new version of an application](jobs.md#build-a-new-version-of-an-application) |
| `--name <text>` | The name of the application. Default: the ProductName of the MSI or of the version resource of the EXE |
| `--publisher <text>` | The publisher, as people know it. Default: the Manufacturer of the MSI, or the CompanyName of the EXE. The publisher of the package is always the subject of the signing certificate |
| `--package-version <version>` | The package version, up to four numbers. The program fills missing parts with zeros. Default: the ProductVersion of the MSI or of the EXE |
| `--target <target>` | `Windows11Only` (default), `Windows10And11` or `WindowsServer`. On a host with only a Windows 10 image, a job without `--target` is refused: give `--target Windows10And11` |
| `--machine <name>` | The worker to use. A busy worker refuses the job. Without it, a free worker is selected |
| `--engine <engine>` | The conversion engine: `mpt` for Microsoft's MSIX Packaging Tool, or `builtin` for the built-in engine (experimental). Without it, the job uses the default engine of **Settings > Advanced**. A `builtin` job needs a worker whose image records the built-in engine (`AP-IM-026`). A name that the product does not know is refused before a worker is touched (`AP-IM-025`) |
| `--recipe <name[@version]>` | A recipe of this host for the job (see `recipe list`). Without `@version`, the highest version. Microsoft's MSIX Packaging Tool takes only its exclusions. The built-in engine applies all of it. A recipe that is not on this host is refused before a worker is touched (`AP-IM-029`). See [Recipes](recipes.md) |
| `--recipe-file <file>` | A recipe file (`.aprecipe`) to start the job from. The file is added to the recipes of this host. Its values fill the job, and each option on the command line wins. An installer that its `match` does not name is refused (`AP-IM-038`). A transform that is not found once beside the installer or below it is refused (`AP-IM-039`). Not with `--recipe`. See [Recipes](recipes.md) |
| `--ignore-match` | With `--recipe-file`: use the recipe also when its `match` does not name the installer. Each difference is a warning |
| `--application <path>` | The program that the package starts, as a path that ends in `.exe`, for example `Contoso\Tool\tool.exe`. The job finds it in the package by the end of its path, and adds an application on it. An application that the capture already has on the program stays, and the job puts it first, so the start test starts that program. An MSI with no shortcut to a program needs this or `--no-application` (`AP-AN-015`). See [The program to start](convert.md#the-program-to-start) |
| `--no-application` | Builds the package with no application. Nothing in it can start. Only a service or a shell extension in it still works. The job installs and removes the package instead of the start test, and warns |
| `--certificate-thumbprint <thumbprint>` | The signing certificate. Necessary when the host has more than one. `--certificate` also works |
| `--signing-profile <id>` | An Azure Artifact Signing profile that passed **Test**. Not together with `--certificate-thumbprint` |
| `--arguments <text>` | The silent arguments. Necessary for an EXE, for example `"/S"` |
| `--interactive` | You use the installer in a window onto the worker, and click **Finish packaging** on its desktop. See [Interactive installs](convert.md#interactive-installs) |
| `--msi-property <NAME=VALUE>` | An MSI public property. You can give it more than once. `REBOOT=ReallySuppress` is added unless you set `REBOOT` |
| `--no-install-log` | Does not collect the verbose conversion log |
| `--include-folder` | Sends the files and folders beside the installer. At most 4 GB and 20,000 files |
| `--transform <path>` | An MSI transform (`.mst`). You can give it more than once. Applied in the order given |
| `--prerequisite <PRQ-nnn>` | A prerequisite to install before the capture. You can give it more than once |
| `--collect-log <path>` | A log file in the worker to collect. Variables and wildcards work. You can give it more than once |
| `--first-launch` | After the installer, the capture starts the application one time. This is **First-start capture** in Advanced |
| `--settle-seconds <n>` | How long the application runs on its first start. Use it with `--first-launch`. 1 to 600 (default 20) |
| `--priority <priority>` | How soon a free worker takes the job: `low`, `normal` (default) or `high` |
| `--no-wait` | Gives the job ID when the job is in the queue, and does not wait. Exit code 0 |
| `--exit-codes <list>` | Exit codes that mean success, for example `"0,1"`. 3010 and 1641 are refused |
| `--exclude <path>` | A file, folder or registry key that the capture leaves out. You can give it more than once |
| `--min-free-disk-gb <n>` | Free disk space that the worker needs. 1 to 1024 (default 10) |
| `--timeout-minutes <n>` | How long the packaging tool can take. 5 to 480 (default 40, or 120 with `--interactive`) |
| `--restarts <n>` | How many times the worker can restart during a capture with the built-in engine. 1 to 10 (default 3) |
| `--restart-wait-minutes <n>` | How long a capture with the built-in engine waits for the worker after a restart or a shutdown. 5 to 30 (default 5) |
| `--internet-host <name>` | A host name that the worker can reach through the host proxy while the installer runs: `download.example.com`, `*.example.com`, an optional `:port`, or `lan:name` for a host on your network. The proxy must be on. You can give it more than once. See [Internet for a worker](worker-internet.md) |
| `--package-name <name>` | The Name of the package, instead of the name made from `--name` |
| `--change-identity` | Allows a `--package-name` that is different from the last Name of this application |
| `--export` | Copies the package to the export location. Refused when no location is set |
| `--no-export` | Does not export |
| `--psf` | Puts the Package Support Framework in front of the programs of the package, as **Package Support Framework** in Advanced. Get PSF first on Settings > This host. Without it, the job stops with `AP-PK-011` after the capture |
| `--no-psf` | Does not use the Package Support Framework, also when the job of `--from-job` used it. Not with `--psf` |
| `--internal` | The application is your own. Its name stays out of the improvement data |
| `--json` | Writes the result as one JSON object, and nothing else |

## Options for worker and image commands

| Option | Command | What it does |
|---|---|---|
| `--from-image <image-id>` | `worker build` | Takes the Windows release, the edition, the account, the Windows activation and the prerequisites from an image record of this host. For a worker that a restore kept aside, under its own name, it also takes the address. The other options change them. See [Move to a new host](backup-restore.md#move-to-a-new-host) |
| `--medium <id>` | `worker build` | The Windows release to build from. The ID is the name of the release folder under `_import`, for example `Windows11-25H2`, as the **Build a worker** window lists it. Case does not matter. Necessary when more than one release is staged. When you leave it out with more than one release, or give an unknown ID, the command stops and lists the staged releases |
| `--edition <name>` | `worker build` | The edition. Default: the default edition of the release |
| `--account <name>` | `worker build` | The administrator account in the worker. Default: `pkgbuilder` |
| `--address <IPv4>` | `worker build` | The address on the internal switch. Default: the next free address |
| `--activation <method>` | `worker build`, `worker update` | `kms` or `not-activated` |
| `--kms-server <host[:port]>` | `worker build`, `worker update` | The KMS server. `localhost`, a loopback or a link-local address is refused |
| `--confirm-licence` | with `--activation not-activated` | Confirms a valid Windows licence for the image. Your account and the time are recorded |
| `--prerequisite <PRQ-nnn>` | `worker build` | A prerequisite to install at step 7. You can give it more than once |
| `--confirm` | `worker remove` | Removes the machine and its disks. Without it, nothing is removed |
| `--json` | all four | Writes the result as one JSON object |

**Rebuild from media…**, **Revert** and **Retire** are not on the command line. Use the Workers screen.

## The queue and batches

Each job goes into one queue in the service, and gets its ID at once. A free worker takes the highest priority job that it can build, and the oldest first. A job that no worker can ever build is refused at once.

The queue has limits, so that waiting jobs and their installer copies cannot fill the host:

| Limit | Value |
|---|---|
| Jobs from the window that wait | 500 |
| Jobs from the command line that wait | 500 |
| Jobs from AI agents (MCP) that wait | 100 |
| Jobs that wait in total | 1000 |
| Free space on the drive of the working directory after the copy of the installer | 20 GB |

A job or a batch that is more than a limit is refused, and nothing of it goes into the queue. The refusal gives the number that waits and the limit. Wait until jobs start, or cancel waiting jobs, then try again. A waiting job can fail three times at its start with a fault that the queue does not know. Then the queue refuses it with `AP-IM-035` and the last fault.

When a job for the same installer (the same SHA-256) waits or runs, `convert` and `batch` give a warning with the job IDs. The warning also says which of those jobs use the same recipe. The new job still goes into the queue.

A batch file is JSON. Each item has the installer, and the `convert` options as you type them. `sha256` makes sure that the file is the one you checked:

```json
{
  "format": "automated-packaging-batch",
  "formatVersion": 1,
  "priority": "Normal",
  "items": [
    { "installer": "D:\\Installers\\putty-64bit-0.83-installer.msi", "sha256": "<64 hexadecimal characters>",
      "options": ["--target", "Windows11Only", "--machine", "PKGMGR-W1125H2"] },
    { "installer": "D:\\Installers\\7z2501-x64.msi", "priority": "High" }
  ]
}
```

- A field that the format does not know gives `AP-IM-036` with the name of the field. So does a field given two times, or a value of the wrong type.
- An item cannot give `--json`, `--no-wait`, `--interactive` or `--from-capture`. At most 500 items.
- A relative `installer` path is read from the folder of the batch file, not from the current folder. A path such as `\setup.msi` or `C:setup.msi` gives `AP-IM-036`: it depends on the current drive.
- When an item has a problem, nothing goes into the queue. Correct the items and give the batch again.
- When the last job ends, the service writes the report `batches\batch-<id>.json` in the output folder. It gives each item's job, status, package, failure code and detail. `machine` is the worker that ran the job, and `pinnedWorker` is the worker that the item named with `--machine`. For a job that ran during the upgrade to this version, `machine` is the pinned worker, or `not recorded`. It is empty for a job that did not start. Its `result` is `Built`, `PartlyBuilt` or `NotBuilt`.
- Ctrl+C during `batch` cancels each job of the batch that waits or runs.

```
AutomatedPackaging.Cli batch D:\installers\batch.json
AutomatedPackaging.Cli batch D:\installers\batch.json --no-wait --json
AutomatedPackaging.Cli status <batch-id> --wait
```

## Exit codes

| Code | Meaning |
|---|---|
| 0 | Built. For `check`: nothing is in the way. For `inspect`: the installer was read. For a worker or image command: done |
| 1 | Refused before anything started. The reasons follow, one on each line. For `inspect`: the installer could not be read. Also `worker remove` without `--confirm` |
| 2 | The job or the command ran and failed. The `AP-` code and the detail follow |
| 3 | Cannot run here: not elevated, the service does not run, or the host cannot run jobs yet. A worker or image command also stops here while the window or another command line is open. Each command that uses the working directory also stops here when the working directory is not safe to use |
| 4 | Built, but the package did not reach the export location, or not completely. The warning `AP-PK-010` gives the reason |
| 5 | `batch`: some packages were built and some were not. The report of the batch says which |
| 64 | The command line is not correct: an unknown option, an option given twice, or a missing value |
| 130 | Cancelled with Ctrl+C |

The first Ctrl+C cancels the job, and the worker goes back to its baseline. A second Ctrl+C ends the program at once. The next `convert`, or the window, then marks the job **Abandoned**.

## JSON output

With `--json`, the standard output holds one object and nothing else:

```json
{
  "exitCode": 0,
  "result": "Built",
  "jobId": "20260922-205809-c1c288",
  "package": "D:\\AutomatedPackaging\\Packages\\7-Zip-26.03-x64-edition_26.3.0.0.msix",
  "exported": true,
  "exportPath": "\\\\server\\packages\\7-Zip_26.3.0.0_x64\\7-Zip_26.3.0.0_x64.msix",
  "failureCode": null,
  "detail": "Built 7-Zip-26.03-x64-edition_26.3.0.0.msix in D:\\AutomatedPackaging\\Packages. ...",
  "warnings": [ "..." ],
  "problems": [],
  "log": "D:\\AutomatedPackaging\\jobs\\20260922-205809-c1c288\\job.log",
  "installerExitCode": 0
}
```

| Field | Meaning |
|---|---|
| `result` | `Built`, `NotExported`, `ExportIncomplete`, `Ready` (a `check` with nothing in the way), `Refused`, `Failed`, `Cancelled` or `CannotRunHere` |
| `exported` | `null` when the job did not export, `true` when the package reached the export location, `false` when it did not |
| `package` | The package in the output folder. `null` when the package was removed from the output folder after the export |
| `problems` | What stopped a refused run |
| `warnings` | What you must know about a job that ran |
| `installerExitCode` | The exit code of the installer. `null` when it is not known |

A worker or image command writes the same object, with three more fields: `worker`, `image` and, for `worker build` and `worker update`, `steps`. Its `result` is `Done`, `Refused`, `Failed`, `Cancelled` or `CannotRunHere`.

`inspect --json` writes a different object, with `result` set to `Inspected` or `Unreadable`. It holds what the text output shows, for example the file, the type, the arguments, the install command and the identity.

## Examples

```
AutomatedPackaging.Cli certificates

AutomatedPackaging.Cli machines

AutomatedPackaging.Cli inspect D:\installers\7z2408-x64.msi

AutomatedPackaging.Cli check D:\installers\7z2408-x64.msi --certificate-thumbprint 0123456789ABCDEF0123456789ABCDEF01234567

AutomatedPackaging.Cli convert D:\installers\7z2408-x64.msi --certificate-thumbprint 0123456789ABCDEF0123456789ABCDEF01234567 --target Windows10And11 --export

AutomatedPackaging.Cli convert D:\installers\7z2408-x64.msi --machine PKGMGR-W1125H2 --certificate-thumbprint 0123456789ABCDEF0123456789ABCDEF01234567

AutomatedPackaging.Cli convert D:\installers\setup.exe --name "Contoso Editor" --publisher Contoso --package-version 4.2 --arguments "/S" --certificate-thumbprint 0123456789ABCDEF0123456789ABCDEF01234567 --json

AutomatedPackaging.Cli worker build PKGMGR-W1125H2 --medium Windows11-25H2 --kms-server kms.example.com

AutomatedPackaging.Cli worker update PKGMGR-W1125H2

AutomatedPackaging.Cli worker remove PKGMGR-W1125H2 --confirm

AutomatedPackaging.Cli image forget img-0123456789ab

AutomatedPackaging.Cli sign-for-release 20261103-120000-abcdef

AutomatedPackaging.Cli sign-for-release 20261103-120000-abcdef --confirm

AutomatedPackaging.Cli resign D:\Packages\Vendor.App_2.1.0.0_x64.msix --package-version 2.1.1.0
```

## What it does not do

- One installer for each call. For a list, use a loop in your script.
- MCP does not start interactive jobs. Only `convert --interactive` and the Build screen do.
- `check` does not ask for a free worker. The job asks that when `convert` runs. A worker given with `--machine` that is busy then refuses the job.
- The command line listens on nothing. The service opens the worker listener.
- Its log is `cli-<date>.log`, in `<workingDir>\Logs`.
