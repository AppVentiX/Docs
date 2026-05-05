# Command Reference

This section contains detailed documentation for all AppVentiX PowerShell commands.

## Configuration Commands

Commands for configuring the AppVentiX module and its connection settings:

| Command | Description |
|---------|-------------|
| [Get-AppVentiXConfigShare](Get-AppVentiXConfigShare.md) | Retrieves the AppVentiX configuration store if defined |
| [Set-AppVentiXConfigShare](Set-AppVentiXConfigShare.md) | Sets the path to the AppVentiX configuration store |
| [Get-AppVentiXModuleVariable](Get-AppVentiXModuleVariable.md) | Retrieves the variables from the AppVentiX module |
| [Set-AppVentiXADCredential](Set-AppVentiXADCredential.md) | Sets the Active Directory credentials used by AppVentiX services for directory lookups |
| [Clear-AppVentiXADCredential](Clear-AppVentiXADCredential.md) | Clears Active Directory credentials from the current PowerShell session |

## License Commands

Commands for managing the AppVentiX license:

| Command | Description |
|---------|-------------|
| [Get-AppVentiXLicence](Get-AppVentiXLicence.md) | Retrieves the details of the AppVentiX license |
| [Test-AppVentiXIsLicensed](Test-AppVentiXIsLicensed.md) | Checks if the AppVentiX license is valid |
| [Update-AppVentixLicense](Update-AppVentixLicense.md) | Updates the AppVentiX license file on the configuration store |

## Machine Group Commands

Commands for managing AppVentiX machine groups:

| Command | Description |
|---------|-------------|
| [Get-AppVentiXMachineGroup](Get-AppVentiXMachineGroup.md) | Retrieves the machine groups from the AppVentiX configuration |

## Package Commands

Commands for managing App-V and MSIX packages:

| Command | Description |
|---------|-------------|
| [Add-AppVentiXPackage](Add-AppVentiXPackage.md) | Adds an App-V or MSIX package to an AppVentiX machine group content share |
| [Get-AppVentiXContentSharePackages](Get-AppVentiXContentSharePackages.md) | Retrieves packages from the AppVentiX content shares |
| [New-AppVentiXConnectionGroup](New-AppVentiXConnectionGroup.md) | Creates a new App-V Connection Group XML file (.appg) from specified App-V packages and saves it to a content share |

## Publishing Task Commands

Commands for managing AppVentiX publishing tasks:

| Command | Description |
|---------|-------------|
| [Get-AppVentiXPublishingTask](Get-AppVentiXPublishingTask.md) | Retrieves the publishing tasks from the AppVentiX configuration store |
| [New-AppVentiXPublishingTask](New-AppVentiXPublishingTask.md) | Creates a new AppVentiX publishing task |
| [Set-AppVentiXPublishingTask](Set-AppVentiXPublishingTask.md) | Updates the properties of an AppVentiX publishing task |
| [Copy-AppVentiXPublishingTask](Copy-AppVentiXPublishingTask.md) | Copies AppVentiX publishing tasks to a new machine group with optional Azure Virtual Desktop seamless publishing |
| [Remove-AppVentiXPublishingTask](Remove-AppVentiXPublishingTask.md) | Removes an AppVentiX publishing task |
| [Export-AppVentiXPublishingTaskReport](Export-AppVentiXPublishingTaskReport.md) | Exports the AppVentiX publishing task report to a CSV file |

## Seamless Publishing Commands

Commands for managing Azure Virtual Desktop seamless publishing:

| Command | Description |
|---------|-------------|
| [Enable-AppVentiXSeamlessPublishing](Enable-AppVentiXSeamlessPublishing.md) | Enables seamless publishing for the specified publishing task |
| [Disable-AppVentiXSeamlessPublishing](Disable-AppVentiXSeamlessPublishing.md) | Disables seamless publishing for an AppVentiX task in an Azure environment |
| [Get-AppVentiXSeamlessPublishCommand](Get-AppVentiXSeamlessPublishCommand.md) | Retrieves the seamless publishing command for the specified publishing task |
| [Export-AppVentiXSeamlessApplicationsReport](Export-AppVentiXSeamlessApplicationsReport.md) | Exports the AppVentiX Seamless Applications to a CSV file |

## User Settings Commands

Commands for creating and managing AppVentiX user settings:

