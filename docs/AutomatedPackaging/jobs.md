# Jobs and packages

## Follow a job

=== "GUI"

    The **Jobs** screen shows each job and its log, from the window, the command line and MCP. Select a job to see its facts and its log while it runs.

    - **Cancel job**, under the facts of a running job, stops it. The service puts the worker back to its baseline first. The job then shows Cancelled.
    - **Copy log** and **Open log file** give you the log.
    - A failed job shows a failure card above its log: the code, the step, a headline, **What to try** and **Copy diagnostic**.

=== "CLI"

    `convert` shows the job log while the job runs, then the result. With `--json`, it shows only one JSON object at the end. See [JSON output](command-line.md#json-output).

    The log of each job is in `<workingDir>\jobs\<job id>\job.log`. Ctrl+C asks the service to stop the job.

The job log tags each line `host`, `agent` or `pipeline`. The last lines give the `AP-` code and the reason of a failure.

## Results on the Jobs screen

| Result | Meaning |
|---|---|
| **Built** | The package is built, signed and smoke-tested |
| **Built, exporting** | The package is built. The copy to the export location runs now |
| **Built, not exported** | The package is built, and the copy to the export location failed. The reason is under the facts of the job. See [Export packages](export.md) |
| Failed | The job failed. The failure card gives the code and what to try |
| Cancelled | Somebody stopped the job |
| Abandoned | The program that ran the job ended before the job did |

## Sign a package again

If a job fails only at signing, you can sign its package again. For example, a hardware token asked for a PIN too late.

1. Select the job on the **Jobs** screen.
2. Click **Retry signing**.

This signs the package that the job built, in seconds, with no worker. A package signed again is **not** smoke-tested, and the screen says so.

- Retry signing needs the `out\` folder of the job. Housekeeping removes it after the days set on **Settings > Folders**.
- It signs only the package that the job packed. A package that changed since then is refused with `AP-SG-011`. Build the job again.
- If the job was to export, Retry signing also exports the package.

## After a crash

If the application, the service or the host stopped during a job, the **Jobs** screen shows a panel at the next start. For each job or worker operation that did not end:

- **Revert worker** puts the worker back to its baseline.
- **Keep for diagnosis** keeps the worker as it is. A kept worker takes no jobs until you revert it.

Nothing is reverted without your decision, because the worker is the evidence.

When the service stops, it cancels its jobs and puts their workers back. A job that has not ended after three minutes shows Abandoned at the next start of the service.

## Housekeeping

The application removes the files that jobs leave. It does this when it starts, and once a day while it is open. Set the days on **Settings > Folders**, under **Housekeeping**, then click **Save housekeeping**. Each value is 1 to 365 days.

| Setting | Default | What is removed after the days |
|---|---|---|
| **A failed job's build folders, kept for** | 14 days | `captured\`, `work\` and `out\` of a job that failed, was cancelled or was abandoned. The logs stay |
| **Job logs, kept for** | 30 days | All other files in the folder of the job, then the folder. The job stays on the Jobs screen |

A job that built removes its build folders itself. A job that runs or waits is never touched.

While `host.json` cannot be used as written, housekeeping removes nothing. The application log says why.

## Free up space

**Free up space…**, under the job list on the **Jobs** screen, removes files sooner, of any age. It measures each kind when it opens:

- **Build folders of jobs**: the three build folders of each job that still has them.
- **Job logs**: the logs of each job that ended.
- **Exported packages in the output folder**: a package in `<workingDir>\Packages\` that its job exported. The product removes it only when it is the same file that was exported, and the copy is still at the export location.

1. Tick what to remove.
2. Click **Remove ticked…**.
3. Read the confirmation. It gives the size, for example "Remove 1.2 GB from this host?".
4. Click **Remove**.

The screen then says how much it removed, and names each item that it kept. You cannot get back what it removed.

## What the notes of a package say

Beside each package, the job writes `<package>.notes.txt` and `<package>.PackageInfo.json`. They give:

- the application, vendor and version,
- the file name and SHA-256 of the installer,
- **the arguments of the installer, as given**. If an argument holds a licence key or a password, the notes hold it too,
- each prerequisite, with what a target machine needs,
- the certificate that signed the package.
