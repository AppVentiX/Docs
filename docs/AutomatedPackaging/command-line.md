# Command line

`AutomatedPackaging.Cli.exe` converts one installer for each call into a signed MSIX package. It does the same checks and the same job as the **Build** screen. It also builds, updates and removes workers, as the **Images** screen does.

The program is in the installation folder, by default `C:\Program Files\Automated Packaging`. The installer does not add the folder to `PATH`. Use the full path, or run it from that folder.

```
AutomatedPackaging.Cli <command> [arguments]
```

`AutomatedPackaging.Cli --help` shows a short form of this page.

## Before you run it

- **Run it from an elevated prompt.** The program does not ask for elevation itself. If it is not elevated, it says so and exits with code 3.
- **The service must run.** `convert` gives the job to the service **AppVentiX Automated Packaging**, and follows it to its end. With the service stopped, `convert` exits with code 3.
- **Close the window for worker and image commands.** One program at a time changes workers. These commands exit with code 3 while the window is open. `check`, `inspect`, `certificates` and `machines` can run beside the window.
- **Prepare the host first.** The command line uses the settings of the host: workers, images, certificates and the export location.

Before it converts, `convert` finds jobs that a stopped program left. It marks them **Abandoned**, and shows a warning for each. It does not touch their workers. Revert them on the **Jobs** screen.

## Commands

| Command | What it does |
|---|---|
| `convert <installer> [options]` | Converts an MSI or EXE into a signed MSIX package on a worker. Shows the job log, then the result |
| `check <installer> [options]` | Lists what stops a conversion. Starts nothing. It does not ask for a free worker |
| `inspect <installer> [--certificate-thumbprint <thumbprint> \| --signing-profile <id>] [--json]` | Shows what the Build screen shows about an installer, and what `convert` uses with no options |
| `certificates [--json]` | Lists the certificates and the Azure Artifact Signing profiles that this host can sign with |
| `machines [--json]` | Lists the workers: name, image, Windows release, target, state and activation |
| `worker build <name> [options]` | Builds a worker and its image, as **Build an image** does |
| `worker update <name> [options]` | Updates a worker, as **Update** does |
| `worker remove <name> [--confirm]` | Removes a worker and its disks, or a machine from **Incomplete machines** |
| `image forget <image-id>` | Forgets an image record that no worker uses |
| `help` | Shows the usage. Also `--help`, `-h` and `-?` |
| `version` | Shows the version. Also `--version` |

## Options for convert and check

For an MSI, the product fills in the name, publisher and version from the ProductName, Manufacturer and ProductVersion. An option overrides each value.

| Option | What it does |
|---|---|
| `--name <text>` | The name of the application. Necessary for an EXE |
| `--publisher <text>` | The publisher, as people know it. The publisher of the package is the subject of the certificate |
| `--package-version <version>` | Up to four numbers. Missing parts become zeros |
| `--target <target>` | `Windows10And11` (default), `Windows11Only` or `WindowsServer` |
| `--machine <name>` | The worker to use. A busy worker refuses the job. Without it, a free worker is selected |
| `--certificate-thumbprint <thumbprint>` | The signing certificate. Necessary when the host has more than one. `--certificate` also works |
| `--signing-profile <id>` | An Azure Artifact Signing profile that passed **Test**. Not together with `--certificate-thumbprint` |
| `--arguments <text>` | The silent arguments. Necessary for an EXE, for example `"/S"` |
| `--msi-property <NAME=VALUE>` | An MSI public property. You can give it more than once. `REBOOT=ReallySuppress` is added unless you set `REBOOT` |
| `--no-install-log` | Does not collect the verbose conversion log |
| `--include-folder` | Sends the files and folders beside the installer. At most 4 GB and 20,000 files |
| `--transform <path>` | An MSI transform (`.mst`). You can give it more than once. Applied in the order given |
| `--prerequisite <PRQ-nnn>` | A prerequisite to install before the capture. You can give it more than once |
| `--collect-log <path>` | A log file in the worker to collect. Variables and wildcards work. You can give it more than once |
| `--first-launch` | Starts the application once in the capture, after the installer |
| `--settle-seconds <n>` | With `--first-launch`: how long the application runs. 1 to 600 (default 20) |
| `--exit-codes <list>` | Exit codes that mean success, for example `"0,1"`. 3010 and 1641 are refused |
| `--exclude <path>` | A file, folder or registry key that the capture leaves out. You can give it more than once |
| `--min-free-disk-gb <n>` | Free disk space that the worker needs. 1 to 1024 (default 10) |
| `--timeout-minutes <n>` | How long the packaging tool can take. 5 to 480 (default 40) |
| `--package-name <name>` | The Name of the package, instead of the name made from `--name` |
| `--change-identity` | Allows a `--package-name` that is different from the last Name of this application |
| `--export` | Copies the package to the export location. Refused when no location is set |
| `--no-export` | Does not export |
| `--json` | Writes the result as one JSON object, and nothing else |

## Options for worker and image commands

| Option | Command | What it does |
|---|---|---|
| `--medium <id>` | `worker build` | The Windows release, by the ID that the **Build an image** form lists |
| `--edition <name>` | `worker build` | The edition. Default: the default edition of the release |
| `--account <name>` | `worker build` | The administrator account in the worker. Default: `pkgbuilder` |
| `--address <IPv4>` | `worker build` | The address on the internal switch. Default: the next free address |
| `--activation <method>` | `worker build`, `worker update` | `kms` or `not-activated` |
| `--kms-server <host[:port]>` | `worker build`, `worker update` | The KMS server |
| `--confirm-licence` | with `--activation not-activated` | Confirms a valid Windows licence for the image. Your account and the time are recorded |
| `--prerequisite <PRQ-nnn>` | `worker build` | A prerequisite to install at step 7. You can give it more than once |
| `--confirm` | `worker remove` | Removes the machine and its disks. Without it, nothing is removed |
| `--json` | all four | Writes the result as one JSON object |

**Rebuild from media**, **Put it back** and **Retire** are not on the command line. Use the Images screen.

## Exit codes

| Code | Meaning |
|---|---|
| 0 | Built. For `check`: nothing is in the way. For `inspect`: the installer was read. For a worker or image command: done |
| 1 | Refused before anything started. The reasons follow, one on each line. For `inspect`: the installer could not be read. Also `worker remove` without `--confirm` |
| 2 | The job or the command ran and failed. The `AP-` code and the detail follow |
| 3 | Cannot run here: not elevated, the window is open, the service does not run, or the host cannot run jobs yet |
| 4 | Built, but the package did not reach the export location, or not completely. The warning `AP-PK-010` gives the reason |
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

AutomatedPackaging.Cli worker build PKGMGR-W1125H2 --medium W11-25H2 --kms-server kms.example.com

AutomatedPackaging.Cli worker update PKGMGR-W1125H2

AutomatedPackaging.Cli worker remove PKGMGR-W1125H2 --confirm

AutomatedPackaging.Cli image forget img-0123456789ab
```

## What it does not do

- One installer for each call. For a list, use a loop in your script.
- No interactive installs.
- `check` does not ask for a free worker. A job that `check` passes can still be refused if no worker serves the target.
- The command line listens on nothing. The service opens the worker listener.
- Its log is `cli-<date>.log`, in `<workingDir>\Logs`.