| Command | Description |
|---------|-------------|
| [Get-AppVentiXUserSettings](Get-AppVentiXUserSettings.md) | Retrieves user settings from the AppVentiX configuration |
| [New-AppVentiXDriveMappingUserSetting](New-AppVentiXDriveMappingUserSetting.md) | Creates an AppVentiX UserSetting XML file for a Drive Mapping configuration |
| [New-AppVentiXEnvironmentVariableUserSetting](New-AppVentiXEnvironmentVariableUserSetting.md) | Creates an AppVentiX UserSetting XML file for an Environment Variable configuration |
| [New-AppVentiXGroupPolicyUserSetting](New-AppVentiXGroupPolicyUserSetting.md) | Creates an AppVentiX UserSetting XML file for a Group Policy configuration |
| [New-AppVentiXPrinterMappingUserSetting](New-AppVentiXPrinterMappingUserSetting.md) | Creates an AppVentiX UserSetting XML file for a Printer Mapping configuration |
| [New-AppVentiXRegistryUserSetting](New-AppVentiXRegistryUserSetting.md) | Creates an AppVentiX UserSetting XML file for a Registry Settings configuration |
| [New-AppVentiXShortcutUserSetting](New-AppVentiXShortcutUserSetting.md) | Creates an AppVentiX UserSetting XML file for a Shortcuts configuration |
| [Set-AppVentiXUserSettingFolder](Set-AppVentiXUserSettingFolder.md) | Assigns a UserSetting to a folder in the UserSettingFolders XML file |
| [Set-AppVentiXUserSettingsAssignment](Set-AppVentiXUserSettingsAssignment.md) | Assigns a user setting to an Active Directory group in AppVentiX |

## Migration Commands

Commands for migrating from App-V Management Server to AppVentiX:

| Command | Description |
|---------|-------------|
| [Test-AppVManagementSQLConnection](Test-AppVManagementSQLConnection.md) | Tests the connection to the App-V Management SQL Database |
| [Get-AppVManagementPackage](Get-AppVManagementPackage.md) | Retrieves App-V packages with AD access entitlements from the Microsoft App-V Management database |
| [Get-AppVManagementConnectionGroup](Get-AppVManagementConnectionGroup.md) | Retrieves App-V Connection Groups (Package Groups) from the Management Database |
| [Import-AppVManagementPackage](Import-AppVManagementPackage.md) | Imports App-V packages from the Management Database to AppVentiX |
| [Import-AppVManagementConnectionGroup](Import-AppVManagementConnectionGroup.md) | Imports Connection Groups from the Management Database to AppVentiX |

## Ivanti Workspace Control Migration Commands

Commands for migrating from Ivanti Workspace Control to AppVentiX:

| Command | Description |
|---------|-------------|
| [Get-AdmxPolicySetting](Get-AdmxPolicySetting.md) | Retrieves Group Policy setting details from ADMX/ADML files matching a registry key path and value name |
| [Get-IvantiWCApplication](Get-IvantiWCApplication.md) | Retrieves Ivanti Workspace Control application configurations from XML files |
| [Get-IvantiWCEnvironmentVariable](Get-IvantiWCEnvironmentVariable.md) | Retrieves Ivanti Workspace Control variable configurations from XML files |
| [Get-IvantiWCNetworkDrive](Get-IvantiWCNetworkDrive.md) | Retrieves Ivanti Workspace Control network drive mappings from XML files |
| [Get-IvantiWCPolicy](Get-IvantiWCPolicy.md) | Reads, decodes, and correlates Ivanti Workspace Control policy sets from a Building Block XML file |
| [Get-IvantiWCPrinterMapping](Get-IvantiWCPrinterMapping.md) | Parses Ivanti Workspace Control XML file(s) to extract printer mappings |
| [Get-IvantiWCRegistry](Get-IvantiWCRegistry.md) | Reads and parses Ivanti Workspace Control registry sets from a Building Block XML file or a standalone .reg file |
| [Import-IvantiWCApplication](Import-IvantiWCApplication.md) | Imports application shortcuts from Ivanti Workspace Control XML configuration into AppVentiX |
| [Import-IvantiWCEnvironmentVariable](Import-IvantiWCEnvironmentVariable.md) | Imports environment variables from Ivanti Workspace Control XML configuration into AppVentiX |
| [Import-IvantiWCNetworkDrive](Import-IvantiWCNetworkDrive.md) | Imports network drive mappings from Ivanti Workspace Control XML configuration into AppVentiX |
| [Import-IvantiWCPolicy](Import-IvantiWCPolicy.md) | Imports Group Policy settings from Ivanti Workspace Control XML configuration into AppVentiX |
| [Import-IvantiWCPrinterMapping](Import-IvantiWCPrinterMapping.md) | Imports printer mappings from Ivanti Workspace Control XML configuration into AppVentiX |
| [Import-IvantiWCRegistry](Import-IvantiWCRegistry.md) | Imports registry settings from Ivanti Workspace Control XML configuration into AppVentiX |
| [Import-IvantiWCShortcut](Import-IvantiWCShortcut.md) | Imports shortcuts from Ivanti Workspace Control XML configuration into AppVentiX |
