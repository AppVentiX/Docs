# Administrator Guide

AppVentiX works with a lightweight agent running on the same machine as the App-V and MSIX (app attach) client (part of Windows). This can either be a virtual machine (Microsoft RDS/AVD Hostpool/Windows365, Citrix VDI (PVS/MCS), VMware Horizon, etc) or physical machine (PC or Laptop). The agent can be pushed from the Central View console or easily installed silently.

The Central View console can be installed on any management machine and does not need any (SQL) back-end. AppVentiX only requires a file share. A wide range of file share types are supported: Windows file shares (direct or DFS), Azure file shares (domain integrated and stand-alone), Nutanix and NetApp file shares, and QUIC shares accessed over port 443. The AppVentiX solution is easy to implement and will give you complete control and insight in under 10 minutes.

---

## Architecture

| Topic | Description |
|-------|-------------|
| [Technical Architecture](architecture.md) | System topology diagram and overview of all AppVentiX components |

---

## Central View Configuration

| Topic | Description |
|-------|-------------|
| [Quick Start](../quickstart/index.md) | Get up and running with AppVentiX in minutes |
| [Azure Blob Storage Configuration](../admin-guide/azure-blob-storage.md) | Setup a Azure Blob Storage automatically or manually |
| [Limit Access to Central View](access-control.md) | RBAC roles and share-based access |
---

## AppVentiX Components

| Topic | Description |
|-------|-------------|
| [Agent Service](agent-service.md) | The AppVentiX Agent Service, event log, and refresh cycle |
| [Agent GUI](agent-gui.md) | The AppVentiX Agent GUI and Refresh Shortcut |
| [Central View Console](central-view.md) | Machine Groups, Manage Machines, and console overview |
| [Machine Group Agent Settings](agent-settings.md) | All agent settings explained per category |

---

## Package Management

| Topic | Description |
|-------|-------------|
| [Manage Content and Publishing Tasks](manage-content.md) | Content shares, publishing tasks, package options |
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
| [Audit Trail](audit-trail.md) | Configuration audit logging |

---

## User Settings

| Topic | Description |
|-------|-------------|
| [Configuring User Settings](user-settings.md) | Registry, drive mappings, printers, group policies, shortcuts |

---

## Integrations

| Topic | Description |
|-------|-------------|
| [Azure Virtual Desktop (AVD)](azure-virtual-desktop.md) | AVD Desktop and RemoteApp integration |
| [Azure AD / Entra ID](entra-id.md) | Entra ID machine groups and application registration |
| [Azure File Share](azure-file-share.md) | Setting up Azure file shares for AppVentiX |
| [QUIC Share (Port 443)](quic-share.md) | SMB over HTTPS for share access over port 443 |

---

## Advanced Configuration

| Topic | Description |
|-------|-------------|
| [Share Permissions and Configuration](share-permissions.md) | Share and NTFS permission setup |
| [Central View Inventory and Advanced Settings](central-view-advanced.md) | Inventory storage, LDAPS, WinRM over SSL |
| [Supported Operating Systems](supported-os.md) | Supported OS versions for agent and Central View |
| [Upgrading AppVentiX](supported-os.md#upgrade-from-an-earlier-version-of-appventix) | Upgrading from earlier versions |
| [FSLogix and Roaming Profiles](fslogix-profiles.md) | FSLogix integration and roaming profile settings |
| [Automated Image Building](automated-image-building.md) | Image build events, PowerShell commands |
| [Firewall and Communication Ports](firewall-ports.md) | Required ports and firewall configuration |
| [Example Agent Configurations](example-configurations.md) | Validated example configurations for common scenarios |
