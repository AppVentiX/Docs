# Settings

The **Settings** screen has these sections. Settings are set in the application window. The command line uses them, and cannot change them.

| Section | What it holds |
|---|---|
| **Licence** | The licence state and the starter allowance. **Install licence…** installs a licence file |
| **Folders** | The finished packages folder, the working directory, the data folder, and **Housekeeping** |
| **This host** | The host checks, **Prepare this host…**, Hyper-V, **Packaging tools** and **Package Support Framework** |
| **Signing** | Signing certificates, a test certificate, and Azure Artifact Signing profiles. See [Signing](signing.md) |
| **AI agents (MCP)** | How to connect an MCP client, and what an agent may do. See [AI agents (MCP)](mcp.md) |
| **Appearance** | **Follow Windows**, **Light** or **Dark** |
| **Export** | The export location. See [Export packages](export.md) |
| **Diagnostics** | **Collect support information**, and **Improvement data** |
| **Advanced** | The managed name prefix, and the configuration bundle |

## This host

The application checks the host when it starts, when host preparation closes, and when you click **Check this host**. **Prepare this host…** starts host preparation. See [Prepare the host](prepare-host.md).

### Package Support Framework

Some applications write into their own installation folder. A package does not allow this. The Package Support Framework (PSF) puts a launcher in front of the programs of the application. It redirects such a write to a copy for each user.

The product uses Tim Mangan's release of PSF, pinned at `v2026.07.01`. It does not ship PSF. Most jobs do not need it.

1. On the card **Package Support Framework**, click **Get PSF**. The product downloads the release from GitHub, and the Visual C++ runtime from Microsoft.
2. In the **Advanced** settings of a job, turn on **Package Support Framework**.

The product keeps the files only when each PSF file is signed by TMurgent Technologies LLP, and each runtime file by Microsoft. Before each job with PSF, it checks the files again. A file that fails stops the job with `AP-PK-011`.

When a newer PSF release is available, a notice shows above every screen. Jobs use your current release until you click **Adopt**.

## Appearance

The application follows the app mode of Windows by default. **Light** or **Dark** overrides it. The choice applies at once, and only for your account.

## Diagnostics

**Collect support information** writes one zip file for AppVentiX support to `<dataFolder>\diagnostics\`.

1. Tick the jobs whose logs go in, at most 10. The newest failed job is ticked when you open the section.
2. Click **Collect support information**.

The screen gives the path of the file, what is in it and what redaction replaced. The file holds:

- the product version, the operating system, the data folder and the licence state,
- the checks of **This host**,
- the 20 newest jobs, and the logs of the jobs that you ticked,
- the images, workers, claims and holds of this host,
- the logs of the last 7 days, also the MCP audit log.

Before a file goes into the zip file, redaction replaces these values with a numbered name, for example `<host-1>`:

- the names of this host, its domain and its users, and the name of the licence holder,
- certificates, certificate subjects, thumbprints, GUIDs such as tenant IDs,
- e-mail addresses, domain names, IP addresses, server and share names,
- folder names outside the data folder, the working directory, Windows, Program Files and ProgramData (file names stay),
- registry values, and the values of MSI properties and installer switches (their names stay).

Redaction cannot find a name that it does not know, for example the name of another computer in a log line. Read the file before you send it. The product does not send the file.

It does not hold worker passwords, the licence file, installers or packages. Not in the file: the `Collected files` folder of a job, and the host preparation records. Attach them yourself when necessary. They are not redacted.

An AI agent can write the same file with the MCP tool `collect_support_bundle`. See [MCP](mcp.md).

### Improvement data

**Improvement data** helps AppVentiX make the product better. It is off until you tick **Collect improvement data on this host**. While it is on, the host keeps one record for each job, each worker build and each worker update. The support information does not contain these records.

**Collected:**

- For a job: how it ended, its error code, its duration and the exit code of the installer.
- For a job: MSI or EXE, the install mode, the target, and the number of MSI properties, transforms and prerequisites.
- For a job: the Package Support Framework and the export on or off, and the Windows build and edition.
- For a job: the versions of the packaging tool, the agent and the application, and the name of the application.
- For a worker build or update: how it ended, the step that failed, its error code and the duration of each step.
- For AI agents: how many times they called each MCP tool, and the error codes of the refusals. Only the days since you turned the setting on.

**Never collected:**

- File contents, registry values, user, host and domain names, certificates and publishers, and tenant IDs.
- Paths, installer arguments, MSI property values, worker and image names, job IDs and error text.
- The time of day. A record has the date only.
- The account of an AI agent's client, its arguments and the text of the answers.

Mark your own application as **Internal** when you convert it. Then its jobs have no name in the data. A name with a path, a domain name, or the name of this host or one of its users is also left out.

1. Click **Show**. The screen shows the full file, exactly as **Save** writes it.
2. Click **Save**. The file goes to `<dataFolder>\diagnostics\automatedpackaging-improvement-<date>-<time>.json`.
3. Read the file before you send it. The product does not send the file.

When you turn the setting off, the product removes the records.

## Advanced

**The managed name prefix** is the prefix that each worker name must have, `PKGMGR-` by default. The product creates, changes and removes only machines with this prefix. Change it only if it is the same as names that you use. Click **Save prefix**, then start the application again. Earlier prefixes stay managed.

**The configuration bundle** holds the configuration of this host, with its package identities. A package identity is how Windows knows that a new package updates an installed application. **Export configuration…** writes it, and **Import configuration…** reads it. The bundle holds no passwords, no private keys and no certificates.

## Worker limits

The file `agent-channel.json` in the data folder holds four limits on what a worker can do during a job. Most hosts do not need to change them. Edit the file, then start the application and the service again.

| Setting | Default | What it does |
|---|---|---|
| `MaxJobUploadMegabytes` | `8192` | The most that one job can upload from its worker. One file can be half of it, so the package limit is 4 GB. Above it, the job fails with `AP-NW-007` |
| `MaxJobLogMegabytes` | `64` | The most log text that one job can write |
| `AgentHeartbeatSeconds` | `15` | How often the agent reports that it is there |
| `MissedHeartbeatsAllowed` | `12` | How many reports can be missing before the worker is lost. The default is three minutes |

Before you raise the upload limit, look at the exclusion set of the image. The largest packages measured so far are about 2 GB.
