# Test-AppVManagementSQLConnection

Tests connectivity to the App-V Management SQL Server database.

## Syntax

```powershell
Test-AppVManagementSQLConnection
    [-SQLServer <String>]
    [-SQLInstance <String>]
    [-SQLDatabase <String>]
    [-SQLCredential <PSCredential>]
    [<CommonParameters>]
```

## Description

The `Test-AppVManagementSQLConnection` function verifies that a connection can be established to the App-V Management SQL Server database. This is useful for diagnosing connectivity issues before running commands that query the App-V Management database, such as `Get-AppVManagementPackage` or `Get-AppVManagementConnectionGroup`.

## Parameters

### -SQLServer

The hostname or IP address of the SQL Server hosting the App-V Management database.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -SQLInstance

The SQL Server instance name. If not specified, the default instance is used.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -SQLDatabase

The name of the App-V Management SQL database.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | AppVManagement |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -SQLCredential

A PSCredential object for SQL Server authentication. If not specified, Windows Integrated Authentication is used.

| | |
|---|---|
| Type: | PSCredential |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

## Examples

### Example 1: Test connection to the default App-V Management database

```powershell
Test-AppVManagementSQLConnection -SQLServer "sqlserver01"
```

Tests connectivity to the AppVManagement database on the specified SQL Server using Windows authentication.

### Example 2: Test connection with a named instance

```powershell
Test-AppVManagementSQLConnection -SQLServer "sqlserver01" -SQLInstance "APPV" -SQLDatabase "AppVManagement"
```

Tests connectivity to the AppVManagement database on a named SQL Server instance.

### Example 3: Test connection with SQL credentials

```powershell
$sqlCred = Get-Credential
Test-AppVManagementSQLConnection -SQLServer "sqlserver01" -SQLCredential $sqlCred
```

Tests connectivity using SQL Server authentication with the provided credentials.

## Notes

- This function is used to diagnose SQL connectivity issues before querying the App-V Management database
- Requires network access to the SQL Server and appropriate database permissions

## Related Links

- [Get-AppVManagementPackage](Get-AppVManagementPackage.md)
- [Get-AppVManagementConnectionGroup](Get-AppVManagementConnectionGroup.md)
- [Import-AppVManagementPackage](Import-AppVManagementPackage.md)
