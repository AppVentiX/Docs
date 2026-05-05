# Get-AppVManagementPackage

Retrieves App-V packages with AD access entitlements from the Microsoft App-V Management database.

## Syntax

```powershell
Get-AppVManagementPackage
    [-SQLServer <String>]
    [-SQLInstance <String>]
    [-SQLDatabase <String>]
    [-SQLCredential <PSCredential>]
    [-EnabledOnly]
    [<CommonParameters>]

Get-AppVManagementPackage
    [-SQLServer <String>]
    [-SQLInstance <String>]
    [-SQLDatabase <String>]
    [-SQLCredential <PSCredential>]
    -PackageGuid <Guid>
    [-EnabledOnly]
    [<CommonParameters>]

Get-AppVManagementPackage
    [-SQLServer <String>]
    [-SQLInstance <String>]
    [-SQLDatabase <String>]
    [-SQLCredential <PSCredential>]
    -VersionGuid <Guid>
    [<CommonParameters>]

Get-AppVManagementPackage
    [-SQLServer <String>]
    [-SQLInstance <String>]
    [-SQLDatabase <String>]
    [-SQLCredential <PSCredential>]
    -Name <String>
    [-EnabledOnly]
    [<CommonParameters>]
```

## Description

The `Get-AppVManagementPackage` function queries the App-V Management database to retrieve complete package information including package metadata, version details, and AD entitlements.

Each package includes:
- **DeploymentConfigurationXml**: Global deployment configuration (one per package)
- **ADGroups**: Array of AD entitlements, each with:
  - UserConfigurationXml: The AD group's specific user configuration (if any)
  - DeploymentConfigurationXml: Combined deployment config where the UserConfiguration element from the global deployment config is replaced with this AD group's UserConfiguration (if available)

## Parameters

### -SQLServer

Specifies the SQL Server hostname or IP address.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | localhost |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -SQLInstance

Specifies the SQL Server instance name. If not specified, the default instance will be used.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None (default instance) |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -SQLDatabase

Specifies the App-V Management database name.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | AppVManagement |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -SQLCredential

Specifies the PSCredential object for SQL Server authentication. If not specified, Windows Integrated Authentication will be used.

| | |
|---|---|
| Type: | PSCredential |
| Position: | Named |
| Default value: | None (Windows Authentication) |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -PackageGuid

Retrieves a specific package by its PackageGuid. This can be used to get all versions of a specific package.

| | |
|---|---|
| Type: | Guid |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -VersionGuid

Retrieves a specific package version by its VersionGuid.

| | |
|---|---|
| Type: | Guid |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -Name

Filters packages by name using wildcards (*). For example, "Adobe*" will return all packages starting with "Adobe".

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | True |

### -EnabledOnly

Returns only enabled packages (Enabled = 1).

| | |
|---|---|
| Type: | SwitchParameter |
| Position: | Named |
| Default value: | False |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

## Examples

### Example 1: Retrieve all packages

```powershell
Get-AppVManagementPackage -SQLServer "sql01.domain.local"
```

Retrieves all packages with their AD entitlements from the App-V Management database.

### Example 2: Retrieve packages using SQL Authentication

```powershell
$cred = Get-Credential
Get-AppVManagementPackage -SQLServer "sql01.domain.local" -SQLCredential $cred
```

Retrieves all packages using SQL Server authentication.

### Example 3: Retrieve only enabled packages from a named instance

```powershell
Get-AppVManagementPackage -SQLServer "SQLSRV01" -SQLInstance "INSTANCE01" -EnabledOnly
```

Retrieves only enabled packages from a named SQL Server instance.

### Example 4: Filter packages by name

```powershell
Get-AppVManagementPackage -SQLServer "SQLSRV01" -Name "Adobe*"
```

Retrieves all packages with names starting with "Adobe".

### Example 5: Retrieve a specific package by PackageGuid

```powershell
Get-AppVManagementPackage -SQLServer "SQLSRV01" -PackageGuid "FB4267F4-6B2B-45E1-A55B-0FE9C69A3DC2"
```

Retrieves all versions of a specific package by its PackageGuid with AD entitlements.

## Notes

- Requires the SqlServer PowerShell module
- AD group SIDs are resolved to group names; use `Set-AppVentiXADCredential` if explicit credentials are needed
- Use `Test-AppVManagementSQLConnection` to verify connectivity before querying

## Related Links

- [Get-AppVManagementConnectionGroup](Get-AppVManagementConnectionGroup.md)
- [Import-AppVManagementPackage](Import-AppVManagementPackage.md)
- [Test-AppVManagementSQLConnection](Test-AppVManagementSQLConnection.md)
