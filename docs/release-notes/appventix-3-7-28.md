# AppVentiX 3.7.28 release notes

- Fix: Sometimes the AppVentiX agent service could stop unexpectedly on Server 2019 in combination with some MSIX packages, this has been fixed
- Enhancement: A new package option has been introduced for MSIX: After stage actions. After stage actions can be used to execute commands after the MSIX package has been staged on the machine. For example this can be used to install the Teams meeting add-in for Office which is included in the new Teams MSIX package. When importing the latest Teams version in AppVentiX (using the Microsoft Store import button), the after stage actions are automatically configured to install the add-in and disable automatic updates.
- Enhancement: When a newer version of a package is published for a user and a publishing task is executed for an older version, the publishing task will be skipped. When a downgrade of a package is required the force close option can be used in the publishing task to force the old version to be published over the newer version.
- Enhancement: The AppVentiX PowerShell module has been updated and improved for both MSIX and App-V. Check the module help for additional information and examples how to use the module.

---

*Source: [AppVentiX release history](https://appventix.com/appventix-release-history/).*
