# AppVentiX Central View Console

Central View is the centerpiece of your deployment. It is a lightweight, easy-to-use real-time management console. Central View does not need a dedicated back-end server.

![AppVentiX Central View](central-view-03.png)

---

## Machine Groups

Central View reads Active Directory group(s), Active Directory OUs, or Entra ID to retrieve the machines in a specific machine group. The agent will automatically detect which machine group it belongs to. Please read the [Quick Start](../../quickstart/index.md) steps for an impression of how to create a machine group.

In Active Directory environments, the easiest approach is to create machine groups based on OUs. Machines are automatically pulled from the selected OU, so there is no need to manually add or remove devices. The group updates automatically.

![Machine group based on OU](central-view-01.png)

When creating a machine group based on an AD group instead of OU, make sure you enable the following option in Active Directory when adding machines to the AD group, or else you cannot find machine accounts to add to the AD group.

> **Note:** You can create multiple machine groups and machines can be members of multiple machine groups. You can also configure multiple content stores for a machine group. The agent will retrieve packages from all configured content stores. The agent will only apply Agent Settings from the first Machine Group it is a member of.

For Entra ID-based machine groups, please consult the [Entra ID (Azure AD) setup](../entra-id/index.md) section in this admin guide.

You can always edit a machine group and change Agent Settings. Please note that the Agent Service on the machine needs to be restarted before the new settings will be activated.

When creating a machine group you can configure content store(s) for the group. Next to the content store you have the option to select a checkbox: **Enable Pre-cache**.

When pre-cache is enabled for a content store, the agent will deploy packages from the content store in the cache when the refresh cycle runs. Use pre-cache when you want packages to be available on the agent before a user logs in (for fast publishing). For App-V this means packages are loaded on the machine; for MSIX this means packages are staged on the machine (when used in combination with App Attach, the disk is attached and the package staged).

Do not enable pre-cache for a content store if you want packages to be deployed on the fly at user login using publishing tasks. This is supported for all package formats: App-V, MSIX, and App Attach.
