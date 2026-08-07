# AppVentiX 5.2.56 Release Notes

- This release contains a combination of fixes and improvements on top of the initial AppVentiX 5.2 release.
- Publishing tasks now include an additional relative package path value, allowing the Agent to deploy packages even if the content location has changed.
- A refresh button has been added to the machine header in Inventory, allowing the inventory to be refreshed without removing and re-adding the machine.
- Improved Azure Artifact Signing support for MSIX packages and App Control policies.
- App Control base policies can now be edited, and the name of the AppVentiX-managed base policy now includes AppVentiX for easier recognition when used alongside other base policies.
- Fixed an issue with machine group detection in Citrix PVS/MCS environments.
- Entra ID group membership now supports users who are members of more than 100 groups.
- Improved the first-time configuration experience, making it easier to connect to an existing configuration or set up a new one.
- A new self-service menu has been added to the Agent GUI, providing users with a simplified interface to start and repair App-V and MSIX applications. The self-service window can be launched using the -selfservice parameter (AppVentiX Agent GUI.exe -selfservice). A default shortcut has also been added to the user settings, making it easy to provide users with access to the self-service menu.
- AppVentiX PowerShell module updates and improvements for importing existing App-V Server configurations and Ivanti Building Blocks, as well as automating management tasks across AppVentiX