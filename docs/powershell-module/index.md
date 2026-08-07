# AppVentiX PowerShell Module

The AppVentiX PowerShell module provides command-line tooling for managing and publishing packages (App-V, MSIX, App Attach) and user settings (drive mappings, shortcuts, registry keys, environment variables, and more), and for integrating AppVentiX into automated workflows.

## Prerequisites

- Windows PowerShell 5.1 or later
- Valid AppVentiX license

## Installing the Module

```powershell
# Install the latest module from the PowerShell Gallery
Install-Module -Name AppVentiX -Force

# Import the module
Import-Module AppVentiX
```

## Connecting to the Configuration Store

Before using the module, a connection must be made to the configuration store. When the AppVentiX PowerShell module is installed on the same machine as the AppVentiX Central Management Console, it will automatically detect the configuration store when configured correctly.

You can also configure the share manually if auto-detection does not succeed, or when running from a different machine:

```powershell
# Set the configuration store path (not needed if detected automatically)
Set-AppVentiXConfigShare -Path "\\fileserver.domain.com\config$"
```

If credentials are required to connect to the configuration store:

```powershell
$Credential = Get-Credential -Message "Enter AppVentiX Configuration Store credentials"
$ConfigShare = "\\fileserver.domain.local\config$"
Set-AppVentiXConfigShare -ConfigShare $ConfigShare -Credential $Credential
```

## Environment Variables

In some situations it may be necessary to provide credentials and connection details before importing the module. You can do this by setting environment variables:

```powershell
# Config share details
$Env:AppVentiXConfigShare         = "\\domain.local\AppVentiX\Config" # Override automatic detection
$Env:AppVentiXConfigShareUsername = "DOMAIN\AppVentiXUser"            # Username if required (e.g. "DOMAIN\User" or "user@domain.local")
$Env:AppVentiXConfigSharePassword = "P@ssw0rd"                        # Password for the specified username

#Optional when there are multiple sites and run on Machine where AppVentiX Central View is installed.
#The $Env:AppVentiXConfigShare takes precedence over this variable if configured.
$Env:AppVentiXSiteName = "Site A"                                     # Name of the Site configured in AppVentiX Central View

# Active Directory details
$Env:AppVentiXADDomainServer      = "lab-dc-001.lab.local"            # Domain controller hostname
$Env:AppVentiXADDomainPort        = 389                               # Port if not the default (389)
$Env:AppVentiXADDomainUsername    = "DOMAIN\AppVentiXUser"            # Username if required
$Env:AppVentiXADDomainPassword    = "P@ssw0rd"                        # Password for the specified username
```

## Verifying the License

```powershell
Test-AppVentiXIsLicensed
```

## Next Steps

See the [Command Reference](commands/index.md) for a full overview of all available commands, organized by category.

---

*Copyright (c) AppVentiX*
