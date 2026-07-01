# AppVentiX 4.1.27 release notes

## New features and improvements in AppVentiX 4.1

## Scalability Enhancements

Optimized for large-scale environments, delivering higher performance and reduced load on network shares. The agent now caches the content share inventory and reads only changed content.

## Central View Enhancements

- Optimized inventory caching mechanism, reducing content inventory processing time from seconds to milliseconds.
- Improved content overview with dedicated views for Package content and App masking, making navigation more intuitive.
- Right-click context menu updates and faster overall load times.
- Added column filtering options in Central View for quicker sorting, searching, and data analysis.

## Inventory Improvements

- Enhanced multi-machine inventory handling.
- New ability to change the inventory storage location (e.g., move to a different share).

## Multi-Domain Support

Improved compatibility and functionality in multi-domain environments.

## User Group Retrieval Enhancements

Updated group memberships can now be retrieved without requiring user logoff/logon, enabling immediate application availability after group assignment.

## MSIX Improvements

- Enhanced roaming support when using profile containers like FSLogix.
- Improved expand to App Attach process.
- Package information is now correctly displayed in the refresh progress window.
- Improved experience when importing applications from the Microsoft Store.
- Easier creation of MSIX packages directly from the Central View console, with simplified management of shortcuts, scripts, and package content.

## App-V Enhancements

- New option to unpublish packages at logoff, ensuring a clean publishing state and preventing orphaned shortcuts.
- Extended App-V client settings in agent configuration.
- Support for multiple deployment configuration files in the same folder (see Admin Guide).
- Agent GUI now supports mounting App-V packages.
- By default, the agent GUI only displays packages published to the current user unless launched with administrative privileges.

## Agent Stability Improvements

- The AppVentiX Agent service will now retry if the initial configuration cannot be retrieved, instead of stopping.
- General improvements to service stability and module loading.
- Enhanced Citrix image mode detection.
- Enhanced offline support with improved configuration caching for scenarios where the configuration share is unavailable.

## Improved Refresh Experience

Package information is now accurately displayed during application refresh operations, both via the agent GUI and the dedicated Start Menu refresh applet, providing clearer status updates.

## QUIC File Share Support

Full support for QUIC file shares, a secure SMB over SSL protocol compatible with on-prem and Azure file shares, based on the latest TLS standards.

## AVD Integration Enhancements

Now supports multiple Azure subscriptions for better scalability in virtual desktop environments.

## General Improvements

- Numerous usability and UI updates.
- Broad stability and scalability enhancements across the platform.
- AppVentiX Powershell module improvements.

## Other improvements and fixes

The following list of improvements are also implemented in version 4.1:

- PowerShell Module UI Bug Fixed an issue where the "Show Icon" was missing for packages published via the AppVentiX PowerShell module.
- Expand to App Attach could fail Resolved a problem where expand to App Attach failed for packages with long names.
- MSIX Dependency Handling Fixed incorrect display of MSIX dependency packages in the package details view.
- Regional Compatibility Addressed various localization issues on non-English operating systems.
- App-V Client Module Load Improved reliability in loading App-V client modules by the service.
- Other Fixes Various minor fixes and enhancements to improve overall stability and performance.

---

*Source: [AppVentiX release history](https://appventix.com/appventix-release-history/).*
