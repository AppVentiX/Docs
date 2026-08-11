# Folder Structure

Until version 5.2 the folder structure was fixed, with the introduction of version 5.2 and newer this changed.
The newer version will keep supporting the old folder structure. Only when creating a new Site, the new folder structure will be used.

In the examples below, `<config store root>` is the share or local path you selected as the AppVentiX configuration store. Names between angle brackets are placeholders that vary per environment.

## The v1 layout

Prior to version 5.2, the following folder structure was used:

```text
<config store root>/
├── Agent/
│   ├── AppVentiX Agent.msi
│   └── README.txt
├── AppControl/
│   ├── Base/
│   │   └── <guid>/
│   │       ├── BasePolicy.cip
│   │       ├── BasePolicy.cipmeta
│   │       └── BasePolicy.xml
│   └── Policies/
│       ├── <policy name>.cip
│       ├── <policy name>.cipmeta
│       └── <policy name>.xml
├── Audit/
│   └── AuditTrail.jsonl
├── Inventory/
│   └── <machine name>/      (per machine, only when needed)
│       └── Inventory.xml
├── UserSettings/
│   ├── GroupPolicy-<guid>.xml
│   └── Policies/
│       ├── <template>.admx
│       └── en-US/
│           └── <template>.adml
├── AppVentiX.lic
├── AppVentiX-AppControlPolicyAssignments.xml
├── AppVentiX-MachineGroups.xml
├── AppVentiX-PackageOptions.xml
├── AppVentiX-PublishingTasks.xml
├── AppVentiX-UserSettingFolders.xml
└── AppVentiX-UserSettingsAssignments.xml
```

All configuration files live directly in the root of the config store, next to the license file.

| Folder | Contents |
| --- | --- |
| `Agent/` | The agent installer and its readme, ready to deploy to your machines. |
| `AppControl/Base/` | One folder per base policy, named after the policy ID (GUID), holding the XML source and the compiled `.cip` policy. |
| `AppControl/Policies/` | Supplemental App Control policies, three files per policy (`.xml`, `.cip`, `.cipmeta`). |
| `Audit/` | The audit trail. See [Audit Trail](../audit-trail/index.md). |
| `Inventory/` | One folder per machine, containing the inventory reported by the agent. |
| `UserSettings/` | Group Policy definitions plus the ADMX and ADML templates they use. |
| Root `*.xml` and `AppVentiX.lic` | Machine groups, assignments, publishing tasks and the license, all in the root of the store. |

## The v2 layout

