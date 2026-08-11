# Role Based Access Control (RBAC)

Role Based Access Control (RBAC) lets you delegate access to the AppVentiX Central View console without handing out full administrative control. Each role is linked to an Active Directory or Entra ID group. When a user starts the console, their group membership determines which role applies.

A role controls which actions the user can perform. This allows helpdesk and operations teams to do their daily work while reducing the risk of accidental configuration changes.

Within AppVentiX there are three roles you can configure:

- **Admin**: Can modify configuration, manage machine groups, and access all features. Full access.
- **Operator**: Can configure publishing tasks for packages, create assignments (App Control, App Mask and User Settings), manage package options and view inventory. Limited access.
- **Helpdesk**: Can view assignments and inventory only. Read-only access to troubleshoot and assist users.

!!! note
    With these roles you configure only the AppVentiX Central View console. File-level RBAC needs to be configured separately.

## Enable role-based access control for the Central View console

To enable RBAC support, navigate to the **Configuration & Activity** tab and click the **Settings** button.
In the **Central View Settings** window, open the **Settings** tab.
Under **Central View access**, check **Enable role-based access control (RBAC) for Central View console**.

![Enable role-based access control for the Central View console](image.png)

Depending on your enabled integrations, you might only see the AD Group or Entra ID Group button. If you have an Active Directory environment configured and have Entra ID integration enabled, you see both.
Click the **AD Group** or **Entra ID Group** button to configure the RBAC groups.

![Assign Groups](image-1.png)

When RBAC is enabled, the **Admin** group is _required_. The **Operator** and **Helpdesk** groups are _optional_. Only **one** group per role is configurable.
Select the **Admin** button to select the group.

![Select role](image-2.png)

For Active Directory, the default group selection dialog will be presented where you can find and select an AD group.

![Select AD group](image-3.png)

For Entra ID a dialog will be presented, where you can find and select an Entra ID group.

![Select Entra ID group](image-4.png)

When you have enabled RBAC and configured the groups, make sure your admins are added to the configured Admin group.
When access is denied you are presented with the following warning message.

![Blocked access](image-6.png)

## Limit concurrent inventory

With **Limit concurrent inventory** you determine the maximum number of machines a user in a role may run a Selected Machine inventory or refresh action against at the same time. Admins are **always** unlimited.
You can configure values for Operator (default 100) and Helpdesk (default 1). Set **0** for unlimited.

![Limit concurrent inventory](image-5.png)
