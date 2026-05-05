# New-AppVentiXConnectionGroup

Creates a new App-V Connection Group XML file (.appg) from specified App-V packages.

## Syntax

```powershell
New-AppVentiXConnectionGroup
    -Packages <PSCustomObject[]>
    [-ConnectionGroupName <String>]
    [-MachineGroupFriendlyName <String>]
    [-ContentShare <String>]
    [-Priority <Int32>]
    [<CommonParameters>]
```

## Description

The `New-AppVentiXConnectionGroup` function creates a new App-V Connection Group XML file (.appg) from a specified collection of App-V packages. Connection Groups allow multiple virtual applications to interact with each other in the same virtual environment.

The function validates each package, extracts manifest information, and generates the connection group file in the appropriate content share for the specified machine group or a custom content share location.

If `ConnectionGroupName` is provided without a "CG_" prefix, the prefix is added automatically. If no name is provided, a name is generated from the included package names and versions.

## Parameters

### -Packages

An array of PSCustomObject items representing the packages to include in the connection group. Each object must have the following properties:
- **Path**: The full path to the .appv package file (must exist)
- **Optional**: Boolean indicating if the package is optional in the connection group
- **AnyVersion** (optional): Boolean indicating if any version of the package is acceptable

| | |
|---|---|
| Type: | PSCustomObject[] |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -ConnectionGroupName

The name of the connection group. A "CG_" prefix is added automatically if not present. If not specified, a name is generated from the included packages.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -MachineGroupFriendlyName

The friendly name of the machine group where the connection group file will be created. When set to 'All Machine Groups', the ContentShare parameter must be specified.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | All Machine Groups |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -ContentShare

The path to the content share where the connection group file will be saved. Required when MachineGroupFriendlyName is 'All Machine Groups'.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -Priority

The priority of the connection group. Lower numbers indicate higher priority when resolving conflicts.

| | |
|---|---|
| Type: | Int32 |
| Position: | Named |
| Default value: | 10 |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

## Examples

### Example 1: Create a connection group for a machine group

```powershell
$packages = @(
    [PSCustomObject]@{ Path = "\\fileserver.domain.local\content\App1\App1.appv"; Optional = $false },
    [PSCustomObject]@{ Path = "\\fileserver.domain.local\content\App2\App2.appv"; Optional = $true }
)
New-AppVentiXConnectionGroup -Packages $packages -MachineGroupFriendlyName "Production"
```

Creates a connection group containing App1 (required) and App2 (optional) for the Production machine group.

### Example 2: Create a high-priority connection group with AnyVersion

```powershell
$packages = @(
    [PSCustomObject]@{ Path = "\\fileserver.domain.local\content\Office\Office.appv"; Optional = $false; AnyVersion = $true },
    [PSCustomObject]@{ Path = "\\fileserver.domain.local\content\Plugin\Plugin.appv"; Optional = $false }
)
New-AppVentiXConnectionGroup -Packages $packages -MachineGroupFriendlyName "Development" -Priority 5
```

Creates a high-priority connection group where any version of Office can be used with a specific Plugin version.

## Notes

- Requires a valid AppVentiX license
- Only .appv packages are supported; .msix packages cannot be part of connection groups
- If the machine group has multiple content shares, the first one is used automatically with a warning
- The output object contains Name, GroupId, VersionId, and Path properties

## Related Links

- [New-AppVentiXPublishingTask](New-AppVentiXPublishingTask.md)
- [Get-AppVentiXMachineGroup](Get-AppVentiXMachineGroup.md)
- [Import-AppVManagementConnectionGroup](Import-AppVManagementConnectionGroup.md)
