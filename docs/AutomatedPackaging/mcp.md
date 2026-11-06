# AI agents (MCP)

MCP clients, such as Claude Desktop and Google Antigravity, can use Automated Packaging on the host. An agent can read the state of the host, check and start jobs, and build workers.

## How it works

The service **AppVentiX Automated Packaging** starts with Windows. It runs as `NT SERVICE\AutomatedPackaging`, which the installer puts in the local Administrators group. So the service can use Hyper-V when nobody is signed in.

An MCP client does not connect to the service directly. It starts the relay, `AutomatedPackaging.Mcp.exe`, in the installation folder. The relay connects to the service on this computer only. The relay does not need administrator rights.

## Before you start

- **A licence that includes MCP.** A Basic licence includes it. The starter allowance and a community licence do not. Without it, `product_status` gives `AP-LC-007`. The service checks the licence when a client connects and again at each tool call.
- **Your account in the local group `AppVentiX Packaging Operators`.** The installer creates the group, empty. Only its members can use the service. Membership of Administrators alone is not sufficient.

## Set it up

1. Add your account to **AppVentiX Packaging Operators**. Use **Computer Management** > **Local Users and Groups** > **Groups**, or this command from an elevated prompt:

    ```
    net localgroup "AppVentiX Packaging Operators" <your account> /add
    ```

2. Sign out of Windows, then sign in again. Windows reads group membership at sign-in. On Remote Desktop, use **Start** > your account > **Sign out**. A disconnected session keeps the old groups.
3. In the application, go to **Settings > AI agents (MCP)**. **Connect an AI agent** shows the path of the relay, and checks your account and the licence.
4. Click **Copy client setting**. This copies the `mcpServers` entry, with the path of the relay.
5. Paste the entry into the configuration file of your MCP client. The relay takes no arguments.

**Copy client setting** puts the full entry on the clipboard, with the relay path of this host. In a new file, the entry is the full content. If the file already has other servers, add only the `"automated-packaging"` entry inside its `"mcpServers"`.

### Claude Desktop

The file is `%APPDATA%\Claude\claude_desktop_config.json`. To open it, click **Settings** > **Developer** > **Edit Config** in Claude Desktop. Claude Desktop makes the file if it is not there.

Add the entry, then quit Claude Desktop and start it again:

```json
{
  "mcpServers": {
    "automated-packaging": {
      "command": "C:\\Program Files\\Automated Packaging\\AutomatedPackaging.Mcp.exe"
    }
  }
}
```

### Google Antigravity

1. Install Antigravity from Google, and sign in with your Google account.
2. Open the file `%USERPROFILE%\.gemini\config\mcp_config.json`. In the agent panel, click **…** > **MCP Servers** > **Manage MCP Servers** > **View raw config**. Or open the file directly.
3. If the file is not there, make it, with the `mcpServers` entry as its full content.
4. Add the entry, then save the file.

Antigravity asks you before it uses a tool of a new server. Do not add a permission rule that allows each tool of this server. With it, Antigravity uses each tool without a question, also the tools that build packages.

The AI key is for your MCP client. Automated Packaging does not keep or read AI keys.

## What an agent may do

Go to **Settings > AI agents (MCP)**, under **What an agent may do**. The service reads these settings at each tool call. It reads them again just before it signs or starts the job. If they changed during the call, for example to **Off** while your client asks you, the tool stops. Nothing is signed and no job starts.

