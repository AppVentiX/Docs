# Update-AppVentixLicense

Applies a new AppVentiX license file to the configuration share.

## Syntax

```powershell
Update-AppVentixLicense
    -LicenseFilename <String>
    [-Force]
    [<CommonParameters>]
```

## Description

The `Update-AppVentixLicense` function installs or updates the AppVentiX license by copying the specified license file to the AppVentiX configuration share. Use the `-Force` parameter to overwrite an existing license without confirmation.

## Parameters

### -LicenseFilename

The full path to the AppVentiX license file to install.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -Force

When specified, overwrites the existing license file without prompting for confirmation.

| | |
|---|---|
| Type: | SwitchParameter |
| Position: | Named |
| Default value: | False |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

## Examples

### Example 1: Install a new license

```powershell
Update-AppVentixLicense -LicenseFilename "C:\Licenses\AppVentiX.lic"
```

Installs the specified license file into the AppVentiX configuration share.

### Example 2: Overwrite an existing license

```powershell
Update-AppVentixLicense -LicenseFilename "C:\Licenses\AppVentiX_Renewed.lic" -Force
```

Overwrites the existing license with the renewed license file without prompting.

### Example 3: Install a new license on a specific configuration share

```powershell
Update-AppVentixLicense -LicenseFilename "C:\Licenses\AppVentiX_Renewed.lic" -ConfigShare '\\fileserver.domain.local\config'
```

Installs the license on the specified configuration share.

## Notes

- Requires write access to the AppVentiX configuration share
- After updating the license, use `Test-AppVentiXIsLicensed` to verify the new license is valid
- The actual function name in the module is `Update-AppVentiXLicence` (British spelling)

## Related Links

- [Test-AppVentiXIsLicensed](Test-AppVentiXIsLicensed.md)
- [Get-AppVentiXLicence](Get-AppVentiXLicence.md)
- [Set-AppVentiXConfigShare](Set-AppVentiXConfigShare.md)
