# Internet for a worker

A worker reaches the host and nothing else. Some installers download their files while they run: a web installer, a stub, or an installer that gets a runtime. For these, you can give one job a list of internet hosts. The worker then reaches those hosts through a proxy on the host, and only while the installer runs.

The proxy is **off** until you turn it on. While it is off, a job with internet hosts is refused with `AP-NW-008`.

## How it works

- The proxy runs in the service `AutomatedPackaging`. It listens on the address of the host on the internal switch, and only while a job uses it.
- The job names the hosts. The proxy lets the worker of that job, and no other worker, reach those hosts. It refuses every other request.
- The host finds the address of each name itself. It never connects to the host itself, to loopback or link-local addresses, or to the internal switch. It connects to an address on your network only for an entry that you mark `lan:`.
- The proxy does not read the traffic. An HTTPS connection goes through as a tunnel. Nothing is kept.
- The job log shows each request: the host, the address, the bytes in each direction, and if the proxy refused it, the reason.
- Access starts before the capture and ends when the capture ends. A first start that you capture has internet. The smoke test does not.

## Turn the proxy on

=== "GUI"

    1. Open **Settings**, then **Advanced**.
    2. On the **Worker internet** card, tick **Let jobs reach their internet hosts through this host**.
    3. Optional: change the **Port** (default 3128), the **Limit per job** (default 2048 MB and 30 minutes), or set an **Upstream proxy**.
    4. Click **Save worker internet**.
    5. Run host preparation. The check **Host proxy reachable** adds the inbound firewall rule *Automated Packaging host proxy*. The rule lets only the service receive the port, on the internal address, from the internal subnet.

=== "CLI"

    The setting is on the Worker internet card of the application. After you turn it on, run host preparation from an elevated prompt:

    ```
    AutomatedPackaging.PrepareHost.exe --apply
    ```

    The check `product.proxy.allow` adds the firewall rule for the port.

While the proxy is off, host preparation adds no rule and the check passes.

## Give a job internet hosts

Write one entry on each line:

| Entry | What the worker can reach |
|---|---|
| `download.example.com` | That name, on port 443 (HTTPS) and port 80 (HTTP) |
| `*.example.com` | Each name under example.com, not example.com itself |
| `files.example.com:8443` | That name on port 8443 only |
| `lan:fs01` or `lan:files.corp.example` | That name, also when it is an address on your network. Only an exact name, never a wildcard |

The proxy refuses these entries: an address, a URL or a path, `*` alone, a wildcard over one part (`*.com`), and `lan:` before a wildcard. A name of one part needs `lan:`. A job with such an entry is refused with `AP-IM-031`, and the message names each entry.

=== "GUI"

    On the **Build** screen, click **Advanced…**. Write the entries in **Internet hosts**, one on each line.

=== "CLI"

    Give `--internet-host` one time for each entry:

    ```
    AutomatedPackaging.Cli convert D:\Installers\setup.exe --internet-host download.example.com --internet-host "*.cdn.example.com"
    ```

**A recipe** can hold the list in `internetHosts`. See [Recipes](recipes.md). A list in the job wins over the list in the recipe.

**An AI agent (MCP)** can give the hosts in `internetHosts` of `convert` and `check_job`, only if you allow it under **Settings > AI agents (MCP) > Agents can give a job internet hosts**. This is off by default. It also applies to a recipe that holds internet hosts.

The worker must have its own address on the internal switch. A worker that has none, or that shares one with another worker, is refused with `AP-NW-009`. Update its image on the **Workers** screen to give it its own address.

### HTTPS needs the revocation hosts of the certificate

Windows checks that the certificate of the server is not revoked, and asks the certificate authority for it. If these hosts are not on the list, the download stops and the installer fails. The job log shows them as refused requests:

```text
proxy: GET x1.c.lencr.org:80 refused: not on the job's list of internet hosts.
proxy: GET ctldl.windowsupdate.com:80 refused: not on the job's list of internet hosts.
```

Add the hosts that the log names, for example `*.c.lencr.org` and `ctldl.windowsupdate.com`, and start the job again.

## What the job log shows

```text
proxy: Internet for this job through the host proxy at 172.31.7.1:3128, for 3 host(s): www.7-zip.org, *.c.lencr.org, ctldl.windowsupdate.com. At most 2048 MB and 30 minutes; every request is in this log.
proxy: GET x1.c.lencr.org:80 allowed to 23.193.237.116: 0 bytes up, 1120 bytes down, 0.0 s.
proxy: CONNECT github.com:443 refused: not on the job's list of internet hosts.
proxy: CONNECT www.7-zip.org:443 allowed to 89.167.91.206: 768 bytes up, 607658 bytes down, 1.2 s.
proxy: The host proxy carried 6 request(s) and refused 4: 768 bytes up, 719179 bytes down.
```

Windows sends requests of its own too. They show as refused lines and do not stop the job. One refused request for `proxy-settings-check.automatedpackaging.invalid` is the job's own: see below.

## Limits

- The volume and the time on the **Worker internet** card apply to each job. When a job reaches one, the proxy closes its connections and refuses its later requests. The job continues. An installer that needed more fails in its own way.
- At most 64 connections of one job at the same time.
- A request head larger than 32 KB, or one that does not arrive in 15 seconds, is refused.

## What the worker gets, and what the package does not

Before the capture, the job sets the proxy for the whole worker: the Windows (WinINet) proxy settings, the same for all users, and the WinHTTP proxy. The host address and names without a dot bypass the proxy. The worker goes back to its checkpoint after the job, so the settings go with it.

The job sets them before the capture, so the package does not hold them. Windows writes its own copy of the settings the first time a program uses them, so the job makes one request itself before the capture. The capture also leaves out the key where Windows keeps that copy (rules `PR-002` and `PR-003` in `exclusions.json`). Last, the job reads the finished package. If it holds these settings, the job fails with `AP-PK-020` and the package is not signed.

**An installer that does not use the Windows proxy settings cannot use the host proxy.** For example, a downloader that reads only the `HTTP_PROXY` environment variable, or one that connects to an address in its code. The job log then shows no request from it, and the installer fails in its own way. Use the full (offline) installer.

## An upstream proxy

If the host reaches the internet only through a proxy, write it in **Upstream proxy** as `host:port`. The host proxy then sends each allowed request to that proxy. The list of the job still applies. A name that the host finds at an address on your network is still refused, unless the entry is marked `lan:`. A `lan:` entry goes directly, not to the upstream proxy.

**The remaining risk:** the upstream proxy finds the address of each name again. If your company's DNS sends a listed public name to an inside address, the upstream proxy can connect there. Put only names that you trust in the lists.

The upstream proxy cannot ask for a user name and a password.

## Error codes

| Code | What it means |
|---|---|
| `AP-NW-008` | The job names internet hosts, and the proxy is off or could not listen |
| `AP-NW-009` | The worker has no address of its own on the internal switch |
| `AP-IM-031` | An internet host of the job or its recipe is not valid |
| `AP-PK-020` | The package holds the proxy settings of the worker |

See [Error codes](error-codes.md).
