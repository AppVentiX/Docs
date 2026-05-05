# Get-AppVentiXLicence

Retrieves the details of the AppVentiX license.

## Syntax

```powershell
Get-AppVentiXLicence
    [<CommonParameters>]

Get-AppVentiXLicence
    -Filename <FileInfo>
    [<CommonParameters>]
```

## Description

The `Get-AppVentiXLicence` function retrieves the details of the AppVentiX license. It can retrieve the license details from a specified license file or from the default configuration share. The function returns license information including the licensed organization, expiry date, license type, and assigned machines.

If the license is a trial license, a warning is displayed indicating the trial expiry date.

## Parameters

### -Filename

Specifies the full path to the AppVentiX license file (.lic). The file name must end with 'AppVentiX.lic'. Has aliases: File, License.

| | |
|---|---|
| Type: | FileInfo |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

## Examples

### Example 1: Retrieve license details from the default configuration share

```powershell
Get-AppVentiXLicence
```

Retrieves the license details from the currently configured AppVentiX configuration share.

### Example 2: Retrieve license details from a specific file

```powershell
Get-AppVentiXLicence -Filename "C:\Temp\AppVentiX.lic"
```

Retrieves license details from the specified license file.

### Example 3: Retrieve license details from a configuration share

```powershell
Get-AppVentiXLicence -ConfigShare "\\fileserver.lab.local\config"
```

Retrieves the license details from the specified configuration share.

## Notes

- The license file must be named 'AppVentiX.lic'
- Trial licenses display a warning with the expiry date
- License properties returned: LicensedTo, Email, LicensedOn, LicensedUntil, Type, LicensedMachines, OrderNo

## Related Links

- [Test-AppVentiXIsLicensed](Test-AppVentiXIsLicensed.md)
- [Update-AppVentixLicense](Update-AppVentixLicense.md)
- [Set-AppVentiXConfigShare](Set-AppVentiXConfigShare.md)
