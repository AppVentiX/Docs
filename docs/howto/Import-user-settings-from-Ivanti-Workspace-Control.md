# HowTo: Import User Settings from Ivanti Workspace Control

This guide walks you through migrating your existing Ivanti Workspace Control (WC) configuration into AppVentiX as User Settings. It covers applications, shortcuts, drive mappings, printer mappings, environment variables, registry settings, and Group Policies.

## Overview

Each `Import-IvantiWC*` command reads an Ivanti WC **Building Block XML** file and creates the corresponding AppVentiX User Settings. Imported items are placed in the **Migrated User Settings** folder and, by default, assigned to **All Machine Groups**.

| Ivanti WC configuration | Import command |
|-------------------------|----------------|
| Applications (shortcuts + icons) | `Import-IvantiWCApplication` |
| Shortcuts | `Import-IvantiWCShortcut` |
| Network drive mappings | `Import-IvantiWCNetworkDrive` |
| Printer mappings | `Import-IvantiWCPrinterMapping` |
| Environment variables | `Import-IvantiWCEnvironmentVariable` |
| Registry settings | `Import-IvantiWCRegistry` |
| Group Policies (ADMX/ADML) | `Import-IvantiWCPolicy` |

## Prerequisites

Before you begin, ensure you have:

- AppVentiX PowerShell module installed and configured
- A valid AppVentiX license
- An exported Ivanti Workspace Control **Building Block XML** file (see Step 2)
- Access to the AppVentiX configuration store
- The Active Directory groups referenced by your Ivanti WC assignments still exist (so assignments can be resolved)

## Step 1: Verify AppVentiX Configuration

First, ensure your AppVentiX environment is properly configured:

```powershell
# Install the (latest) module
Install-Module AppVentiX [-Scope CurrentUser] [-Force] [-AllowClobber]

# Import the module
Import-Module AppVentiX

# If custom credentials are required, you can run the following command to connect
# E.g. if the current user does not have permissions to access the configuration store

$Credential = Get-Credential -Message "Enter AppVentiX Configuration Store credentials"
$ConfigShare = "\\fileserver.domain.local\config$"
Set-AppVentiXConfigShare -ConfigShare $ConfigShare -Credential $Credential

# (Optional) Verify your license is valid
Test-AppVentiXIsLicensed
```

## Step 2: Export the Ivanti WC Building Block

In the Ivanti Workspace Control **Management Console**, export the configuration you want to migrate as a **Building Block** (`.xml`). You can export the full configuration or a subset (for example only Managed Applications).

Save the resulting file somewhere the AppVentiX PowerShell session can reach, for example:

```
C:\Temp\IvantiWC-BuildingBlock.xml
```

> **Note:** `Import-IvantiWCApplication` also accepts a **directory** containing multiple XML files (one per application). The other import commands expect a single Building Block XML file.

## Step 3: Import User Settings

All import commands share the same core parameters:

| Parameter | Description |
|-----------|-------------|
| `-XmlFilePath` | Path to the Ivanti WC Building Block XML file (required). |
| `-MachineGroupFriendlyName` | Machine group to assign the imported settings to. Defaults to `All Machine Groups`. |
| `-GUI` | Displays a selection grid so you can pick which items to import. |

> **Tip:** Start every import with `-GUI` so you can review and select items before they are created. Once you are confident in the result, you can drop `-GUI` to import everything unattended.

### Applications and Shortcuts

Import application shortcuts (including icon data) from Ivanti WC:

```powershell
# Import all applications to All Machine Groups
Import-IvantiWCApplication -XmlFilePath "C:\Temp\IvantiWC-BuildingBlock.xml"

# Or select interactively and assign to a specific machine group
Import-IvantiWCApplication -XmlFilePath "C:\Temp\IvantiWC-BuildingBlock.xml" `
    -MachineGroupFriendlyName "Finance Desktops" -GUI