| Signing setting | What happens |
|---|---|
| **Off: agents use a test certificate** | The default. The job signs with a test certificate, not with your certificate. The product does not export the package (`AP-SG-014`). See [The test certificate](#the-test-certificate) |
| **Ask each time** | Your MCP client asks you before each signature. If you do not agree, or the client cannot ask, the tool stops with `AP-SG-013` |
| **Allowed, with a warning** | The job signs. The answer of the tool gives the publisher of the package |

1. Under **Certificates that agents can use**, tick the certificates. An agent can use only those, with each setting.
2. Tick **Agents can remove workers and forget images** only if you want that. It is off by default. While it is off, `worker_remove` and `image_forget` stop with `AP-HV-012`.
3. Click **Save**.

### The test certificate

With **Off**, the agent names one of the certificates that you ticked. The service makes a self-signed test certificate with the same subject. So the package has your publisher, and Windows sees the same application. The key of the test certificate cannot be exported. It stays in the certificate store of the computer. Later jobs for the same subject use the same test certificate.

The job runs its smoke test with the test certificate, as each job does. Then:

- The package stays in the output folder. The product does not export it. The job shows **Built, not exported** with `AP-SG-014`.
- To sign the package with your certificate, use **Sign for release**. See [Sign a package for release](jobs.md#sign-a-package-for-release).
- An agent cannot sign for release. `retry_signing` signs a test-signed job again with its test certificate.

## The tools

These tools read and change nothing:

| Tool | What it gives |
|---|---|
| `product_status` | The product version and the licence state, and if the licence allows MCP |
| `list_machines` | The workers for a target, free or busy, and the recommended one |
| `list_certificates` | The certificates and Azure profiles that can sign, with their IDs |
| `list_jobs` | The newest jobs, at most 100, with their state |
| `job_status` | The state of one job, its package, and its error code |
| `job_log` | The end of the log of one job, at most 32,768 characters |
| `engine_evidence` | What the built-in engine kept for one job: the number of files and registry values, and what the noise rules removed by rule. Also what the package writer left out and why, and the step that failed |
| `explain_code` | The title, cause and remedy of an `AP-` error code |
| `inspect_installer` | What the Build screen fills in for an installer |
| `check_job` | What stops a job, or what it builds. It does not start the job |

These tools start or change work:

| Tool | What it does |
|---|---|
| `convert` | Starts a job and gives its ID. Use `job_status` to follow it. The job continues when the client closes. Set `internal` to true for your own application: then its name stays out of the improvement data. Set `engine` to `builtin` for the built-in engine (experimental). Without `engine`, the job uses Microsoft's MSIX Packaging Tool. The signing rules are the same for both engines |
| `cancel_job` | Stops a running job, also a job that a person started. The service puts the worker back |
| `retry_signing` | Signs the package of a job again, when its signing failed |
| `resign_package` | Signs an `.msix` or `.appx` file with a certificate selected for agents, as **Re-sign a package** does. Refused while agent signing is **Off** (`AP-SG-012`). With **Ask**, your client asks you first. The question names the certificate, the package's capabilities and extensions, who signed it before, and its SHA-256 |
| `export_job` | Copies the package of a job to the export location again |
| `collect_support_bundle` | Writes the support information, as **Settings > Diagnostics** does. Give the IDs of at most 10 jobs, or none for the newest failed job. The answer gives the path, the files, what is left out and what redaction replaced. The agent tells you what is in the file before anything is sent. The product does not send it. Only an administrator of the host can open the data folder |
| `worker_build` | Builds a worker and its image. It gives an operation ID at once |
| `worker_update` | Updates a worker. It gives an operation ID at once |
| `worker_status` | The steps and the result of a worker operation |
| `worker_remove` | Removes a worker and its disks, if the setting allows it |
| `image_forget` | Forgets an image that no worker uses, if the setting allows it |

Each tool tells the client if it only reads, and if it can stop or remove work. Some clients use this to approve a tool with no question. `cancel_job`, `worker_update`, `worker_remove` and `image_forget` are marked as tools that can stop or remove work, so such a client asks you first.

Agents run one worker operation at a time. The service also gives the list of error codes as the resource `automatedpackaging://error-codes`.

## Limits

- `inspect_installer`, `check_job`, `convert` and `resign_package` take the full path of a file on a local disk of the host, for example `C:\Installers\setup.msi`. The service does not open a network path such as `\\server\share`, a network drive, or a path through a folder that is a symbolic link. Copy the file to a local folder first.
- The service reads the file only if your account can read it. The refusal is the same in three cases. The file is not there, your account cannot read it, or it is not on a local disk. `<workingDir>\Logs\service-<date>.log` gives the reason. A link to another file is refused.
- The file must fit in the free space on the drive of the working directory.
- Through MCP, a job takes only the installer. It does not take the folder of the installer or MSI transforms. Use the window or the command line for those.
- Text from a worker, an installer or a package is between `<<<WORKER-DATA` and `WORKER-DATA>>>`. This includes the name, version and publisher of a job, problems, warnings, logs and failure details. Tell your MCP client not to follow instructions in it.

- Four MCP clients can use the service at one time. When a fifth connects, the service closes the connection of a client that has been idle for 5 minutes. If no client is idle, it closes the new connection.
- The service sends a ping every minute to a client that uses an MCP revision before 2026-07-28. It closes the connection of a client that does not answer in 30 seconds.
- A message from a client can be 1 MB at most, and a text argument 8192 characters at most.

The service writes each tool call to `<workingDir>\Logs\mcp-audit-<date>.log`, in two lines. The first line is written before the tool runs, with the result `called`. The second line gives the result: `done`, `refused` or `failed`. Each line has the time, the account, the tool and its arguments, cut to 260 characters. The service deletes a day's file after 90 days.

## Check the connection

1. In the application, go to **Settings > AI agents (MCP)**. **Connect an AI agent** must say "Your account is in AppVentiX Packaging Operators." If it says "Your account is not in AppVentiX Packaging Operators…", do steps 1 and 2 of [Set it up](#set-it-up) again.
2. Start your MCP client again. Ask the agent to call the tool `product_status`. It gives the state of the host.

For prompts to start with, see [Example prompts](mcp-prompts.md).

## When it does not connect

The relay writes its message to the log of the client, not to the conversation. Claude Desktop writes it to `%APPDATA%\Claude\logs\mcp-server-automated-packaging.log`.

| Message | What to do |
|---|---|
| The Automated Packaging host service does not answer. | In **Services**, make sure that **AppVentiX Automated Packaging** runs. If it stops, read `<workingDir>\Logs\service-<date>.log` |
| The host service closed the connection. | Four MCP clients can use the service at one time. Close a client that you do not use. `<workingDir>\Logs\service-<date>.log` gives the reason |
| Windows refused the connection to the host service. | Add your account to **AppVentiX Packaging Operators**. Then sign out and sign in again |
| Another program made the pipe, not the host service. | Stop. Another program uses the name of the channel of the service. Tell an administrator of the host |
| `AP-LC-007` from `product_status` | Install a Basic licence under **Settings > Licence** |

## Security

- The channel is a named pipe on this computer. Windows refuses connections from other computers.
- Only members of **AppVentiX Packaging Operators** can open it. Remove an account from the group to stop its access. This applies at its next sign-in.
- When you remove the product, the service leaves Administrators. The group and its members stay.
