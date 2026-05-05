# Set-AppVentiXADCredential

Sets Active Directory credentials used by AppVentiX for AD group lookups.

## Syntax

```powershell
Set-AppVentiXADCredential
    [-Credential <PSCredential>]
    [-Server <String>]
    [-Port <Int32>]
    [-AuthenticateConfigShare]
    [<CommonParameters>]
```

## Description

The `Set-AppVentiXADCredential` function configures the Active Directory credentials that AppVentiX uses when performing AD group lookups. The credentials are stored in the current session and used for subsequent AD queries. Optionally, the credentials can also be applied to authenticate the AppVentiX configuration store.

## Parameters

### -Credential

A PSCredential object containing the username and password for AD authentication. If not specified, the current user's credentials are used.

| | |
|---|---|
| Type: | PSCredential |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -Server

The Active Directory server (domain controller) to connect to. If not specified, the default domain controller is used.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -Port

The LDAP port to use when connecting to Active Directory.

| | |
|---|---|
| Type: | Int32 |
| Position: | Named |
| Default value: | 389 |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -AuthenticateConfigShare

When specified, the provided credentials are also used to authenticate access to the AppVentiX configuration store.

| | |
|---|---|
| Type: | SwitchParameter |
| Position: | Named |
| Default value: | False |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

## Examples

### Example 1: Set AD credentials for the current session

```powershell
$cred = Get-Credential
Set-AppVentiXADCredential -Credential $cred
```

Prompts for credentials and stores them for AD lookups in the current session.

### Example 2: Set credentials with a specific domain controller

```powershell
$cred = Get-Credential -UserName "DOMAIN\svc-appventix"
Set-AppVentiXADCredential -Credential $cred -Server "dc01.domain.local" -AuthenticateConfigShare
```

Sets AD credentials pointing to a specific domain controller and uses the same credentials to access the configuration store.

### Example 3: Set a different domain and connect with current credentials

```powershell
Set-AppVentiXADCredential -Server "dc02.domain2.local" [-Port 636]
```

Configures the specified domain controller as the default server for Active Directory lookups in the current session.

### Example 4: User environment variables to set AD details and/or credentials

```powershell
$Env:AppVentiXADDomainServer = "dc01.domain.local"
$Env:AppVentiXADDomainPort = 636
$Env:AppVentiXConfigShareUsername = "DOMAIN\svc-appventix"
$Env:AppVentiXConfigSharePassword = "Sup3rS3cretP@$$w0rd!"

Import-Module -Name AppVentiX
```

If one or more of these environment variables are set before importing the AppVentiX module, their values will be applied automatically during your session.

## Notes

- Credentials are stored in session variables and are not persisted between sessions
- Use `Clear-AppVentiXADCredential` to remove stored credentials from the current session

## Related Links

- [Clear-AppVentiXADCredential](Clear-AppVentiXADCredential.md)
- [Set-AppVentiXConfigShare](Set-AppVentiXConfigShare.md)
- [Set-AppVentiXUserSettingsAssignment](Set-AppVentiXUserSettingsAssignment.md)
