# Get-AppVentiXConfigShare

Retrieves the AppVentiX configuration share if defined.

## Syntax

```powershell
Get-AppVentiXConfigShare
    [<CommonParameters>]
```

## Description

The `Get-AppVentiXConfigShare` function retrieves the AppVentiX configuration share path from the current session. It checks the module session variable first, and if not set, attempts to read it from the Central View Settings file or global/script-scoped variables.

If the configuration share requires specified credentials for authentication (as indicated by the Central View Settings file), the function will warn if the share is not accessible under the current user context.

## Parameters

This function has no parameters.

## Examples

### Example 1: Retrieve the current configuration share

```powershell
Get-AppVentiXConfigShare
```

Returns the currently configured AppVentiX configuration share path as a PSCustomObject with a ConfigShare property.

## Notes

- If the configuration share has not been set, a warning is displayed and the function returns null
- Use `Set-AppVentiXConfigShare` to configure the configuration share path
- If the share requires explicit credentials, use `Set-AppVentiXADCredential -AuthenticateConfigShare` first

## Related Links

- [Set-AppVentiXConfigShare](Set-AppVentiXConfigShare.md)
- [Set-AppVentiXADCredential](Set-AppVentiXADCredential.md)
