# Add-AppVentiXPackage

Adds an App-V or MSIX package to an AppVentiX machine group content share.

## Syntax

```powershell
Add-AppVentiXPackage
    -PackageFilename <String>
    [-MachineGroupFriendlyName <String>]
    [-ContentShare <String>]
    [<CommonParameters>]
```

## Description

The `Add-AppVentiXPackage` function adds an App-V (.appv) or MSIX (.msix) package to an AppVentiX machine group's content share. It validates the package file, checks licensing, manages machine group associations, and copies the package to the appropriate content share location.

The function performs the following operations:
- Validates that the package file exists and has a supported extension (.appv or .msix)
- Verifies that AppVentiX is properly licensed
- Retrieves the specified machine group configuration
- Validates the content share configuration (handles single or multiple content shares)
- Extracts package metadata from the manifest
- Creates a destination folder and copies the package to the content share

## Parameters

### -PackageFilename

Specifies the full path to the App-V or MSIX package file to add. The file must exist and have either a .appv or .msix extension.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -MachineGroupFriendlyName

Specifies the friendly name of the machine group to which the package will be added. This parameter has aliases: MachineGroup, FriendlyName.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -ContentShare

Specifies the content share path when the machine group has multiple content shares defined. This parameter is required when the machine group has more than one content share. If omitted and only one content share exists, that content share will be used automatically.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

## Examples

### Example 1: Add an MSIX package to a machine group

```powershell
Add-AppVentiXPackage -PackageFilename "C:\Packages\MyApp_1.0.0.0_x64.msix" -MachineGroupFriendlyName "Production"
```

Adds the MSIX package to the Production machine group's content share (assuming the machine group has only one content share defined).

### Example 2: Add an App-V package to a specific content share

```powershell
Add-AppVentiXPackage -PackageFilename "C:\Packages\MyApp.appv" -MachineGroupFriendlyName "Development" -ContentShare "\\server\dev-packages"
```

Adds the App-V package to the Development machine group's specific content share when multiple content shares are defined.

### Example 3: Add a package using the MachineGroup alias

```powershell
Add-AppVentiXPackage -PackageFilename "C:\Packages\Office365_16.0.12345.msix" -MachineGroup "All"
```

Adds the Office 365 MSIX package to the "All" machine group using the MachineGroup alias parameter.

## Notes

- Requires a valid AppVentiX license
- Supported package extensions: .appv and .msix
- If the machine group has multiple content shares, the -ContentShare parameter must be specified
- A destination folder is created automatically based on the package name from the manifest

## Related Links

- [Get-AppVentiXMachineGroup](Get-AppVentiXMachineGroup.md)
- [Get-AppVentiXContentSharePackages](Get-AppVentiXContentSharePackages.md)
- [New-AppVentiXPublishingTask](New-AppVentiXPublishingTask.md)
