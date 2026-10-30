# AppVentiX 5.4.32 release notes

AppVentiX 5.4.32 is now available! This release adds custom branding, AppLocker management in App Control, and a redesigned wrapper progress window. It also brings several MSIX improvements, including automatic package healing and dependency installation.

## New features and improvements

- **Custom Branding**: Personalize the refresh progress windows and management console with a custom icon and colors.
- **App Control now also supports AppLocker management**: The App Control feature has been extended to support AppLocker policy management, enabling application access control based on users and groups, particularly useful in multi-session environments. AppLocker management follows the same streamlined workflow as App Control: enable Learning Mode, collect audit events, generate rules, and switch to Enforcement Mode when ready. Once enforcement is enabled, blocked application attempts are also logged for monitoring and troubleshooting.
- **MSIX Package Editor**: Added support for configuring environment variables and enabling write access to the Virtual File System (VFS).
- **MSIX Package Healing**: MSIX packages in a paused state are now automatically detected and repaired.
- **MSIX Store App Management**: MSIX Store apps imported into the console are now automatically converted into managed packages if they are already installed on a machine, instead of being skipped.
- **MSIX Dependencies**: Missing MSIX package dependencies are now automatically installed when required by a package.
- **Wrapper Progress Window**: The wrapper progress window, used in RemoteApp scenarios, has been redesigned with a modernized interface that supports custom branding.
- **Progress Window Performance**: Reduced CPU usage by optimizing UI elements such as shadow effects, particularly in environments without GPU acceleration.
- **Workspace Control**: Added support for linking user settings and introduced a Fast Connect option for printers.
- **Management console improvements**: Multiple UI enhancements, including support for creating subfolders to better organize and manage items.

## Fixes

- Fixed an issue where the management console could select the wrong App-V deployment configuration file when activating the deployment configuration.
- Fixed an issue in Workspace Control that could cause duplicate environment variables.

---

*Source: [AppVentiX release history](https://appventix.com/appventix-release-history/).*
