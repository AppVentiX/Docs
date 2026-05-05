# Quickstart

This guide walks you through preparing:

- The infrastructure side, initial config share configuration
- Windows machine for AppVentiX client deployment, the steps apply to physical desktops and laptops, as well as persistent and non-persistent VDI/SBC environments.

---

## Deployment Steps

Follow these steps in order to prepare a client machine for AppVentiX.

| Step | Description |
|------|-------------|
| [**1. The (initial) config share setup**](#step-1-the-initial-config-share-setup) | This Config share is the heart of an AppVentiX deployment where the configuration files are located and where the agents depends on. |
| [**2. Base OS installation**](#step-2-base-os-installation) | Install Windows (physical, VDI persistent, or non-persistent master image). Apply updates and install required applications. |
| [**3. Install AppVentiX Agent**](#step-3-install-the-appventix-agent) | Install the AppVentiX Agent MSI from the config share, pointing it to the config share during installation. |
| [**4. Verify the agent**](#step-4-verify-the-agent) | Check the setup if everything is communicating as it should. |

> **Note:** For non-persistent VDI and SBC environments, steps 2 and 3 are performed on the master image before sealing it.

---

## Step 1: The (initial) config share setup

The config share is the main location for the configuration of AppVentiX. Here the Agent configuration and communication is arranged as well as the configuration for packages and user settings. It's important co configure the share correctly to allow AppVentiX to work as expected.

[Config share setup](config-share.md)

---

## Step 2: Base OS Installation

Install a supported version of Windows on the target machine or master image. This can be:

- A physical desktop or laptop
- A persistent VDI or SBC session host
- A non-persistent VDI or SBC master image

After the base OS is in place, apply Windows updates and install any applications required in the environment. This is outside the scope of AppVentiX and is handled by the administrator or image engineer.

---

## Step 3: Install the AppVentiX Agent

AppVentiX works with a lightweight agent running on the same machine as the App-V and MSIX (app attach) client (part of Windows). This can either be a virtual machine (Microsoft RDS\AVD Hostpool\Windows365, Citrix VDI (PVS\MCS), VMware Horizon, etc) or physical machine (PC or Laptop). The agent can be pushed from the Central View console or easily installed silently, the silent install parameter is already populated in the Central View console and you only have to copy\paste the command from there.

[Install the AppVentiX Agent](agent-installation.md) on the machine. The agent connects to the config share and handles application delivery.

---

## Step 4: Verify the agent

With this final step you can validate if the Agent is communicating with the Config share.

[Verify the Agent](verify-agent.md)

---

## Optional: Optimize the Workspace

[Run the workspace optimization](optimization-script.md) to clean up the OS image. This optional step removes unnecessary built-in apps, disables unused services, and applies performance and reliability settings suited to managed environments.

The optimization is driven by a customizable XML template. You can use the default template or configure your own via the [Workspace Optimizer web tool](https://workspaceoptimizer.appventix.com).

> **Note:** For physical desktops and laptops, optimization is typically run once during initial setup and again after significant application changes. For non-persistent VDI/SBC, it is run on the master image before sealing.

---

## Next Steps

- Go to the **Manage Content** page in Central View, check the content on your configured content share, and create publishing tasks (assign packages to users or globally to machines). A great feature of AppVentiX is that unmanaged packages (when you remove a publishing task or remove a user from an AD group assigned to a publishing task) will be unpublished/removed automatically for users.
- Explore all [Agent Settings](../admin-guide/agent-settings.md) and check the settings to meet your deployment goals.
- Explore the Central View console and Agent GUI and check out all the options and features.

