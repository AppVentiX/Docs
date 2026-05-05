# Set-AppVentiXConfigShare

Sets the AppVentiX configuration store path for the current session.

## Syntax

```powershell
# Parameter Set: Default
Set-AppVentiXConfigShare
    -ConfigShare <String>
    [-WhatIf]
    [-Confirm]
    [<CommonParameters>]

# Parameter Set: Credential
Set-AppVentiXConfigShare
    -ConfigShare <String>
    -Credential <PSCredential>
    [-WhatIf]
    [-Confirm]
    [<CommonParameters>]
```

## Description

The `Set-AppVentiXConfigShare` function sets the path to the AppVentiX configuration store. All subsequent AppVentiX cmdlets in the session use this configuration store path. Optionally, credentials can be provided to authenticate access to the share.

## Parameters

### -ConfigShare

The UNC path or local path to the AppVentiX configuration store.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -Credential

A PSCredential object used to authenticate access to the configuration store. Required when accessing a share that requires different credentials from the current user.

| | |
|---|---|
| Type: | PSCredential |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -WhatIf

Shows what would happen if the command runs without actually changing the configuration store.

| | |
|---|---|
| Type: | SwitchParameter |
| Position: | Named |
| Default value: | False |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -Confirm

Prompts for confirmation before changing the configuration store.

| | |
|---|---|
| Type: | SwitchParameter |
| Position: | Named |
| Default value: | False |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

## Examples

### Example 1: Set the configuration store

```powershell
Set-AppVentiXConfigShare -ConfigShare "\\fileserver.domain.local\config"
```

Sets the AppVentiX configuration store for the current session.

### Example 2: Set the configuration store with credentials

```powershell
$cred = Get-Credential
Set-AppVentiXConfigShare -ConfigShare "\\fileserver.domain.local\config" -Credential $cred
```

Sets the configuration store and authenticates with the provided credentials.

## Notes

- The configuration store path is stored in the current session and must be set each session unless a default is configured
- Use `Get-AppVentiXConfigShare` to view the currently configured share path

## Related Links

- [Get-AppVentiXConfigShare](Get-AppVentiXConfigShare.md)
- [Set-AppVentiXADCredential](Set-AppVentiXADCredential.md)
- [Test-AppVentiXIsLicensed](Test-AppVentiXIsLicensed.md)