From version 5.2 onward, new sites use the layout below. The main change is that the loose XML files from the root moved into a `Configuration/` to allow for better RBAC permissions on folder/file level. See [Permissions when RBAC is enabled](../share-permissions/index.md#permissions-when-rbac-is-enabled) for the permissions to set per role, and [Role Based Access Control (RBAC)](../rbac/index.md) for the roles themselves.

### SMB Layout

```text
<config store root>/
├── Agent/
│   ├── AppVentiX Agent.msi
│   └── README.txt
├── AppControl/
│   ├── Base/
│   │   └── <guid>/
│   │       ├── BasePolicy.cip
│   │       ├── BasePolicy.cipmeta
│   │       └── BasePolicy.xml
│   └── Policies/
│       ├── <policy name>.cip
│       ├── <policy name>.cipmeta
│       └── <policy name>.xml
├── AppMask/
│   └── Rules/
│       ├── <rule name>.fxa
│       └── <rule name>.fxr
├── Audit/
│   └── AuditTrail.jsonl
├── Configuration/
│   ├── CentralView/
│   ├── Machinegroups/
│   │   ├── AppVentiX.lic
│   │   └── AppVentiX-MachineGroups.xml
│   └── Publishing/
│       ├── AppVentiX-AppControlPolicyAssignments.xml
│       ├── AppVentiX-AppControlPolicyFolders.xml
│       ├── AppVentiX-AppMaskRuleAssignments.xml
│       ├── AppVentiX-AppMaskRuleFolders.xml
│       ├── AppVentiX-PackageOptions.xml
│       ├── AppVentiX-PublishingTasks.xml
│       ├── AppVentiX-UserSettingFolders.xml
│       ├── AppVentiX-UserSettingsAssignments.xml
│       └── AppVentiX-UserSettingsFilters.xml
├── Inventory/
│   └── <machine name>/      (per machine, only when needed)
│       ├── Action.xml
│       └── Inventory.xml
└── UserSettings/
    ├── GroupPolicy-<guid>.xml
    ├── Shortcuts-<guid>.xml
    ├── ...-<guid>.xml
    └── Policies/
        ├── <template>_<hash>.admx
        └── en-US/
            └── <template>_<hash>.adml
```

| Folder | Contents |
| --- | --- |
| `Agent/` | The agent installer and its readme, ready to deploy to your machines. |
| `AppControl/` | Base policies under `Base/<guid>/` and supplemental policies under `Policies/`. See [App Control (WDAC)](../app-control/index.md). |
| `AppMask/Rules/` | FSLogix App Masking rule sets (`.fxa` and `.fxr` per rule). See [FSLogix App Masking](../app-masking/index.md). |
| `Audit/` | The audit trail. See [Audit Trail](../audit-trail/index.md). |
| `Configuration/CentralView/` | Central View console configuration. |
| `Configuration/Machinegroups/` | The license file and the machine group definitions. |
| `Configuration/Publishing/` | Assignments and publishing tasks: which packages, policies, masking rules and user settings go to which machine group. |
| `Inventory/<machine name>/` | `Inventory.xml` as before, plus `Action.xml` for pending actions on that machine. |
| `UserSettings/` | Group Policy and shortcut definitions, with the ADMX and ADML templates below `Policies/`. |

### Azure Blob Storage Layout

When the configuration store is an Azure Storage Account, each top level folder is a separate container. This lets you grant access per container instead of per folder. The same files are stored as on an SMB share, only arranged differently. See [Azure Blob Storage Configuration](../azure-blob-storage/index.md).

```text
<storage account>/
├── centralview/
├── content/
│   ├── certificates/
│   └── ContentCache.json
├── inventory/
│   └── <machine name>/      (per machine, only when needed)
├── machinegroups/
│   ├── AppVentiX.lic
│   └── AppVentiX-MachineGroups.xml
└── publishing/
    ├── AppControl/
    │   ├── Base/
    │   │   └── <guid>/
    │   │       ├── BasePolicy.cip
    │   │       ├── BasePolicy.cipmeta
    │   │       └── BasePolicy.xml
    │   └── Policies/
    │       ├── <policy name>.cip
    │       ├── <policy name>.cipmeta
    │       └── <policy name>.xml
    ├── AppMask/
    │   └── Rules/
    │       ├── <rule name>.fxa
    │       └── <rule name>.fxr
    ├── Audit/
    │   └── AuditTrail.jsonl
    ├── UserSettings/
    │   ├── GroupPolicy-<guid>.xml
    │   ├── Shortcuts-<guid>.xml
    │   ├── ...-<guid>.xml
    │   └── Policies/
    │       ├── <template>_<hash>.admx
    │       └── en-US/
    │           └── <template>_<hash>.adml
    ├── AppVentiX-AppControlPolicyAssignments.xml
    ├── AppVentiX-AppControlPolicyFolders.xml
    ├── AppVentiX-AppMaskRuleAssignments.xml
    ├── AppVentiX-AppMaskRuleFolders.xml
    ├── AppVentiX-PackageOptions.xml
    ├── AppVentiX-PublishingTasks.xml
    ├── AppVentiX-UserSettingFolders.xml
    ├── AppVentiX-UserSettingsAssignments.xml
    └── AppVentiX-UserSettingsFilters.xml
```

| Container | Contents |
| --- | --- |
| `centralview` | Central View console configuration. |
| `content` | Published content, the MSIX signing certificates and the content cache index. |
| `inventory` | One folder per machine, containing the inventory reported by the agent. |
| `machinegroups` | The license file and the machine group definitions. |
| `publishing` | Everything that gets published to the machines: App Control policies, App Masking rules, the audit trail and user settings, plus the assignment and folder XML files. |

!!! note
    Existing sites keep their current layout after upgrading to 5.2. There is no need to move files by hand, and no migration step is required.
