# AppVentiX 3.8.24 release notes

- The content inventory is now cached, resulting in significantly faster inventory times
- The content inventory cache is retained after the console is closed and reopened
- Unpublishing unmanaged packages now occurs after the publishing of new packages
- Updated App-V deployment configuration files are processed automatically, eliminating the need to remove and add the package again
- Updated App-V user configuration files are also processed automatically
- App-V global publishing tasks can now also be used to seamlessly publish as RemoteApp
- It is now possible to copy the icon for seamless publishing scenarios when AVD integration is not enabled
- Multiple AVD integration improvements, including authentication enhancements and publishing of App-V and MSIX applications to AVD
- App attach disks created by AppVentiX now include the package name as the label for easy recognition when mounted on a machine
- Teams import and deployment optimizations have been made, including improved automatic installation of the meetings add-in
- General improvements to the MSIX deployment mechanism
- When pre-cache is enabled for a content share, older versions of a package are no longer pre-cached if a newer version exists
- When the refresh timer is configured it's now possible to select which part of the refresh cycle to execute (user refresh, cache refresh or both)
- The refresh cycle can now be triggered in four ways: remotely via the Central View console, using the AppVentiX Agent GUI, on a configured time interval, or through PowerShell. Additionally, it is now possible to invoke both parts of the refresh cycle independently using PowerShell, allowing for user refresh, cache refresh, or both. The admin guide includes the PowerShell commands for these operations.
- Optimizations have been made for offline scenarios, with user publishing now automatically skipped when the refresh timer is triggered
- Improvements in converting App-V to the MSIX format
- Enhancements to the MSIX certificate creation process and it is now possible to import the certificate to the local certification store for easy selection
- Fixed an issue where MSIX packages could be removed from the machine automatically
- Optimizations for MSIX deployment and management on multi-session operating systems
- The setting "Only execute publishing tasks for packages on a configured content share for the machine group" is now enabled by default
- Improvements to the AppVentiX PowerShell module
- Optimizations to the AppVentiX Agent event log
- Various additional fixes and enhancements

Upcoming new features:

We plan to release AppVentiX version 4.0 later this year. This release will include features such as the ability to create and manage shortcuts, enhanced machine inventory caching, and much more! The AppVentiX story AppVentiX is a lightweight powerful management and deployment solution for App-V, MSIX (app attach) and FSlogix app masking, AppVentiX makes it incredibly simple and straight forward to deploy and update Microsoft application packages in your environment. AppVentiX also allows customers to manage App-V and MSIX side by side and helps with the journey from App-V to MSIX.

AppVentiX supports the management of App-V and MSIX (app attach) on virtual machines and physical machines. No matter if they run in the cloud or on-premises. Both Server OS, Multi-session OS and Single-session OS are supported by AppVentiX.

AppVentiX supports customers no matter if they are running on-premises, in the cloud or hybrid, by supporting all hybrid uses cases AppVentiX helps customers when they want to move from on-premises to cloud and from App-V to MSIX, in a pace that fits the customer.

---

*Source: [AppVentiX release history](https://appventix.com/appventix-release-history/).*
