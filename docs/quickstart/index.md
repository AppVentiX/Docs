# Quickstart

Get AppVentiX up and running in about 10 minutes by following the steps below.

---

## Deployment Steps

Follow the below steps in order to configure AppVentiX smoothly.

| Step | Description |
|------|-------------|
| [**1. AppVentiX Central View Installation**](#step-1-download-and-install-appventix-central-view) | Install Central View used to manage packages and configure user settings. |
| [**2. Create Machine Group(s)**](#step-2-create-machine-groups) | Target a set of machines by AD OU, AD Group, or EntraID tenant to scope package delivery and agent settings. |
| [**3. Install AppVentiX Agent**](#step-3-install-the-appventix-agent) | Install the AppVentiX Agent MSI on each target machine, pointing it to the Configuration Store. |
| [**4. Verify the agent**](#step-4-verify-the-agent) | Confirm the agent is communicating correctly with the Configuration Store. |

---

## Step 1: Download and install AppVentiX Central View

AppVentiX Central View is an easy to use management console for Application Delivery and User Settings. It can run on any supported Windows OS, physical or virtual without the need for a backend infrastructure. It can be used by multiple admins simultaneous.


[Click here to start the AppVentiX Central View Installation](appventix-central-view-installation.md)

---
## Step 2: Create Machine group(s)

Machine Groups define the scope of your deployment and allow you to segment it by environment or machine type, such as Production, Test or by machine collection (AVD\Citrix), or Entra ID laptops.
A Machine Group is built dynamically from an OU or group in Active Directory, or from Entra ID machines. For each Machine Group, you can configure agent settings and content stores.

[Create (your first) Machine Group(s)](create-machine-groups.md)

---

## Step 3: Install the AppVentiX Agent

AppVentiX uses a lightweight agent to handle the application deployment and workspace settings. The agent can run on a virtual machine (Microsoft RDS, AVD, Windows 365, Citrix PVS/MCS, Omnissa Horizon, Parallels Desktop, etc.) as well as physical desktops and laptops (Entra ID joined is also supported). The agent has an advanced cache mechanism which keeps the configuration running even when the machine is offline and the configuration store is not accessible.

[Click here to view the installation steps for the AppVentiX Agent](agent-installation.md).

---

## Step 4: Verify the agent

Validate that the agent is communicating correctly with the Configuration Store.

[Verify the Agent](verify-agent.md)

---

## Optional: Base OS Preparation

Before deploying the AppVentiX Agent, ensure the target machine is running a supported version of Windows. This applies to:

- Physical desktops and laptops
- Persistent single or multi session machines
- Non-persistent single or multi session master images

Apply Windows updates and install any required applications before proceeding. OS preparation is outside the scope of AppVentiX and is handled by the administrator or image engineer.

---

## Optional: Optimize the Workspace

[Run the workspace optimization](optimization-script.md) to clean up the OS image. This optional step removes unnecessary built-in apps, disables unused services, and applies performance and reliability settings suited to managed environments.

The optimization is driven by a customizable XML template. You can use the default template or configure your own via the [Workspace Optimizer web tool](https://workspaceoptimizer.appventix.com).

> **Note:** For physical desktops and laptops, optimization is typically run once during initial setup and again after significant application changes. For non-persistent VDI/SBC, it is run on the master image before sealing.

---

## Next Steps

- Go to the **Manage Content** page in Central View and [create publishing tasks](../admin-guide/deploy-update-remove/index.md) to assign packages to users or machines. When a publishing task is removed or a user is removed from an assigned AD group, AppVentiX automatically unpublishes the package for that user.
- Explore all [Agent Settings](../admin-guide/agent-settings/index.md) and check the settings to meet your deployment goals.
- Explore the Central View console and Agent GUI and check out all the options and features.

