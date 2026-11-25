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

Add the hosts that the log names, for example `*.c.lencr.org` and `ctldl.windowsupdate.com`, and start the job again. A refused request that looks like such a check says so in its line: "It looks like a certificate revocation check".

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

The capture of a job with internet hosts also leaves out what Windows keeps of the downloads:

| Rule | Leaves out |
|---|---|
| `PR-004` | `%USERPROFILE%\AppData\Local\Microsoft\Windows\INetCache`: the download cache, with a copy of each download |
| `PR-005` | `%USERPROFILE%\AppData\LocalLow\Microsoft\CryptnetUrlCache`: the certificate revocation data |
| `PR-006` | `HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\5.0\Cache`: the keys of the cache |

An application that puts its own files in these folders loses them from the package too. That is rare. The `ZoneMap` key stays in the package: it holds real settings for each site.

**An installer that does not use the Windows proxy settings cannot use the host proxy.** For example, a downloader that reads only the `HTTP_PROXY` environment variable, or one that connects to an address in its code. The job log then shows no request from it, and the installer fails in its own way. Use the full (offline) installer.

## Windows updates in an Update

When the proxy is on, an update of a worker also installs its Windows updates. This is step 4, **Install Windows updates**. It runs after step 3 and before step 7. A new build lists step 4 as skipped. See [Keep images current](maintain-images.md#update).

1. The step sets the services `DoSvc` (Delivery Optimization) and `wuauserv` (Windows Update) to start, and restarts the worker. The other update services and the update tasks stay off.
2. The service opens the proxy for this worker. The hosts are always `*.update.microsoft.com`, `*.windowsupdate.com`, `*.delivery.mp.microsoft.com` and, for the Edge update, `msedge.api.cdp.microsoft.com`. The limits are always 4096 MB and 120 minutes. The limits in Settings do not apply to an update.
3. Windows Update searches, downloads and installs every software update. Drivers are not installed.
4. The proxy closes. The step puts the proxy settings of the worker back as they were, and reads them back.
5. The step restarts the worker again, so that the install completes. The step line shows the Windows build before and after.
6. The step waits until Windows has finished the updates. Windows can restart the worker by itself after that restart. The step continues when TrustedInstaller has stopped, no restart is pending, and the worker has run for 3 minutes.

### The Edge update in the same step

After the Windows updates, step 4 updates Microsoft Edge and the WebView2 Runtime while the proxy is still open.

1. The step turns on the scheduled tasks of the Edge updater (`MicrosoftEdgeUpdateTask*`). It sets the services `edgeupdate` and `edgeupdatem` back to the defaults of Windows.
2. The step starts the task `MicrosoftEdgeUpdateTaskMachineUA`. The Edge updater runs as SYSTEM.
3. The step waits until no part of the update runs, for 20 minutes at most.
4. The step turns off the tasks again and sets both services to Manual. It reads them back.

The step line shows the versions of Edge and WebView2 before and after. If the Edge update fails, the line says so, and the update continues. If the step cannot turn off the tasks and services again, the update stops before the seal.

The Edge updater decides by itself when it checks for a new version. It can skip the check, and then the step line says that it did not reach its update service. An update of Edge through this step is not verified yet: on our test worker, the updater did not complete an update.

Step 9, **Harden the image**, then sets `DoSvc` and `wuauserv` to Disabled again, and reads both back at that step.

Step 12, **Seal the image**, sets both to Disabled again and reads them back before it shuts the worker down. The packaging tool can set `wuauserv` to start during step 11. If one is not Disabled at step 12, the image is not sealed. This applies to every build and every update.

Steps 9 and 12 do the same for the Edge updater: its tasks must be disabled and its two services set to Manual. There is no Edge policy on the worker, because a policy also stops an installer that brings Edge or the WebView2 Runtime.

- When the proxy is off, the step is skipped, and its line says why. The update continues without Windows updates.
- The update log shows each update, its result and each request of the proxy.
- If an update is not installed, the update stops with `AP-IM-037` before the seal. The worker keeps the image it had.
- If Windows has not finished the updates after 30 minutes, the update also stops with `AP-IM-037`.
- A cumulative update can be larger than 1 GB and take 30 minutes or more.
- The service opens the proxy only for a worker of this product that has its own address, and only while an update of that worker runs.
- The service opens the proxy one time for each update. It closes the proxy when the update no longer holds its worker. One failed read of the update's lease does not close the proxy: the service reads it again. When no read works for the time after which a lease is old, the service closes the proxy. The update then stops at once with `AP-NW-008` and the reason.

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
| `AP-IM-037` | An update did not install the Windows updates, so it stopped before the seal |

See [Error codes](error-codes.md).
