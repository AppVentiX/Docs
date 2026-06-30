# Technical Architecture

AppVentiX follows a file-share-based architecture with no SQL back-end. A central Management Console (Central View) connects to one or more file shares that hold the configuration, application packages, state files or application containers. Agents running on endpoint machines read from those shares over SMB (or QUIC on port 443) and apply the configuration locally. Authentication and targeting rely on Active Directory, Entra ID or hybrid.

The diagram below shows a typical multi-site deployment. A single-site deployment is equally supported - the multi-site replication component is optional.

[![AppVentiX Technical Architecture](images/architecture/technical-architecture.png)](images/architecture/technical-architecture.png){target="_blank"}


---

## Key components

| Component                             | Role                                                                                                 |
| ------------------------------------- | ---------------------------------------------------------------------------------------------------- |
| **Management Console (Central View)** | Centralized management UI for application distribution, workspace settings, and role-based access control. Connects directly to the file share - no database required. |
| **File Servers / File Shares**        | Holds configuration, application packages, state files or application containers. Supports Windows file shares (direct or DFS), Azure File Shares, Nutanix, NetApp, and QUIC shares. |
| **AppVentiX Agent**                   | Lightweight service running on endpoint machines (physical or virtual). Reads configuration from the share and applies packages and settings locally. Includes a local cache for resilience. |
| **Identity Provider**                 | Active Directory or Entra ID is used for machine group targeting and access control.                 |
| **Multi-site replication (optional)** | File share content can be replicated across sites using DFS-R, Azure File Sync, or third-party solutions. |