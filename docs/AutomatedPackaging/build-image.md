# Build a worker image

A worker is a Hyper-V virtual machine that the product builds and manages. An image is the record of that build: the Windows release, the agent and the prerequisites. A job runs on a worker that is built from an image for its target.

A build takes 30 to 60 minutes. Most of that time is the Windows installation.

=== "GUI"

    Go to **Workers**. The **Build a worker** card is the last row of the list of images.

    | Field | What to enter |
    |---|---|
    | **Windows release** | A staged release. If the list is empty, no release is staged. The card names the folder |
    | **Edition** | Shows only when the ISO has more than one edition. The default is the default of the media |
    | **Machine name** | Starts with the managed prefix, `PKGMGR-`. Add a name after it, for example `PKGMGR-001` |
    | **Address (optional)** | The address of the worker on the internal switch. Leave it empty to get the lowest free address. The box then shows **Automatic: 172.31.7.n** |
    | **Prerequisites** | **Select…** selects the prerequisites to install on the image. See [Prerequisites](prerequisites.md) |
    | **Windows activation** | **KMS server**, or **Not activated**. See [Windows activation](#windows-activation) |

    When you open the Workers screen, the card reads the staged media again. Meanwhile it shows **Reading the staged media…**, and **Build image** waits.

    Click **Build image**, at the bottom of the card. If something is in the way, the card says so before anything starts.

    During the build, a bar of twelve segments shows the steps. Hold the pointer on a segment to see its name. Under the bar, "Step N of 12: …" shows the current step, and each completed step shows its time. **Stop**, beside the step, cancels the build.

=== "CLI"

    Run from an elevated prompt, with the application window closed:

    ```
    AutomatedPackaging.Cli worker build PKGMGR-001 --medium W11-25H2 --kms-server kms.example.com
    ```

    | Option | What it does |
    |---|---|
    | `--medium <id>` | The Windows release, by the ID that the **Build a worker** form lists. Necessary when more than one release is staged |
    | `--edition <name>` | The edition to install. Default: the default edition of the release |
    | `--account <name>` | The administrator account in the worker. Default: `pkgbuilder` |
    | `--address <IPv4>` | The address on the internal switch. Default: the next free address |
    | `--activation <method>` | `kms` or `not-activated`. Default: the activation of the newest image on this host |
    | `--kms-server <host[:port]>` | The KMS server. This also sets `--activation kms` |
    | `--confirm-licence` | With `--activation not-activated`: confirms that your organization has a valid Windows licence for the image |
    | `--prerequisite <PRQ-nnn>` | A prerequisite to install at step 7. You can give it more than once |
    | `--json` | Writes the result as one JSON object |

    The command shows one line for each step when the step starts and ends. Ctrl+C stops the current step and leaves the machine part-way. A second Ctrl+C ends the program at once.

    The steps go to the command line log, `<workingDir>\Logs\cli-<date>.log`.

## The machine name

- It must start with the managed prefix. The prefix stops the product from changing a virtual machine that it did not make.
- It has at most 15 characters: letters, digits and hyphens. The name is also the Windows computer name of the worker.
- A name that is already in use is refused.

## The address

The address must be on the subnet of the internal switch. The address of the host is `172.31.7.1`. It must not be the address of the host or of another worker. The worker keeps its address: an update keeps it, and a rebuild gives it back. Two workers on one address cause failed jobs when both run.

## Windows activation

| Choice | What happens |
|---|---|
| **KMS server** | Give the name or address of your KMS server, with `:port` when it is not 1688. A worker has no DNS, so the server is necessary. Windows activates at step 9 through a relay on this host. The worker stays on the internal switch. The host needs the **KMS relay reachable** firewall rule, which host preparation makes |
| **Not activated** | Windows stays in notification mode. You confirm that your organization has a valid Windows licence for the image. The product records who confirmed it, and when |

The choice starts from the newest image. After the build, it shows read-only. You can change the KMS server later, before an **Update**.

## The twelve steps

| # | Step | What it does |
|---|---|---|
| 1 | Check this host | Runs the host checks. Stops if something blocks |
| 2 | Build the answer file | Selects the address, makes and keeps the worker password, and makes `<name>-unattend.iso` |
| 3 | Create the machine | 8 GB static memory, 4 processors, a 100 GB dynamic disk, media attached |
| 4 | Install Windows | Unattended, with no network. Limit: 60 minutes |
| 5 | Install the packaging tool | The tool, its licence, and the capture driver from the Features on Demand media |
| 6 | Install the agent | The worker makes its own key, and the host signs the request. No private key moves |
| 7 | Install the prerequisites | Installs the prerequisites of the image, in order |
| 8 | Harden the image | Turns off what makes noise in a capture. Refuses if Tamper Protection is on |
| 9 | Reboot and settle | Activates Windows, restarts, and waits five minutes |
| 10 | Calibrate the exclusion set | Four empty captures. What they record becomes the exclusion set of the image |
| 11 | Seal the image | Answers the first-run dialog of the tool, shuts down, and makes the checkpoint `baseline` |
| 12 | Write the image record | Registers the image and the worker |

A build always ends with the worker turned off. The full log is `<workingDir>\Logs\prep-<worker>-<run id>.log`.

## Check the result

=== "GUI"

    A build that worked shows all twelve steps as completed, each with its time. The new image is in the list of the Workers screen, with the state **Ready**. See [Image states](#image-states).

    A build that failed shows the `AP-` code and the reason under the step list, at the step that failed. Find the step and the code in [Troubleshooting](troubleshooting.md#building-a-worker-image).

=== "CLI"

    `worker build` exits with code 0, and with `--json` the `result` is `Done`. Then run `AutomatedPackaging.Cli machines`. The new worker is in the list, with its image and target.

    A failed build exits with code 2. The `AP-` code and the reason follow. See [Exit codes](command-line.md#exit-codes).

## When a build fails

A build that fails or stops after step 3 **does not remove the machine that it made**. The machine shows on the Workers screen under **Incomplete machines**.

=== "GUI"

    1. Under **Incomplete machines**, tick "I understand this permanently deletes the machine and its disks".
    2. Click **Remove…**.

=== "CLI"

    ```
    AutomatedPackaging.Cli worker remove PKGMGR-001
    AutomatedPackaging.Cli worker remove PKGMGR-001 --confirm
    ```

    Without `--confirm`, the command says what it found, and removes nothing.

When the machine is gone, the product also deletes the guest password that the build stored for it.

The product first makes sure that it can remove the machine. It then turns the machine off and removes it. To build again with the same name, remove the machine first.

## Image states

Each image in the list has an icon for its state:

| State | Meaning |
|---|---|
| **Ready** | The image can serve jobs |
| **Ageing** | Calibrated 90 days ago or more |
| **Refresh needed** | Calibrated 180 days ago or more. Jobs still run. An update is worth doing |
| **No worker** | No worker that is in service is built from the image |
| **Update required** | The image is behind this product or the settings of this host. The product does not start a job on it. See [When an image is behind](maintain-images.md#when-an-image-is-behind) |
| **Update recommended** | The image is behind, and jobs still run. An update is worth doing |

The **Activation** fact shows the state of Windows when the image was sealed. A warning shows when a KMS activation ends within 30 days. **Update** renews it. See [Keep images current](maintain-images.md).

Next: [Signing](signing.md).
