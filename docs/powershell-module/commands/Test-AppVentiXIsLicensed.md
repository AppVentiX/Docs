# Test-AppVentiXIsLicensed

Tests whether the current AppVentiX installation has a valid license.

## Syntax

```powershell
Test-AppVentiXIsLicensed
    [-ConfigShare <String>]
    [-Force]
    [<CommonParameters>]
```

## Description

The `Test-AppVentiXIsLicensed` function checks whether AppVentiX is licensed by validating the license stored in the configuration store. Returns `$true` if the license is valid, or `$false` if no valid license is found. Use the `-Force` parameter to bypass any cached license validation result and re-check the license.

## Parameters

### -ConfigShare

The path to the AppVentiX configuration store. If not specified, the currently configured configuration store is used.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -Force

When specified, bypasses any cached license validation and forces a fresh validation check.

| | |
|---|---|
| Type: | SwitchParameter |
| Position: | Named |
| Default value: | False |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

## Outputs

**System.Boolean**

Returns `$true` if AppVentiX is licensed, `$false` otherwise.

## Examples

### Example 1: Test if AppVentiX is licensed

```powershell
Test-AppVentiXIsLicensed
```

Returns `$true` or `$false` depending on whether a valid AppVentiX license is present.

### Example 2: Test license with a specific configuration store

```powershell
Test-AppVentiXIsLicensed -ConfigShare "\\fileserver.domain.local\config" -Force
```

Tests the license on the specified configuration store, bypassing any cached result.

### Example 3: Use in a conditional check

```powershell
if (Test-AppVentiXIsLicensed) {
    Write-Host "AppVentiX is licensed. Proceeding..."
} else {
    Write-Warning "AppVentiX is not licensed."
}
```

Checks the license before executing AppVentiX commands.

## Notes

- All AppVentiX functions call this validation internally before executing
- Use `Update-AppVentiXLicense` to apply a new license file

## Related Links

- [Get-AppVentiXLicence](Get-AppVentiXLicence.md)
- [Update-AppVentixLicense](Update-AppVentixLicense.md)
- [Set-AppVentiXConfigShare](Set-AppVentiXConfigShare.md)
