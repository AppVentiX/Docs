# Get-AppVentiXContentSharePackages

Retrieves packages from the AppVentiX content shares.

## Syntax

```powershell
Get-AppVentiXContentSharePackages
    [-IncludeDependencies]
    [<CommonParameters>]

Get-AppVentiXContentSharePackages
    [-MachineGroupFriendlyName <String>]
    [-IncludeDependencies]
    [<CommonParameters>]
```

## Description

The `Get-AppVentiXContentSharePackages` function scans the content shares configured for machine groups and retrieves information about App-V (.appv), MSIX (.msix), and connection group (.appg) packages. It returns package details including name, version, publisher, and connection group membership.

By default, packages located in Dependencies folders are excluded from the results unless the `-IncludeDependencies` switch is used.

## Parameters

### -MachineGroupFriendlyName

Specifies the friendly name of the machine group to retrieve packages from. If not specified, packages from all machine groups are retrieved. Has alias: FriendlyName.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | All Machine Groups |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -IncludeDependencies

When specified, includes packages located in Dependencies folders. By default, dependency packages are excluded from the results.

| | |
|---|---|
| Type: | SwitchParameter |
| Position: | Named |
| Default value: | False |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

## Examples

### Example 1: Retrieve all packages from all machine groups

```powershell
Get-AppVentiXContentSharePackages
```

Retrieves all packages from all machine group content shares.

### Example 2: Retrieve packages from a specific machine group

```powershell
Get-AppVentiXContentSharePackages -MachineGroupFriendlyName 'Production'
```

Retrieves packages from the content shares of the 'Production' machine group.

### Example 3: Include dependency packages

```powershell
Get-AppVentiXContentSharePackages -IncludeDependencies
```

Retrieves all packages including those in Dependencies folders.

## Notes

- Requires a valid AppVentiX license
- CIM and VHD/VHDX package types are not currently supported and will generate warnings
- The returned objects include a MemberOf property listing which connection groups each package belongs to

## Related Links

- [Get-AppVentiXMachineGroup](Get-AppVentiXMachineGroup.md)
- [Add-AppVentiXPackage](Add-AppVentiXPackage.md)
