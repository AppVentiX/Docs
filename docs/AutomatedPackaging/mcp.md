# AI agents (MCP)

MCP clients, such as Claude Desktop and Google Antigravity, can use Automated Packaging on the host. An agent can read the state of the host, check and start jobs, and build workers.

## How it works

The service **AppVentiX Automated Packaging** starts with Windows. It runs as `NT SERVICE\AutomatedPackaging`, which the installer puts in the local Administrators group. So the service can use Hyper-V when nobody is signed in.

An MCP client does not connect to the service directly. It starts the relay, `AutomatedPackaging.Mcp.exe`, in the installation folder. The relay connects to the service on this computer only. The relay does not need administrator rights.

## Before you start

- **A licence that includes MCP.** A Basic licence includes it. The starter allowance and a community licence do not. Without it, `product_status` gives `AP-LC-007`.
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

Go to **Settings > AI agents (MCP)**, under **What an agent may do**. The service reads these settings at each tool call.

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
| `explain_code` | The title, cause and remedy of an `AP-` error code |
| `inspect_installer` | What the Build screen fills in for an installer |
| `check_job` | What stops a job, or what it builds. It does not start the job |

These tools start or change work:

| Tool | What it does |
|---|---|
| `convert` | Starts a job and gives its ID. Use `job_status` to follow it. The job continues when the client closes |
| `cancel_job` | Stops a running job. The service puts the worker back |
| `retry_signing` | Signs the package of a job again, when its signing failed |
| `export_job` | Copies the package of a job to the export location again |
| `worker_build` | Builds a worker and its image. It gives an operation ID at once |
| `worker_update` | Updates a worker. It gives an operation ID at once |
| `worker_status` | The steps and the result of a worker operation |
| `worker_remove` | Removes a worker and its disks, if the setting allows it |
| `image_forget` | Forgets an image that no worker uses, if the setting allows it |

Agents run one worker operation at a time. The service also gives the list of error codes as the resource `automatedpackaging://error-codes`.

## Limits

- `inspect_installer` and `check_job` take the full path of an installer on the host. The service reads the file only if your account can read it. A link is refused.
- Through MCP, a job takes only the installer. It does not take the folder of the installer or MSI transforms. Use the window or the command line for those.
- Text from a worker is between `<<<WORKER-DATA` and `WORKER-DATA>>>`. The installer in the worker can write that text. Tell your MCP client not to follow instructions in it.

The service writes each tool call to `<workingDir>\Logs\mcp-audit-<date>.log`: the time, the account, the tool, its arguments and the result.

## Check the connection

1. In the application, go to **Settings > AI agents (MCP)**. **Connect an AI agent** must say "Your account is in AppVentiX Packaging Operators." If it says "Your account is not in AppVentiX Packaging Operators…", do steps 1 and 2 of [Set it up](#set-it-up) again.
2. Start your MCP client again. Ask the agent to call the tool `product_status`. It gives the state of the host.

## When it does not connect

The relay writes its message to the log of the client, not to the conversation. Claude Desktop writes it to `%APPDATA%\Claude\logs\mcp-server-automated-packaging.log`.

| Message | What to do |
|---|---|
| The Automated Packaging host service does not answer. | In **Services**, make sure that **AppVentiX Automated Packaging** runs. If it stops, read `<workingDir>\Logs\service-<date>.log` |
| Windows refused the connection to the host service. | Add your account to **AppVentiX Packaging Operators**. Then sign out and sign in again |
| Another program made the pipe, not the host service. | Stop. Another program uses the name of the channel of the service. Tell an administrator of the host |
| `AP-LC-007` from `product_status` | Install a Basic licence under **Settings > Licence** |

## Security

- The channel is a named pipe on this computer. Windows refuses connections from other computers.
- Only members of **AppVentiX Packaging Operators** can open it. Remove an account from the group to stop its access. This applies at its next sign-in.
- When you remove the product, the service leaves Administrators. The group and its members stay.
