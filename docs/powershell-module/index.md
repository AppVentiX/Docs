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
Set-AppVentiXConfigShare -ConfigShare "\\fileserver.domain.com\config$"
```

If credentials are required to connect to the configuration store:

```powershell
$Credential = Get-Credential -Message "Enter AppVentiX Configuration Store credentials"
$ConfigShare = "\\fileserver.domain.local\config$"
Set-AppVentiXConfigShare -ConfigShare $ConfigShare -Credential $Credential
```

### Azure Blob Configuration Store

When the configuration store is hosted in an Azure Storage account, the path has the format `azure://<storage account>/<container>`. Instead of a credential, you sign in once with `Connect-AppVentiXAzure` (see [Signing in to Azure](#signing-in-to-azure)):

```powershell
# Sign in to the Azure Blob configuration store
Connect-AppVentiXAzure -ConfigShare "azure://appventix/publishing"

# Use the store for this and later sessions
Set-AppVentiXConfigShare -ConfigShare "azure://appventix/publishing"
```

The account or app registration you sign in with needs data access to the storage account, for example the **Storage Blob Data Contributor** role. The `-Credential` parameter of `Set-AppVentiXConfigShare` is ignored for an Azure Blob store.

### Central View Sites

AppVentiX Central View can manage multiple sites, each with its own configuration store. On the machine where Central View is installed, the module reads the Central View settings and can switch between these sites.

```powershell
# List all sites configured in Central View
Get-AppVentiXSite

# Get one site by name or GUID
Get-AppVentiXSite -Name "Customer B"
Get-AppVentiXSite -SiteGuid "684552ee-7c5c-4e4a-b2b6-6597a6e24bda"
```

Each site shows its `SiteName`, `Configurationshare` (the configuration store path), `SiteGuid`, `StorageMode` and `ShareAuthenticationmode`.

To work with a specific site, select it with `Set-AppVentiXSite`:

```powershell
# Select a site by name
Set-AppVentiXSite -Name "Customer B"

# Select a site from the pipeline
Get-AppVentiXSite | Where-Object SiteName -EQ "Azure" | Set-AppVentiXSite

# Select the default site
Set-AppVentiXSite
```

`Set-AppVentiXSite` sets the configuration store of that site with `Set-AppVentiXConfigShare`, so the choice is also remembered for later sessions. When the site uses an Azure Blob configuration store, sign in first with `Connect-AppVentiXAzure`.

The default site is the site without a `SiteGuid`. If there is no such site, the module uses the oldest Central View settings file.

To check which configuration store is active:

```powershell
Get-AppVentiXConfigShare
```

### How the Configuration Store is Selected

When the module is imported, it picks the configuration store in this order:

1. `$Env:AppVentiXConfigShare`, when set.
2. `$Env:AppVentiXSiteName`, the Central View site with that name. An unknown name shows a warning and the module continues with the next step.
3. The store saved earlier with `Set-AppVentiXConfigShare` or `Set-AppVentiXSite`.
4. The default Central View site. When Central View has more than one site, the module shows a warning that it selected the default site.

## Signing in to Azure

The module signs in to Azure with Entra ID for two things: an Azure Blob configuration store, and looking up Entra ID groups (also when your configuration store is on a file share). Sign in once with `Connect-AppVentiXAzure`. The sign-in is cached per Windows user (encrypted with Windows DPAPI) in `%LOCALAPPDATA%\AppVentiX\TokenCache`, so later sessions connect silently.

This sign-in is separate from AppVentiX Central View. Signing in to Central View does not sign in the module, and the other way around. The earlier name of this command, `Connect-AppVentiXAzureBlobStore`, still works.

`Connect-AppVentiXAzure` supports these sign-in methods:

- **Device code**, the default. Works for most interactive use.
- **Azure CLI or Azure PowerShell**, reusing `az login` or `Connect-AzAccount`. Use this when your organization blocks device code sign-in, or when you need to choose the tenant.
- **App registration** with a client secret, for scheduled tasks and other scripts that run without a user.

### Device code

```powershell
# Sign in with a device code
Connect-AppVentiXAzure

# Sign in again, for example with a different account
Connect-AppVentiXAzure -ForceLogin
```

`Connect-AppVentiXAzure` shows a code and a URL. Open the URL in a browser, enter the code and sign in. You only need to sign in again when the cached sign-in can no longer be refreshed.

The device code sign-in always uses the home tenant of your account. If you are a guest in the tenant that holds the storage account or the groups, use the Azure CLI or Azure PowerShell and choose the tenant there.

### Azure CLI or Azure PowerShell

Many organizations block device code sign-in with Conditional Access. In that case, sign in with the Azure CLI or the Az PowerShell module, and let the module reuse that sign-in:

```powershell
# Reuse an Azure CLI sign-in
az login --tenant contoso.onmicrosoft.com
Connect-AppVentiXAzure -UseAzureCli

# Reuse an Azure PowerShell sign-in (requires the Az.Accounts module)
Connect-AzAccount -Tenant contoso.onmicrosoft.com
Connect-AppVentiXAzure -UseAzPowerShell
```

Things to know:

- The module remembers which tool you used and asks that tool for a new token when needed. Your Azure CLI or Azure PowerShell credentials are not stored by the module.
- The tool must stay signed in. After `az logout` or `Disconnect-AzAccount`, the module shows a warning. Sign in to the tool again and run `Connect-AppVentiXAzure` with the same parameter.
- When Azure PowerShell context autosave is disabled (`Disable-AzContextAutosave`), the Az sign-in only lasts for the current PowerShell session.

