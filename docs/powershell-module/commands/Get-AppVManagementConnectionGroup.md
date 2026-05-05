# Get-AppVManagementConnectionGroup

Retrieves App-V Connection Groups (Package Groups) from the Management Database.

## Syntax

```powershell
Get-AppVManagementConnectionGroup
    [-SQLServer <String>]
    [-SQLInstance <String>]
    [-SQLDatabase <String>]
    [-SQLCredential <PSCredential>]
    [-ConnectionGroupName <String>]
    [<CommonParameters>]
```

## Description

The `Get-AppVManagementConnectionGroup` function queries the App-V Management Database to retrieve Connection Group information including member packages and their configuration. It also resolves Active Directory group assignments (entitlements) for each Connection Group.

Each returned Connection Group object includes:
- Connection Group metadata (ID, Name, Description, Enabled, Priority, Version)
- Array of member packages with their load order, optional/required status, and version settings
- Array of AD groups (entitlements) with SID and resolved group name

## Parameters

### -SQLServer

Specifies the SQL Server hostname or IP address where the App-V Management database is hosted.

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

### -ConnectionGroupName

Specifies an optional filter to retrieve a specific Connection Group by name.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

## Examples

### Example 1: Retrieve all Connection Groups

```powershell
Get-AppVManagementConnectionGroup -SQLServer "sql01.domain.local" -SQLCredential $cred
```

Retrieves all Connection Groups from the specified SQL Server.

### Example 2: Retrieve a specific Connection Group

```powershell
Get-AppVManagementConnectionGroup -SQLServer "sql01.domain.local" -SQLCredential $cred -ConnectionGroupName "Office Suite"
```

Retrieves a specific Connection Group named "Office Suite".

## Notes

- Requires the SqlServer PowerShell module
- AD group SIDs are resolved to group names; use `Set-AppVentiXADCredential` if the AD lookup requires explicit credentials
- Use `Test-AppVManagementSQLConnection` to verify connectivity before querying

## Related Links

- [Get-AppVManagementPackage](Get-AppVManagementPackage.md)
- [Import-AppVManagementConnectionGroup](Import-AppVManagementConnectionGroup.md)
- [Test-AppVManagementSQLConnection](Test-AppVManagementSQLConnection.md)
