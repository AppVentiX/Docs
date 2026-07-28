# FSLogix App Masking Management

Software compatibility with App-V and MSIX is very high. However, there are scenarios where applications must be installed directly on machines without using App-V or MSIX.

With FSLogix App Masking, you can control which user groups can see specific applications by hiding files and registry items. AppVentiX makes it easy to centrally manage App Masking rules and assignments.

Click **Browse to Rule Location** and place your rules and assignments in that folder. Then click **Refresh Rules** and drag the rules to a machine group to deploy them to all machines in that group. When a rule is unassigned, it is automatically removed from the machines.

You can also modify App Masking rules and assignments directly from the Central View console. Changes are automatically updated on the machines. The **Last Updated** time in the machine inventory clearly shows which rule set and assignments are currently active.

To enable App Masking management, enable the feature in the [Agent Settings](../agent-settings/index.md) for the machine group.
