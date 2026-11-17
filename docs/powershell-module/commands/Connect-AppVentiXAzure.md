---
category: configuration
category_title: Configuration Commands
document type: cmdlet
external help file: AppVentiX-Help.xml
HelpUri: ''
Locale: en-US
Module Name: AppVentiX
module_version: 2026.1117.1700
ms.date: 11-17-2026
PlatyPS schema version: 2024-05-01
title: Connect-AppVentiXAzure
---

# Connect-AppVentiXAzure

## SYNOPSIS

Signs in to Azure with an Entra ID account.

## SYNTAX

### DeviceCode (Default)

```
Connect-AppVentiXAzure [-ConfigShare <string>] [-ForceLogin] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### ClientSecret

```
Connect-AppVentiXAzure -TenantId <string> -ClientId <string> -ClientSecret <securestring>
 [-ConfigShare <string>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### AzPowerShell

```
Connect-AppVentiXAzure -UseAzPowerShell [-ConfigShare <string>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### AzureCli

```
Connect-AppVentiXAzure -UseAzureCli [-ConfigShare <string>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,

## DESCRIPTION

The Connect-AppVentiXAzure function signs in with an interactive Entra ID device-code
sign-in.
The sign-in is used for:
- an Azure Blob Configuration Store, the equivalent of 'Set-AppVentiXConfigShare -Credential'
  for an SMB store;
- the Microsoft Graph lookup of Entra ID groups (-EntraIDGroup), also with an SMB store.

The resulting token is cached DPAPI-encrypted per user, so subsequent sessions pick it up
silently and only need to sign in again once it can no longer be refreshed.

Reads and writes against an Azure Blob store only use the cached token and fail with a
pointer back to this function when none is available.
A command that uses an Entra ID
group prompts for the sign-in itself when needed.
Run this once per machine/user (or
again with -ForceLogin to switch accounts).

When a device code sign-in is not possible, sign in with an app registration instead
(-TenantId, -ClientId and -ClientSecret).
The client id and secret are cached
DPAPI-encrypted per user, so later sessions get a new token silently.
The app registration
needs the 'Storage Blob Data Contributor' role on the storage account for an Azure Blob
store, and the Microsoft Graph application permission 'Group.Read.All' (admin consent)
for Entra ID group lookups.

An existing sign-in of Azure PowerShell (Connect-AzAccount, -UseAzPowerShell) or the
Azure CLI (az login, -UseAzureCli) can be reused instead.
The choice is cached, later
sessions request a new token from the same tool silently, so that tool must stay signed
in.
Sign in to the correct tenant there (e.g.
'az login --tenant contoso.onmicrosoft.com').

This function was named Connect-AppVentiXAzureBlobStore, that name is still available as
an alias.

## EXAMPLES

### EXAMPLE 1

Connect-AppVentiXAzure

Signs in to Azure, for the configured Configuration Store and Entra ID group lookups.

### EXAMPLE 2

Connect-AppVentiXAzure -ConfigShare "azure://appventix/publishing"

Signs in to the Azure Blob Configuration Store "azure://appventix/publishing".

### EXAMPLE 3

Connect-AppVentiXAzure -ForceLogin

Signs in again, for example with a different account.

### EXAMPLE 4

$secret = Read-Host -Prompt 'Client secret' -AsSecureString
Connect-AppVentiXAzure -TenantId 'contoso.onmicrosoft.com' -ClientId '00000000-0000-0000-0000-000000000000' -ClientSecret $secret

Signs in with the client id and secret of an app registration.

### EXAMPLE 5

az login --tenant contoso.onmicrosoft.com
Connect-AppVentiXAzure -UseAzureCli

Reuses the Azure CLI sign-in.

### EXAMPLE 6

Connect-AzAccount -Tenant contoso.onmicrosoft.com
Connect-AppVentiXAzure -UseAzPowerShell

Reuses the Azure PowerShell sign-in.

## PARAMETERS

### -ClientId

Application (client) id of the app registration.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: ClientSecret
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -ClientSecret

Client secret of the app registration, as a SecureString.

```yaml
Type: System.Security.SecureString
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: ClientSecret
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -ConfigShare

Specifies the path to the Configuration Store.
Only used to report what the sign-in is for.
Defaults to the currently configured store.

```yaml
Type: System.String
DefaultValue: $Script:AppVentiX.ConfigShare
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Confirm

Prompts you for confirmation before running the cmdlet.

```yaml
Type: System.Management.Automation.SwitchParameter
DefaultValue: ''
SupportsWildcards: false
Aliases:
- cf
ParameterSets:
- Name: (All)
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -ForceLogin

Ignores any cached token and forces a fresh interactive sign-in.

```yaml
Type: System.Management.Automation.SwitchParameter
DefaultValue: False
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: DeviceCode
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -TenantId

Tenant id or domain name (e.g.
'contoso.onmicrosoft.com') of the app registration.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: ClientSecret
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -UseAzPowerShell

Reuses the sign-in of the Az PowerShell module (Connect-AzAccount).
Requires Az.Accounts.

```yaml
Type: System.Management.Automation.SwitchParameter
DefaultValue: False
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: AzPowerShell
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -UseAzureCli

Reuses the sign-in of the Azure CLI (az login).

```yaml
Type: System.Management.Automation.SwitchParameter
DefaultValue: False
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: AzureCli
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -WhatIf

Runs the command in a mode that only reports what would happen without performing the actions.

```yaml
Type: System.Management.Automation.SwitchParameter
DefaultValue: ''
SupportsWildcards: false
Aliases:
- wi
ParameterSets:
- Name: (All)
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutBuffer, -OutVariable, -PipelineVariable,
-ProgressAction, -Verbose, -WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.Boolean

## RELATED LINKS

- [Set-AppVentiXConfigShare](Set-AppVentiXConfigShare.md)
- [New-AppVentiXPublishingTask](New-AppVentiXPublishingTask.md)
