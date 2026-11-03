# Keep images current

Select an image on the **Images** screen. Its actions are on the card under its facts. **Update**, **Put it back** and **Retire** are buttons. **Rebuild from media…**, **Remove the machine…** and **Forget this image record** are in the **More actions** menu.

| Action | Window | Command line |
|---|---|---|
| Update | **Update** | `worker update` |
| Put it back | **Put it back** | Not available |
| Retire | **Retire** | Not available |
| Rebuild from media | **Rebuild from media…** | Not available |
| Remove the machine | **Remove the machine…** | `worker remove` |
| Forget the image record | **Forget** | `image forget` |

The command line acts on workers by name. Run it from an elevated prompt, with the application window closed. To list the workers:

```
AutomatedPackaging.Cli machines
```

## Update

An update runs steps 6 to 12 again on the existing machine, and writes the image record again. It does not install Windows or the packaging tool again.

- Update after you install a newer build of the product. The worker then gets the new agent.
- For a KMS image, an update activates Windows again. This renews the activation.
- An update keeps the address of the worker on the internal switch.
- An update installs prerequisites that you added to the image. It cannot remove a prerequisite.

=== "GUI"

    1. Select the image.
    2. Optional: change the KMS server or the prerequisites on the card.
    3. Click **Update**.

=== "CLI"

    ```
    AutomatedPackaging.Cli worker update PKGMGR-001
    AutomatedPackaging.Cli worker update PKGMGR-001 --kms-server kms2.example.com
    ```

    `--kms-server` changes the KMS server of a KMS image. `--activation` gives a method to an image that recorded none. The steps that an update does not run show as `skipped`.

!!! warning "An update seals the machine as it is"
    An update makes the current disk the new baseline. Do not experiment in a worker before you update it. If you did, use **Rebuild from media** instead.

## Put it back

**Put it back** reverts the worker to its `baseline` checkpoint, and releases a hold on it. If Hyper-V has no machine of that name, it says so. Then use **Remove the machine…** to forget the worker.

## Retire

**Retire** reverts the worker and marks it retired. A retired worker gets no jobs. The machine stays until you remove it. You cannot undo Retire. When you need the worker again, build a new one.

## Rebuild from media

**Rebuild from media…** deletes the machine and its disks. It then runs all twelve steps again, from the same media and edition.

- The product checks the host, the media and the edition before it deletes anything.
- A rebuild that would install a different edition is refused.
- The old image record goes only when the new worker is recorded.

You cannot undo a rebuild.

## Remove the machine

Removing deletes the machine and its disks, and forgets the worker. If no other worker is built from the image, the image record goes too. You cannot undo a removal.

=== "GUI"

    1. Select the image.
    2. In **More actions**, select **Remove the machine…**.
    3. Read the confirmation. It names the machine, says what goes, and says if jobs for the target can still run.
    4. Click the button of the confirmation. **Cancel** or **Esc** goes back.

=== "CLI"

    ```
    AutomatedPackaging.Cli worker remove PKGMGR-001
    AutomatedPackaging.Cli worker remove PKGMGR-001 --confirm
    ```

    Without `--confirm`, the command says what the confirmation on the screen says, and removes nothing. It exits with code 1.

If Hyper-V has no machine of that name, the product deletes nothing and only forgets the worker. If the delete fails, the worker is marked retired, so it gets no jobs.

## Forget an image record

Forget removes an image record that no worker uses. It touches no machine.

=== "GUI"

    Select the image, then **Forget this image record** in **More actions**. When it is the only action left, **Forget** is a button on the card.

=== "CLI"

    ```
    AutomatedPackaging.Cli image forget img-0123456789ab
    ```

    The command is refused while a worker is built from the image. Remove the worker instead.

## Good to know

- **No action takes a worker from a running job.** These actions refuse a worker that something else holds, and name the holder.
- **While an action runs, the image list is locked.** The result stays on the card until you select another image.
- **Closing the window asks first** during a scan, a build, an update, a rebuild, a put back, a retire or a removal. A job continues when the window closes.
- **The managed prefix can change.** Earlier prefixes stay managed, so you can still see and remove the old workers.
- The Images screen acts on the first worker of each image. A second worker of the same image is refused on the command line.
