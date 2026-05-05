# Clear-AppVentiXADCredential

Clears Active Directory credentials from the current PowerShell session.

## Syntax

```powershell
Clear-AppVentiXADCredential
    [<CommonParameters>]
```

## Description

The `Clear-AppVentiXADCredential` function removes previously set Active Directory credentials from the current PowerShell session. It resets the PSDefaultParameterValues for all ADSI Active Directory functions by:
- Setting the Credential to an empty PSCredential object
- Resetting the Port to the default LDAP port (389)
- Clearing the Server parameter

This function is useful when you need to revert to default authentication behavior or when switching between different AD environments. After calling this function, ADSI AD operations will use the current user's credentials and default connection settings.

## Parameters

This function has no parameters.

## Examples

### Example 1: Clear all Active Directory credentials

```powershell
Clear-AppVentiXADCredential
```

Clears all Active Directory credentials and connection settings from the current session.

### Example 2: Set credentials, perform operations, then clear

```powershell
Set-AppVentiXADCredential -Credential (Get-Credential) -Server "dc01.domain.local"
# Perform some AD operations...
Clear-AppVentiXADCredential
```

Sets AD credentials for a specific domain controller, performs operations, then clears the credentials to revert to default behavior.

### Example 3: Clear credentials with verbose output

```powershell
Clear-AppVentiXADCredential -Verbose
```

Clears AD credentials with verbose output showing the clearing process.

## Notes

- This function clears both the in-session PSDefaultParameterValues and the related environment variables
- Always call this function when finished with AD operations that required explicit credentials
- As an alternative, restarting the PowerShell session will also clear stored credentials

## Related Links

- [Set-AppVentiXADCredential](Set-AppVentiXADCredential.md)
