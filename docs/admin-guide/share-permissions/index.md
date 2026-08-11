# Share Permissions and Share Configuration

AppVentiX supports Windows file shares (both direct and DFS), Azure file shares (domain integrated or stand-alone), and shares created on storage vendors like Nutanix and NetApp. AppVentiX can be configured to use integrated authentication or a (service) account to access the shares. The permission table is visible in the Central View console (share permission button).

## Required Share Permissions

| Share | AppVentiX Agent | AppVentiX Central View |
|-------|----------------|------------------------|
| Configuration store | Read | Read/Write* |
| Configuration store (inventory folder) | Read/Write | Read/Write |
| content store(s) | Read | Read* |

!!! note
    Central View needs also Write permissions if you want to edit packages, convert MSIX packages to App Attach or App-V packages to MSIX, or if you want to delete content from the content store directly from the console. For other management activities, only Read permissions are needed. This means you can provide the console to helpdesk/admins to operate the deployment but not change any configurations.

The sections below list the identities that need these permissions. They use the NTFS term **Modify** for the Read/Write level in the table above. Always verify both the share permissions and the NTFS permissions, because the effective permission is the most restrictive of the two.

!!! example "The most restrictive permission wins"
    The management group is granted Modify on the NTFS permissions of the configuration store, but the share itself only grants Read:

    | Level | Permission for the management group |
    |-------|--------------------------------------|
    | Share | Read |
    | NTFS | Modify |
    | Effective | Read |

    Central View can then open the configuration, but saving a change fails. Setting the share to Everybody Full Control and controlling access with the NTFS permissions only, as described under [Applying the permissions](#applying-the-permissions), avoids this.

## Authentication methods

Which identity reaches the store depends on how you configure the authentication. That identity also decides whether the RBAC roles can be backed by permissions on the store, because permissions can only separate the roles when the console reaches the store as the logged in user:

| Authentication | Central View accesses the store as | Agent accesses the store as | Per-role permissions |
|----------------|------------------------------------|-----------------------------|----------------------|
| Integrated authentication | The logged in user | The computer account | Yes, enforced for the console as well |
| Configured account | The configured (service) account | The computer account | No, every console user is the same identity |
| Storage account key | The storage account | The storage account | No |
| App registration and certificate | The app registration | The app registration | Direct access only, not the console |

The agent can be given a configured account of its own, see [Service Accounts](../service-accounts/index.md).

Integrated authentication needs an identity source that both the share and the machines trust, so it applies to Active Directory environments and to Azure file shares that are AD integrated. A stand-alone Azure file share has no such identities, so the storage account name and access key are used instead. Azure AD Kerberos integrated shares are configured the same way. An Azure Blob Storage store uses an app registration with a client certificate, see [Azure Blob Storage Configuration](../azure-blob-storage/index.md).

## Windows file share, storage vendor file share, or AD integrated Azure file share

### Integrated authentication

With integrated authentication the Central View console will access the share(s) with the currently logged in user, and the Agent will access the share(s) with the computer account.

File permissions needed for this option:

- User group performing management in Central View: Modify permissions on the configuration share and the content share(s)
- Domain Computers group (or group containing the machine accounts): Read permissions on the configuration share and the content share(s)
- Domain Computers group (or group containing the machine accounts): Modify permissions on the inventory folder only

!!! tip
    By default the inventory is stored on the configuration store. On the Inventory tab of the [agent settings](../agent-settings/index.md) you can point a machine group at another share instead. The machines need Modify permissions on whichever location you use.

When RBAC is enabled, the group performing management splits into the Admin, Operator and Helpdesk groups. Grant those groups their permissions as described under [Permissions when RBAC is enabled](#permissions-when-rbac-is-enabled).

### Configured account (service account)

With a configured account the Central View console will access the share(s) with that account, no matter which user is logged in. The Agent keeps using the computer account until you configure an account on the agent as well, see [Service Accounts](../service-accounts/index.md).

File permissions needed for this option:

- The configured (service) account: Modify permissions on the configuration share and the content share(s)
- Domain Computers group (or group containing the machine accounts): Read permissions on the configuration share and the content share(s)
- Domain Computers group (or group containing the machine accounts): Modify permissions on the inventory folder only

When you configure an account on the agent too, that account needs the Read and Modify permissions listed for the Domain Computers group instead.

!!! warning
    File-level RBAC has no effect on the console with a configured account. Every console user reaches the store as the same account, so the file system cannot tell the roles apart. The roles you configure in [Role Based Access Control (RBAC)](../rbac/index.md) still apply inside the console.

## Azure file share, Kerberos integrated or stand-alone

### Configured account (storage account key)

A stand-alone Azure file share has no Active Directory identities to grant permissions to. Both the console and the agent access the share with the storage account name and access key, entered as `localhost\storageaccountname`. Azure AD Kerberos integrated shares are configured the same way. See [Azure File Share Configuration](../azure-file-share/index.md) for the full setup.

Because there is a single identity for all access, permissions are not split per role or per machine here. The Admin, Operator and Helpdesk roles from [Role Based Access Control (RBAC)](../rbac/index.md) still apply inside the console, but they cannot be backed by file permissions on this type of share. Access is controlled by who holds the access key, so treat it as a secret and rotate it through the storage account when needed.

Give the agent the same credentials so it can reach the share on machines that are not domain joined, see [Service Accounts](../service-accounts/index.md).

## Permissions when RBAC is enabled

The roles you configure in [Role Based Access Control (RBAC)](../rbac/index.md) apply to the Central View console only. They do not change file permissions. Without matching permissions on the store, an Operator or Helpdesk user can still open the configuration files outside the console and edit them.

Where you set those permissions depends on the layout of the configuration store. Sites created before version 5.2 use the v1 layout, where all configuration files sit in the root of the store. Sites created on 5.2 or later use the v2 layout, where those files moved into a `Configuration/` folder precisely so they can be secured per role. Existing sites keep their layout after an upgrade. See [Folder Structure](../folder-structure/index.md) to determine which one you have.

Each role below is the AD or Entra ID group you selected for that role in the RBAC configuration.

### v1 layout

All configuration files sit in the root of the store, so the split has to be made per file:

| File or folder | Admin | Operator | Helpdesk |
|----------------|-------|----------|----------|
| `AppVentiX-AppControlPolicyAssignments.xml` | Modify | Modify | Read |
| `AppVentiX-PackageOptions.xml` | Modify | Modify | Read |
| `AppVentiX-PublishingTasks.xml` | Modify | Modify | Read |
| `AppVentiX-UserSettingFolders.xml` | Modify | Modify | Read |
| `AppVentiX-UserSettingsAssignments.xml` | Modify | Modify | Read |
| `AppVentiX-MachineGroups.xml` | Modify | Read | Read |
| `AppVentiX.lic` | Modify | Read | Read |
| `AppControl/`, `UserSettings/`, `Audit/` | Modify | Modify | Read |
| `Inventory/` | Modify | Modify | Modify |
| `Agent/` | Modify | Read | Read |

!!! warning
    Permissions set on individual files are easy to lose. A file that is recreated, or one that a later version adds to the store, inherits the permissions of the root folder instead. Check the root of the store after an upgrade.

### v2 layout, SMB file share

Set the permissions per role on the folders of the configuration store:

| Folder | Admin | Operator | Helpdesk |
|--------|-------|----------|----------|
| `Configuration/CentralView/` | Modify | Read | Read |
| `Configuration/Publishing/` | Modify | Modify | Read |
| `Configuration/Machinegroups/` | Modify | Read | Read |
| `AppControl/`, `AppMask/`, `UserSettings/`, `Audit/` | Modify | Modify | Read |
| `Inventory/` | Modify | Modify | Modify |
| `Agent` | Modify | Read | Read |

All three roles need Modify permissions on `Inventory/`, because running an inventory or a refresh action writes `Action.xml` for the selected machines. The remaining folders, such as `Agent/`, need Read for all three roles.

!!! warning
    These permissions only take effect with integrated authentication, where the console reaches the store as the logged in user.

### Azure Blob Storage

Assign those roles per container to the same groups:

| Container | Admin | Operator | Helpdesk |
|-----------|-------|----------|----------|
| `centralview` | SB Data Contributor | SB Data Reader | SB Data Reader |
| `publishing` | SB Data Contributor | SB Data Contributor | SB Data Reader |
| `machinegroups` | SB Data Contributor | SB Data Reader | SB Data Reader |
| `inventory` | SB Data Contributor | SB Data Contributor | SB Data Contributor |
| `content` | SB Data Contributor | SB Data Contributor | SB Data Reader |

!!! note
    SB Data Contributor and SB Data Reader in the table are the built-in **Storage Blob Data Contributor** and **Storage Blob Data Reader** roles. Do not use the subscription level Contributor and Reader roles, which grant management access to the storage account rather than access to the data in it.

!!! warning
    Central View and the agents authenticate to the storage account with a single app registration and client certificate, not as the logged in user. Container permissions therefore restrict direct access to the storage account through the Azure portal, Storage Explorer or similar tools. They do not change what a user can do inside the console, which is governed by the console roles. See [Azure Blob Storage Configuration](../azure-blob-storage/index.md).

## Applying the permissions

Share permissions can be set to Everybody Full Control, so NTFS permissions are used for effective permissions to the files.

On the configuration store, the Domain Computers group needs Read & Execute:

![NTFS permissions on the Config folder, Domain Computers set to Read](share-permissions-01.png)

On the inventory folder inside it, the same group needs Modify:

![NTFS permissions on the Inventory folder, Domain Computers set to Modify](share-permissions-02.png)

To configure a service account for Central View or for the agent instead of integrated authentication, see [Service Accounts](../service-accounts/index.md).