```

For standalone shortcuts:

```powershell
Import-IvantiWCShortcut -XmlFilePath "C:\Temp\IvantiWC-BuildingBlock.xml" -GUI
```

### Network Drives, Printers, and Environment Variables

These three commands accept an additional `-DomainFqdn` parameter, used to resolve the domain for assignments. It defaults to the current user's DNS domain (`$Env:USERDNSDOMAIN`); set it explicitly if you are migrating configuration from a different domain.

```powershell
# Network drive mappings
Import-IvantiWCNetworkDrive -XmlFilePath "C:\Temp\IvantiWC-BuildingBlock.xml" -GUI

# Printer mappings
Import-IvantiWCPrinterMapping -XmlFilePath "C:\Temp\IvantiWC-BuildingBlock.xml" -GUI

# Environment variables, with an explicit source domain
Import-IvantiWCEnvironmentVariable -XmlFilePath "C:\Temp\IvantiWC-BuildingBlock.xml" `
    -DomainFqdn "olddomain.local" -GUI
```

### Registry Settings

```powershell
Import-IvantiWCRegistry -XmlFilePath "C:\Temp\IvantiWC-BuildingBlock.xml" -GUI
```

### Group Policies (ADMX/ADML)

Group Policy import also brings across the embedded ADMX/ADML content that Ivanti WC stored with the policy:

```powershell
Import-IvantiWCPolicy -XmlFilePath "C:\Temp\IvantiWC-BuildingBlock.xml" -GUI
```

## Step 4: Verify the Import

After importing, verify your User Settings were created:

```powershell
# List all user settings
Get-AppVentiXUserSettings
```

Imported items are placed in the **Migrated User Settings** folder. You can also review them in the AppVentiX Console under **User Settings**, where you can adjust assignments and filters as needed.

## Common Issues and Solutions

### Issue: User assignments are skipped

**Symptom:** A warning states that an assignment to a *User* is skipped.

**Solution:** AppVentiX assigns User Settings to Active Directory **groups**, not individual users. Direct user assignments from Ivanti WC are intentionally skipped. Recreate them as group-based assignments where required.

### Issue: Assignment group cannot be resolved

**Symptom:** An assignment is not applied because its group is not found.

**Solution:** Ensure the Active Directory group referenced by the Ivanti WC assignment still exists and is reachable. For cross-domain migrations of drive, printer, or environment-variable settings, pass the correct source domain with `-DomainFqdn`.

### Issue: Nothing is imported

**Symptom:** The command reports that no items were selected for import.

**Solution:** When using `-GUI`, make sure you select at least one row before confirming. Without `-GUI`, confirm the Building Block actually contains items of that type.

### Issue: License check fails

**Symptom:** The import stops with a licensing error.

**Solution:** Confirm the configuration store is set (`Set-AppVentiXConfigShare`) and the license is valid (`Test-AppVentiXIsLicensed`).

## Best Practices

1. **Select interactively:** Use `-GUI` on the first pass so you import only what you need.
2. **Import in categories:** Migrate one configuration type at a time (for example applications first, then drive mappings) so results are easy to verify.
3. **Mind the source domain:** For drive mappings, printer mappings, and environment variables, set `-DomainFqdn` explicitly when the configuration originates from a different domain.
4. **Review after import:** Check the **Migrated User Settings** folder and adjust assignments and filters in the AppVentiX Console.

## Next Steps

After importing your Ivanti WC configuration, you may want to:

- Review and refine assignments and [User Settings Filters](../admin-guide/user-settings-filters.md)
- Adjust the imported settings in the AppVentiX Console
- Test delivery on a pilot group of machines

## Related Commands

- [Import-IvantiWCApplication](../powershell-module/commands/Import-IvantiWCApplication.md)
- [Import-IvantiWCShortcut](../powershell-module/commands/Import-IvantiWCShortcut.md)
- [Import-IvantiWCNetworkDrive](../powershell-module/commands/Import-IvantiWCNetworkDrive.md)
- [Import-IvantiWCPrinterMapping](../powershell-module/commands/Import-IvantiWCPrinterMapping.md)
- [Import-IvantiWCEnvironmentVariable](../powershell-module/commands/Import-IvantiWCEnvironmentVariable.md)
- [Import-IvantiWCRegistry](../powershell-module/commands/Import-IvantiWCRegistry.md)
- [Import-IvantiWCPolicy](../powershell-module/commands/Import-IvantiWCPolicy.md)
