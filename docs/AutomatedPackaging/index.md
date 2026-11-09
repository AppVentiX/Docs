# AppVentiX Automated Packaging

!!! warning "Preview documentation"
    This section is for a limited group of testers. It describes check build 0.2.29. Check builds are for testing, not for production. Do not share this link outside the test group.

AppVentiX Automated Packaging converts an installer (MSI or EXE) into a signed MSIX package. It does the conversion in a Hyper-V worker that it builds and manages itself.

For each job, the product does these steps:

1. It puts a worker back to a clean baseline.
2. It installs your installer in the worker, and Microsoft's MSIX Packaging Tool records what the installer changes.
3. It signs the package on the host.
4. It installs the signed package on a clean worker and starts the application. This is the smoke test.
5. It puts the worker back to its baseline again.

You build the worker once, from Windows media that you supply. The product ships no Microsoft binaries.

## Three ways to use it

| | What it is | Where to read |
|---|---|---|
| **The application window** | Screens for jobs, images, prerequisites and settings | All pages in this section, on the **GUI** tabs |
| **The command line** | `AutomatedPackaging.Cli.exe`, for scripts and pipelines | The **CLI** tabs, and [Command line](command-line.md) |
| **MCP clients** | AI agents, such as Claude Desktop or Google Antigravity | [AI agents (MCP)](mcp.md) |

!!! tip "GUI and CLI tabs"
    Where you can do a task in the window and on the command line, the page shows both as tabs. Select **GUI** or **CLI** once. The other pages then open on the same tab.

The Automated Packaging service runs every job, from the window, the command line and MCP. In **Services** its name is **AppVentiX Automated Packaging**.

## The order of the work

The order is fixed. The first time, allow half a day. Most of that time is a Windows installation.

1. [Check the requirements](requirements.md) of the host, and collect the media that you supply.
2. [Install](install.md) the product.
3. [Prepare the host](prepare-host.md): Hyper-V, the network switch, firewall rules and folder access.
4. [Stage the media](stage-media.md): the Windows ISOs and the packaging tool.
5. [Build a worker image](build-image.md).
6. [Add a signing certificate](signing.md).
7. [Convert an installer](convert.md).

After that:

- [Jobs and packages](jobs.md): follow jobs, sign again, free disk space.
- [Export packages](export.md) to a share, for example for AppVentiX Central View.
- [Keep images current](maintain-images.md): update, rebuild and remove workers.
- [Prerequisites](prerequisites.md): runtimes that an application needs outside its package.
- [Recipes](recipes.md): what a job changes for one application, written once and applied each time.
- [Settings](settings.md), and [Troubleshooting](troubleshooting.md) when something stops.
- [Report findings with an AI](tester-kit.md) when you test a build.

## Licence

A build that enforces a licence runs on the **starter allowance** until you install a licence. The starter allowance is one image and five packages.

- The count stays. When you remove an image or a package, you do not get it back.
- An update or a rebuild of an image that you have is not a new image.
- After the allowance, a new build stops with `AP-LC-006`. All that you built before stays available.
- A community licence is free. The use from MCP clients needs a Basic licence.

**Settings > Licence** shows the state of the licence and the allowance. A check build made without a licence issuing key enforces no licence, and the Licence section says so.

## What is not supported yet

| Not supported | What you see |
|---|---|
| A restart in an interactive install with the packaging tool | The MSIX Packaging Tool cannot continue a capture after a restart. Select the option to restart later. The built-in engine (experimental) continues after a restart |
| A network mode other than host-only | The **Advanced** settings show host-only, and you cannot change it |
| MSIs that install a driver | The job is refused before it starts (`AP-AN-013`). A package cannot install a driver |
| Installers that need a real restart | Files replaced at the next boot, or `RunOnceEx` work, refuse the package (`AP-IN-013`) |
| Windows Server 2022 as a worker | Microsoft publishes no capture driver for build 20348 |
| Release builds signed for shipping | A check build is signed for checking, not for shipping. Windows SmartScreen can show an unknown publisher |