### App registration

For scheduled tasks and other unattended scripts, sign in with the client ID and a client secret of an app registration:

```powershell
# Sign in with an app registration
$ClientSecret = Read-Host -Prompt "Enter the client secret" -AsSecureString
Connect-AppVentiXAzure -TenantId "contoso.onmicrosoft.com" -ClientId "00000000-0000-0000-0000-000000000000" -ClientSecret $ClientSecret
```

The app registration needs the **Storage Blob Data Contributor** role on the storage account for an Azure Blob configuration store, and the Microsoft Graph application permission **Group.Read.All** (with admin consent) for Entra ID groups.

The client ID and secret are cached for the Windows user that runs the command, so for a scheduled task, run `Connect-AppVentiXAzure` once as the account that runs the task. When the secret expires, the module shows a warning. Create a new secret and run `Connect-AppVentiXAzure` again.

### Switching sign-in methods

Running `Connect-AppVentiXAzure` without parameters keeps the current cached sign-in, whatever method it was made with. To switch, run it with the parameters of the new method, or with `-ForceLogin` for a new device code sign-in. The new sign-in replaces the cached one.

### When the sign-in does not work

- **"Access blocked" or `AADSTS53003` during the device code sign-in.** Conditional Access blocks device code sign-in. Use the Azure CLI, Azure PowerShell or an app registration instead.
- **403 `AuthorizationPermissionMismatch` on the configuration store.** The sign-in worked, but the account or app registration has no data access to the storage account. The Owner or Contributor role alone is not enough, assign **Storage Blob Data Contributor**.
- **403 `AuthorizationFailure` on the configuration store.** The storage account firewall or a private endpoint blocks the machine you run the module on. Run the module from a machine with access to the storage account, or allow its network.
- **Groups or the storage account cannot be found.** You are signed in to a different tenant, for example the home tenant of a guest account. Sign in to the right tenant with `az login --tenant` or `Connect-AzAccount -Tenant`.

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

The username and password variables do not apply to an Azure Blob configuration store. Use `Connect-AppVentiXAzure` instead.

## Verifying the License

```powershell
Test-AppVentiXIsLicensed
```

## Using Entra ID Groups

Publishing tasks can be assigned to Entra ID groups, to Active Directory groups, or to a mix of both.

### Requirements

- Entra ID integration must be enabled in AppVentiX Central View ("Enable Entra ID (Azure AD) integration"). Without it, the commands return an error and no task is created or changed.
- The account you sign in with must be able to read groups in Entra ID. An app registration needs the Microsoft Graph application permission **Group.Read.All**.

### Signing in

Entra ID groups are looked up in Microsoft Graph to find their object ID. This uses the same sign-in as the Azure Blob configuration store, and also works when your configuration store is on a file share. Sign in once before you start, with any of the methods in [Signing in to Azure](#signing-in-to-azure):

```powershell
Connect-AppVentiXAzure
```

If you have not signed in at all, the first command that uses an Entra ID group shows a device code and waits until you have signed in. Signing in beforehand is the better choice for scripts. When you signed in with the Azure CLI, Azure PowerShell or an app registration and that sign-in no longer works, the command shows a warning instead of a device code.

The groups are looked up in the tenant you signed in to: the home tenant of your account for a device code sign-in, or the tenant you chose with the Azure CLI, Azure PowerShell or the app registration.

### Creating and changing publishing tasks

Use `-EntraIDGroup` for Entra ID groups and `-ADGroup` for Active Directory groups. `-Group` still works as an alias for `-ADGroup`, so existing scripts keep working.

```powershell
# Entra ID group only
New-AppVentiXPublishingTask -MachineGroupFriendlyName "Entra machines" `
    -EntraIDGroup "AppVentiX - Apps" `
    -Path "azure://appventix/content/Package_1.0.0.0_x64/Package_1.0.0.0_x64.msix"

# Active Directory and Entra ID groups in one task
New-AppVentiXPublishingTask -ADGroup "LAB.LOCAL\AppVentiX Test Machines" `
    -EntraIDGroup "AppVentiX - Apps", "AppVentiX Entra Operators" `
    -Path "\\fileserver.domain.local\content\Package_1.0.0.0_x64\Package_1.0.0.0_x64.msix"

# Replace the groups of an existing task
Set-AppVentiXPublishingTask -Id "bbcd6e36-dbeb-4fc3-9ffd-44388819722e" -EntraIDGroup "AppVentiX - Apps"

# Copy tasks to another machine group and assign them to an Entra ID group
Copy-AppVentiXPublishingTask -MachineGroupFriendlyname "Development" -NewMachineGroupFriendlyname "Entra machines" `
    -NewEntraIDGroup "AppVentiX - Apps"
```

Things to know:

- An Entra ID group can be specified by display name or by object ID. Entra ID allows several groups with the same display name. When that happens the command returns an error, and you can use the object ID instead.
- `Set-AppVentiXPublishingTask` and `Copy-AppVentiXPublishingTask` replace all groups of the task when you specify a new AD or Entra ID group. Specify both parameters to keep a mix.
- When `New-AppVentiXPublishingTask` gets only `-EntraIDGroup`, the default `Everyone` group is not added. Without any group parameter, the task is assigned to `Everyone`.
- With Entra ID integration enabled, the `Everyone` group applies to both AD and Entra ID users.

## Next Steps

See the [Command Reference](commands/index.md) for a full overview of all available commands, organized by category.

---

*Copyright (c) AppVentiX*
