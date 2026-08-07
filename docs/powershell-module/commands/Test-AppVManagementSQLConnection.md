---
category: migration-appv
category_title: App-V Management Migration
document type: cmdlet
external help file: AppVentiX-Help.xml
HelpUri: ''
Locale: en-US
Module Name: AppVentiX
module_version: 2026.806.1845
ms.date: 08-07-2026
PlatyPS schema version: 2024-05-01
title: Test-AppVManagementSQLConnection
---

# Test-AppVManagementSQLConnection

## SYNOPSIS

Tests the connection to the App-V Management SQL Database.

## SYNTAX

### __AllParameterSets

```
Test-AppVManagementSQLConnection [[-SQLServer] <string>] [[-SQLInstance] <string>]
 [[-SQLDatabase] <string>] [[-SQLCredential] <pscredential>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,

## DESCRIPTION

This function tests the connection to the App-V Management SQL Database by executing a simple query against the PackageVersions table.
It supports both Windows Integrated Authentication and SQL Server Authentication.

## EXAMPLES

### EXAMPLE 1

Test-AppVManagementSQLConnection -SQLServer 'sql01.domain.local'

Tests the connection to the App-V Management database using Windows Integrated Authentication.

### EXAMPLE 2

Test-AppVManagementSQLConnection -SQLServer 'sql01.domain.local' -SQLInstance 'APPV' -SQLCredential (Get-Credential)

Tests the connection to a named instance using SQL Server authentication.

## PARAMETERS

### -SQLCredential

PSCredential object for SQL Server authentication.
If not provided, Windows Integrated Authentication is used.

```yaml
Type: System.Management.Automation.PSCredential
DefaultValue: '[System.Management.Automation.PSCredential]::Empty'
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 3
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -SQLDatabase

The App-V Management database name.
Default: AppVManagement

```yaml
Type: System.String
DefaultValue: AppVManagement
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 2
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -SQLInstance

Optional named SQL Server instance.
If not specified, the default instance is used.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 1
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -SQLServer

The SQL Server hostname or IP address hosting the App-V Management database.
Default: localhost

```yaml
Type: System.String
DefaultValue: localhost
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 0
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutBuffer, -OutVariable, -PipelineVariable,
-ProgressAction, -Verbose, -WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

Function : Test-AppVManagementSQLConnection
Author   : John Billekens
Copyright: (c) John Billekens Consultancy & AppVentiX
Version  : 2026.130.1000
Requires : SqlServer PowerShell module


## RELATED LINKS

- [Get-AppVManagementPackage](Get-AppVManagementPackage.md)
- [Get-AppVManagementConnectionGroup](Get-AppVManagementConnectionGroup.md)
- [Import-AppVManagementPackage](Import-AppVManagementPackage.md)
- [Import-AppVManagementConnectionGroup](Import-AppVManagementConnectionGroup.md)
- [New-AppVentiXPublishingTask](New-AppVentiXPublishingTask.md)
- [New-AppVentiXConnectionGroup](New-AppVentiXConnectionGroup.md)
