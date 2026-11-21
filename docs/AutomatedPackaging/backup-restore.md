# Back up, restore and move

A backup keeps the job history and the settings of a host. Use it to restore the host after a fault, or to move the product to a new host.

## What a backup holds

| In the backup | Not in the backup |
|---|---|
| The database: the job history, the package identities, the publisher history, the images and the workers with their build settings, the exclusions and the repair rules | The passwords of the workers and the Azure secrets |
| `host.json`, `media.json` (when the host has one), the licence and the clock mark | The certificates and their keys. They stay in the certificate store of the host |
| The recipes | `agent-channel.json`: it names the authority and the listener of this host |
| The Prerequisites library | Job folders, logs, packages, build tools, the Windows media and the disks of the workers |

A backup holds no secrets. Nothing in it can sign a package or log on to a worker. The job history names your applications and publishers, so keep the backup where only administrators can read it.

## Make a backup

The application and the service can stay open while you make a backup. Make a backup by hand: the product does not make one on a schedule.

=== "GUI"

    1. Open **Settings**, then **Configuration**.
    2. On the **Backup** card, click **Back up now…**.
    3. Select the folder where the backup goes. The backup makes a new folder in it, named `AutomatedPackaging-backup-<date>-<time>`.

    The card shows where the backup is, how many files it holds, and the size of the Prerequisites library in it.

=== "CLI"

    From an elevated prompt:

    ```
    AutomatedPackaging.Cli backup E:\Backups\host-2026-11-21
    ```

    The folder must not be there yet. With `--json`, the result is one object with `result` (`Made` or `Refused`), `folder`, `files`, `bytes`, `prerequisiteFiles`, `prerequisiteBytes`, `schemaVersion` and `said`.

The backup folder is closed: only Administrators, SYSTEM and Hyper-V Administrators can open it. A folder in the data folder or in the Prerequisites library is refused. Put the backup on a different disk, or copy it to a different computer.

## Restore

A restore puts a backup in place on this host. It replaces the database, the configuration files that the backup has, the recipes and the Prerequisites library. It does not touch the passwords of the workers, the certificates or `agent-channel.json`, so on the same Windows each worker keeps working. The clock mark is never set back.

What the restore replaces goes to a folder beside the data folder, named `Automated Packaging.before-restore-<date>-<time>`. Only administrators can open it. To undo a restore, copy its files back while the service is stopped.

=== "GUI"

    The restore runs in host preparation, because the application keeps the database open.

    1. Open **Settings**, then **Configuration**.
    2. On the **Backup** card, click **Restore…**, then **Yes**. Host preparation opens on its **Restore a backup** page, and the application closes.
    3. Type the backup folder, or click **Browse…**.
    4. Click **Check**. It reads the backup and this host, and tells what the restore would do. It changes nothing.
    5. Click **Restore**.

    When the service runs and no job runs, **Restore** stops the service, restores the backup, and starts the service again. When a job runs, wait until it ends. To open the page without the application, start `AutomatedPackaging.PrepareHost.exe --restore`.

=== "CLI"

    1. Stop the service: `Stop-Service AutomatedPackaging`.
    2. Close the application and every command line of the product.
    3. From an elevated prompt:

        ```
        AutomatedPackaging.Cli restore E:\Backups\host-2026-11-21
        AutomatedPackaging.Cli restore E:\Backups\host-2026-11-21 --confirm
        ```

        The first command checks the backup and tells what the restore would do. The second restores it.

    4. Start the service: `Start-Service AutomatedPackaging`.

    With `--json`, the result is one object. Its `result` is `Restored`, `NotConfirmed` or `Refused`. It also has `folder`, `problems`, `schemaVersion`, `setAside` and `said`. Each item of `workers` has `name`, `imageId` and `evidence`.

### What stops a restore

The restore changes nothing when one of these is true. It names each one.

| Refusal | What to do |
|---|---|
| The service runs, or a program of the product is open | Stop the service and close the program |
| A file of the backup is missing or changed, or the folder has a file that `backup.json` does not name | Use a different backup. A changed backup is not restored |
| A newer version of the product made the backup | Install that version or a later one, then restore |
| A worker has its machine on this host, but its password does not open | Remove that worker, or build it again. Then restore |
| A worker has its password on this host, but no machine | Open the application and remove it under **Incomplete machines** on the **Workers** screen. Then restore |
| This host has a worker that the backup does not name: it was built after the backup | Make a new backup, or remove the worker. Then restore |
| Hyper-V did not list the machines of this host | Run host preparation. Then restore |
| Somebody other than Administrators and SYSTEM can change the backup folder, or a folder above it | Copy the backup into a new folder that only administrators can change, for example under `C:\ProgramData`. Then restore from there |

### Which workers stay

The restore asks this host about each worker in the backup:

| On this host | What the restore does |
|---|---|
| The machine is here, and its password opens | The worker stays a worker |
| No machine, and no password that opens | The restore keeps the worker aside, with its build settings. Its image shows **No machine** on the **Workers** screen, with **Build again** |
| The machine, but no password; or the password, but no machine | The restore stops and names the worker |

A worker that was updated after the backup shows its image as the backup recorded it. Click **Update** on its card to bring the image record up to date again. When `host.json` names signing certificates that this host does not have, the restore names them.

The restore keeps the managed name prefix of this host, so the product touches only machines of this host. When the backup has a different prefix, the restore says so, and **Build again** names each worker under the prefix of this host.

The restore also keeps the working directory of this host. When the backup names a different one, the restore says so.

## Move to a new host

A move builds each worker again from media on the new host, with the settings from the backup. The workers of the old host cannot move: the channel authority of a host cannot be exported, and the passwords of the workers open only on the old Windows.

1. On the old host, make a backup, and copy it to the new host.
2. On the new host, install the product and prepare the host. See [Prepare the host](prepare-host.md).
3. Stage the same Windows releases as on the old host. The backup holds the Prerequisites library, but not the Windows media. See [Stage media](stage-media.md).
4. Restore the backup. The restore keeps each worker aside, and its image shows **No machine**.
5. Build each worker again.

=== "GUI"

    On the **Workers** screen, click **Build again** on each card. **Build a worker** opens with the name, the Windows release, the edition, the account, the address, the Windows activation and the prerequisites of the old worker. Click **Build**.

=== "CLI"

    ```
    AutomatedPackaging.Cli worker build PKGMGR-W1125H2 --from-image img-1234567890ab
    ```

    The `machines` command and the **Workers** screen show the image IDs. The other options of `worker build` change the settings.

When a build succeeds, the kept settings of that worker go. The old image record goes with the last worker that names it.

What you set again on the new host:

- The signing certificates: import them into the certificate store of the new host. The backup holds no certificate.
- The Azure secrets of the Azure Artifact Signing profiles: type them again on **Settings > Signing**.
- The licence, if the backup did not hold one.
