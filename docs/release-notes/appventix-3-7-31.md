# AppVentiX 3.7.31 release notes

- Fix: When inventory based on FQDN machine names was enabled, the inventory data was not displayed correctly, this has been fixed
- Fix: When publishing tasks exists for multiple versions of a package, the old version could be published over the newer version. A new version compare mechanism has been implemented for App-V and MSIX to prevent old versions from being published when a publishing task for a newer version exists
- Enhancement: When a user configuration file is updated for an App-V package the package will be published again to process the updated user configuration file
- Enhancement: The feature "only process publishing tasks for packages on one of the configured content share(s) for the machine group" now also supports global publishing tasks (App-V)
- Enhancement: Invoking the refresh cycle through Powershell has been optimized with more options, the extra commands can be found in the admin guide
- Enhancement: It's now possible to copy the seamless publishing command also when AVD integration is enabled. This is handy in case AVD is used together with another solution like Citrix or VMware
- Enhancement: The Microsoft Store integration has been optimized
- Enhancement: The processing of MSIX dependencies has been improved
- Enhancement: The AppVentiX PowerShell module has been updated and improved for both MSIX and App-V. Check the module help for additional information and examples how to use the module

---

*Source: [AppVentiX release history](https://appventix.com/appventix-release-history/).*
