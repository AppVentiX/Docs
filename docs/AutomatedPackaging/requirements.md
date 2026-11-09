# Requirements

Host preparation checks the host for all of the items below. It also tells you which items it can fix. The values in the table are the values that the checks use.

## The host

| Requirement | Detail |
|---|---|
| Windows edition | An edition with Hyper-V: Pro, Enterprise, Education or Business. Windows Home is refused |
| Hardware virtualization | VT-x or AMD-V, on in the firmware. No software can turn it on for you |
| Hyper-V role | `Microsoft-Hyper-V-All`. Host preparation can turn it on. The host then restarts |
| Memory | 16 GB minimum, 32 GB recommended. A worker uses 8 GB of static memory |
| Worker volume | NTFS or ReFS. At least 60 GB free for one worker, 200 GB recommended for more. Between the two, host preparation shows a warning. exFAT and FAT32 are refused |
| BitLocker | If the system drive is encrypted and Hyper-V is still off, suspend BitLocker for one restart. Or keep the recovery key available |
| Runtimes | .NET 10 Desktop Runtime (x64) and ASP.NET Core 10 Runtime (x64). The installer stops without them |
| Rights | A local administrator. The application and host preparation run elevated |
| ADK Deployment Tools | Necessary to prepare Windows media (`oscdimg`). Host preparation can download and install them |

VMware PowerCLI and VMware Workstation on the same host give a warning, not a refusal.

## What you supply

The product ships no Microsoft binaries. This is a licensing decision.

| What | How many | Where to get it |
|---|---|---|
| Windows installation ISO | One for each Windows release that you want a worker for | Volume Licensing, Visual Studio subscriptions (MSDN), or an OEM channel |
| Features on Demand ISO | One for each release. Only this ISO installs the capture driver. A standalone driver `.cab` file does not work (`0x800f0818`) | Volume Licensing |
| MSIX Packaging Tool offline bundle, **and its licence file** | One copy for the host | Microsoft's page [MSIX Packaging Tool in a disconnected environment](https://learn.microsoft.com/windows/msix/packaging-tool/disconnected-environment) |
| `adksetup.exe` | One | Microsoft's ADK download. Host preparation can download it for you |
| A code signing certificate | One | Your certificate authority, Azure Artifact Signing, or a test certificate that the product makes |

For Windows 11, Microsoft also publishes the Features on Demand ISO as a direct download. The product does not download it for you:

| Release | Features on Demand ISO |
|---|---|
| Windows 11 24H2 and 25H2 (build 26100) | [26100.1.240331-1435.ge_release_amd64fre_CLIENT_LOF_PACKAGES_OEM.iso](https://software-static.download.prss.microsoft.com/dbazure/888969d5-f34g-4e03-ac9d-1f9786c66749/26100.1.240331-1435.ge_release_amd64fre_CLIENT_LOF_PACKAGES_OEM.iso), about 6.3 GB |
| Windows 11 22H2 (build 22621) | [22621.1.220506-1250.ni_release_amd64fre_CLIENT_LOF_PACKAGES_OEM.iso](https://software-static.download.prss.microsoft.com/dbazure/988969d5-f34g-4e03-ac9d-1f9786c66749/22621.1.220506-1250.ni_release_amd64fre_CLIENT_LOF_PACKAGES_OEM.iso), about 7.2 GB |

## Supported Windows releases

The product creates one drop folder for each supported release:

| Release folder | Worker |
|---|---|
| `Windows10-22H2` | Windows 10 22H2 |
| `Windows11-22H2` | Windows 11 22H2 |
| `Windows11-24H2` | Windows 11 24H2 |
| `Windows11-25H2` | Windows 11 25H2 |
| `Server2025` | Windows Server 2025 |

Windows Server 2022 cannot be a worker. Microsoft publishes no capture driver for build 20348.

Releases in the same servicing branch use the same Features on Demand media. For example, 24H2 and 25H2 are both build 26100. Put a copy of the ISO in each drop folder.
