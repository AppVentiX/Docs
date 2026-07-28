# Administrator Guide

AppVentiX works with a lightweight agent running on the same machine as the App-V and MSIX (app attach) client (part of Windows). This can either be a virtual machine (Microsoft RDS/AVD Hostpool/Windows365, Citrix VDI (PVS/MCS), VMware Horizon, etc) or physical machine (PC or Laptop). The agent can be pushed from the Central View console or easily installed silently.

The Central View console can be installed on any machine and does not need any (SQL) back-end. AppVentiX only requires a file share or an Azure storage blob for the configuration. A wide range of file share types are supported: Windows file shares (direct or DFS), Azure file shares (domain integrated and stand-alone), Azure Storage Blob, Nutanix and NetApp file shares, and QUIC shares accessed over port 443.

---

## Sections

| Section | Description |
|---------|-------------|
| [Architecture](architecture/index.md) | System topology and how the AppVentiX components fit together |
| [AppVentiX Central View](central-view/index.md) | The management console, machine groups, and where configuration is stored |
| [AppVentiX Agent](agent/index.md) | The agent service, its interface, and the refresh cycle |
| [Package Management](package-management/index.md) | Content stores and publishing App-V, MSIX, and app attach packages |
| [User Settings](user-settings/index.md) | Shortcuts, drive mappings, printers, registry settings, and filters |
| [Security and Access Control](security/index.md) | Console access, App Control (WDAC), App Masking, and audit logging |
| [Integrations](integrations/index.md) | Entra ID, Azure Virtual Desktop, and the supported share types |
| [Advanced Configuration](advanced-configuration/index.md) | Permissions, roaming profiles, image building, and firewall ports |

---

New to AppVentiX? Start with the [Quick Start](../quickstart/index.md) to get a working deployment, then come back here for the detail.
