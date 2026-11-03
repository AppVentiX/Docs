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
| **Diagnostics** | **Write diagnostics…** |
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

**Write diagnostics…** writes one zip file to `<dataFolder>\diagnostics\`. It holds:

- the product version, the operating system, the computer name and the licence summary,
- the 20 newest jobs and their logs,
- the images, workers, claims and holds of this host,
- the logs of the last 7 days.

It does not hold worker passwords, the licence file, installers or packages. Read `manifest.txt` before you send the bundle outside your organization: it holds the computer name.

Not in the bundle: the `Collected files` folder of a job, and the host preparation records. Attach them yourself when necessary.

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
