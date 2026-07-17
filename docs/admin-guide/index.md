# Administrator Guide

AppVentiX works with a lightweight agent running on the same machine as the App-V and MSIX (app attach) client (part of Windows). This can either be a virtual machine (Microsoft RDS/AVD Hostpool/Windows365, Citrix VDI (PVS/MCS), VMware Horizon, etc) or physical machine (PC or Laptop). The agent can be pushed from the Central View console or easily installed silently.

The Central View console can be installed on any machine and does not need any (SQL) back-end. AppVentiX only requires a file share or an Azure storage blob for the configuration. A wide range of file share types are supported: Windows file shares (direct or DFS), Azure file shares (domain integrated and stand-alone), Azure Storage Blob, Nutanix and NetApp file shares, and QUIC shares accessed over port 443.

---

## Architecture

| Topic | Description |
|-------|-------------|
| [Technical Architecture](technical-architecture.md) | System topology diagram and overview of all AppVentiX components |

---

## AppVentiX Central View

| Topic | Description |
|-------|-------------|
| [Quick Start](../quickstart/index.md) | Get up and running with AppVentiX in minutes |
| [Central View Console](central-view.md) | Machine Groups, Manage Machines, and console overview |
| [Supported Operating Systems](supported-os.md) | Supported OS versions for agent and Central View |
| [Agent Settings](agent-settings.md) | All agent settings explained per category |
| [Machine Groups](machine-groups.md) | Configure Machine Groups |
| [Manage Machines](manage-machines.md) | Adding, organizing, and managing machines in machine groups |
| [Workspace Analyzer](workspace-analyzer.md) | Analyze a user or group to verify the assigned items |
| [Azure Blob Storage Configuration](../admin-guide/azure-blob-storage.md) | Setup a Azure Blob Storage automatically or manually |
| [Upgrading AppVentiX](supported-os.md#upgrade-from-an-earlier-version-of-appventix) | Upgrading from earlier versions |
| [PowerShell Module](powershell-module.md) | The AppVentiX PowerShell module |

---

## AppVentiX Agent

| Topic | Description |
|-------|-------------|
| [Agent](agent.md) | What is the AppVentiX Agent |
| [Agent Service](agent-service.md) | The AppVentiX Agent Service, event log, and refresh cycle |
| [Agent GUI](agent-gui.md) | The AppVentiX Agent GUI and Refresh Shortcut |
| [Refresh shortcut](agent-refresh-shortcut.md) | Refresh settings in your session |

---

## Package Management

| Topic | Description |
|-------|-------------|
| [Manage Content and Publishing Tasks](manage-content.md) | content stores, publishing tasks, package options |
| [MSIX and MSIX App Attach](msix.md) | MSIX delivery, shared containers, app attach |
| [MSIX Certificate Management](msix-certificates.md) | Certificate deployment and management |
| [Application Overview](application-overview.md) | Package management, import from Microsoft Store |
| [Deploy, Update and Remove Applications](deploy-update-remove.md) | Approaches for managing application lifecycle |

---

## Security and Access Control

| Topic | Description |
|-------|-------------|
| [FSLogix App Masking](app-masking.md) | Managing FSLogix App Masking rules |
| [App Control (WDAC)](app-control.md) | Microsoft App Control for Business setup and best practices |
| [App Control Code Sign Certificate Creation](app-control-create-certificate.md) | Certificate creation for signing App Control policies and packages |
| [Audit Trail](audit-trail.md) | Configuration audit logging |

---

## User Settings

| Topic | Description |
|-------|-------------|
| [Configuring User Settings](user-settings-general.md) | Introduction and how to enable User Settings for a machine group |
| [User Settings Reference](user-settings-detailed.md) | Detailed configuration of each User Setting type |
| [User Settings Filters](user-settings-filters.md) | Create Fiters you can use for scoping User Settings |

---

## Integrations

| Topic | Description |
|-------|-------------|
| [Azure Virtual Desktop (AVD)](azure-virtual-desktop.md) | AVD Desktop and RemoteApp integration |
| [Azure AD / Entra ID](entra-id.md) | Entra ID machine groups and application registration |
| [Azure File Share](azure-file-share.md) | Setting up Azure file shares for AppVentiX |
| [QUIC Share (Port 443)](quic-share.md) | SMB over HTTPS for share access over port 443 |
| [SMB Share](smb-share.md) | Configuring an SMB share as the AppVentiX Configuration Store |
| [Azure Storage Account (Manual Setup)](azure-manual-sa-creation.md) | Manual Azure blob storage account setup and required permissions |
| [Custom App Registration](custom-app-registration.md) | Creating your own Entra ID app registration for AppVentiX |
| [Client Certificate](client-certificate.md) | Client certificate setup and rotation |

---

## Advanced Configuration

| Topic | Description |
|-------|-------------|
| [Share Permissions and Configuration](share-permissions.md) | Share and NTFS permission setup |
| [Central View Inventory and Advanced Settings](central-view-advanced.md) | Inventory storage, LDAPS, WinRM over SSL |
| [FSLogix and Roaming Profiles](fslogix-profiles.md) | FSLogix integration and roaming profile settings |
| [Automated Image Building](automated-image-building.md) | Image build events, PowerShell commands |
| [Firewall and Communication Ports](firewall-ports.md) | Required ports and firewall configuration |
| [Example Agent Configurations](example-configurations.md) | Validated example configurations for common scenarios |
