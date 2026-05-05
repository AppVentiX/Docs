# Supported Operating Systems

## AppVentiX Agent

The following operating systems are supported by the AppVentiX agent:

- Windows Server 2016 (64-bit)
- Windows Server 2019 (64-bit) (App-V and MSIX client are embedded in Server 2019)
- Windows Server 2022 (64-bit) (App-V and MSIX client are embedded in Server 2022)
- Windows Server 2025 (64-bit) (App-V and MSIX client are embedded in Server 2025)
- Windows 7, 10 and 11 (64-bit) (App-V and MSIX client are embedded in Win10/11)

## AppVentiX Central View Console

The following operating systems are supported by the AppVentiX Central View console:

- Windows Server 2019 (64-bit)
- Windows Server 2022 (64-bit)
- Windows Server 2025 (64-bit)
- Windows 10 (64-bit)
- Windows 11 (64-bit)

## .NET Requirement

For all AppVentiX components you need at least .NET 4.8.

![Supported OS overview](images/supported-os/supported-os-01.png)

## MSIX and App Attach Compatibility

Please check the MSIX and MSIX App Attach compatibility with the OS you are using:

- App Attach is currently only supported in Windows 10 Build 2004 and up
- MSIX Shared Containers are only supported on Windows 10 Build 21x and up

---

## Upgrade from an Earlier Version of AppVentiX

The upgrade from an earlier AppVentiX version to the latest version is straightforward. The components are upgraded in place (no need to uninstall first). Before upgrading, create a copy/backup of the configuration store.

Upgrade the Central View console first, then the agents. The version of the agent is always 1 major version backward compatible with the Central View console. This means you do not have to upgrade all agents at once, but it is recommended to keep this period as short as possible.
