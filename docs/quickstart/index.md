# Quickstart

Get AppVentiX up and running in about 10 minutes by following the steps below. This guide covers everything from setting up the Configuration Store to installing the agent and verifying your deployment - whether you are targeting physical machines, persistent VDI, or non-persistent SBC/VDI environments.

---

## Deployment Steps

Follow these steps in order to prepare a client machine for AppVentiX.

| Step | Description |
|------|-------------|
| [**1. AppVentiX Central View Installation**](#step-1-download-and-install-appventix-central-view) | The Central View console is the place where you can configure your user settings as well as manage the packages |
| [**2. The (initial) Configuration Store setup**](#step-2-the-initial-configuration-store-setup) | This Configuration Store is the heart of an AppVentiX deployment where the configuration files are located and where the agents depends on. |
| [**3. Install AppVentiX Agent**](#step-3-install-the-appventix-agent) | Install the AppVentiX Agent MSI from the Configuration Store, pointing it to the Configuration Store during installation. |
| [**4. Verify the agent**](#step-4-verify-the-agent) | Check the setup if everything is communicating as it should. |

---

## Step 1: Download and install AppVentiX Central View

AppVentiX Central View is a unified GUI management console for User Settings and application delivery. It enables administrators to configure Drivemaps, GPOs, and other user settings, while also deploying, configuring, and monitoring App-V, MSIX, and AppAttach packages across persistent, VDI, and RDS environments - all from a single location.

[AppVentiX Central View Installation](appventix-central-view-installation.md)

---

## Step 2: The (initial) Configuration Store setup

The Configuration Store is the main location for the configuration of AppVentiX. Here the Agent configuration and communication is arranged as well as the configuration for user settings and packages. It's important to configure the share correctly to allow AppVentiX to work as expected.

[Configuration Store setup](config-share.md)

---

## Step 3: Install the AppVentiX Agent

AppVentiX uses a lightweight agent installed on each target machine. The agent runs on virtual machines (Microsoft RDS, AVD, Windows 365, Citrix PVS/MCS, Omnissa Horizon, Parallels Desktop, etc.) as well as physical desktops and laptops. Installation is straightforward - the AppVentiX Central View console provides a ready-to-use silent install command that you can copy and paste directly.

[Install the AppVentiX Agent](agent-installation.md) on the machine. The agent connects to the Configuration Store and handles application delivery.

---

## Step 4: Verify the agent

With this final step you can validate if the Agent is communicating with the Configuration Store.

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

- Go to the **Manage Content** page in Central View, check the content on your configured content share, and [create publishing tasks (assign packages to users or globally to machines).](../admin-guide/deploy-update-remove.md) A great feature of AppVentiX is that unmanaged packages (when you remove a publishing task or remove a user from an AD group assigned to a publishing task) will be unpublished/removed automatically for users.
- Explore all [Agent Settings](../admin-guide/agent-settings.md) and check the settings to meet your deployment goals.
- Explore the Central View console and Agent GUI and check out all the options and features.

