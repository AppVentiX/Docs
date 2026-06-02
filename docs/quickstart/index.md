# Quickstart

Get AppVentiX up and running in about 10 minutes by following the steps below. This guide covers everything from setting up the Configuration Store to installing the agent and verifying your deployment - whether you are targeting physical machines, persistent VDI, or non-persistent SBC/VDI environments.

---

## Deployment Steps

Follow these steps in order to prepare a client machine for AppVentiX.

| Step | Description |
|------|-------------|
| [**1. AppVentiX Central View Installation**](#step-1-download-and-install-appventix-central-view) | Install the GUI console used to configure user settings and manage packages. |
| [**2. Configuration Store setup**](#step-2-the-initial-configuration-store-setup) | Set up the central share that holds all configuration files and serves as the communication hub for agents. |
| [**3. Install AppVentiX Agent**](#step-3-install-the-appventix-agent) | Install the AppVentiX Agent MSI on each target machine, pointing it to the Configuration Store. |
| [**4. Verify the agent**](#step-4-verify-the-agent) | Confirm the agent is communicating correctly with the Configuration Store. |

---

## Step 1: Download and install AppVentiX Central View

AppVentiX Central View is a GUI management console for User Settings and application delivery. It enables administrators to configure Drivemaps, GPOs, and other user settings, while also deploying, configuring, and monitoring App-V, MSIX, and AppAttach packages across persistent, VDI, and RDS environments - all from a single location.

[AppVentiX Central View Installation](appventix-central-view-installation.md)

---

## Step 2: The (initial) Configuration Store setup

The Configuration Store is the main location of an AppVentiX deployment. It holds all configuration files for User Settings and packages, and handles agent communication. Configuring the share correctly is essential for AppVentiX to function as expected.

[Configuration Store setup](config-share.md)

---

## Step 3: Install the AppVentiX Agent

AppVentiX uses a lightweight agent installed on each target machine. The agent runs on virtual machines (Microsoft RDS, AVD, Windows 365, Citrix PVS/MCS, Omnissa Horizon, Parallels Desktop, etc.) as well as physical desktops and laptops. Installation is straightforward - the AppVentiX Central View console provides a ready-to-use silent install command that you can copy and paste directly.

[Install the AppVentiX Agent](agent-installation.md) on the machine. The agent connects to the Configuration Store and handles application delivery.

---

## Step 4: Verify the agent

Validate that the agent is communicating correctly with the Configuration Store.

[Verify the Agent](verify-agent.md)

---

## Optional: Base OS Preparation

Before deploying the AppVentiX Agent, ensure the target machine is running a supported version of Windows. This applies to:

- Physical desktops and laptops
- Persistent VDI or SBC session hosts
- Non-persistent VDI or SBC master images

Apply Windows updates and install any required applications before proceeding. OS preparation is outside the scope of AppVentiX and is handled by the administrator or image engineer.

---

## Optional: Optimize the Workspace

[Run the workspace optimization](optimization-script.md) to clean up the OS image. This optional step removes unnecessary built-in apps, disables unused services, and applies performance and reliability settings suited to managed environments.

The optimization is driven by a customizable XML template. You can use the default template or configure your own via the [Workspace Optimizer web tool](https://workspaceoptimizer.appventix.com).

> **Note:** For physical desktops and laptops, optimization is typically run once during initial setup and again after significant application changes. For non-persistent VDI/SBC, it is run on the master image before sealing.

---

## Next Steps

- Go to the **Manage Content** page in Central View and [create publishing tasks](../admin-guide/deploy-update-remove.md) to assign packages to users or machines. When a publishing task is removed or a user is removed from an assigned AD group, AppVentiX automatically unpublishes the package for that user.
- Explore all [Agent Settings](../admin-guide/agent-settings.md) and check the settings to meet your deployment goals.
- Explore the Central View console and Agent GUI and check out all the options and features.

