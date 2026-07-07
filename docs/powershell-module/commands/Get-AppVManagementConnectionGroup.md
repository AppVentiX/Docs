---
category: migration-appv
category_title: App-V Management Migration
document type: cmdlet
external help file: AppVentiX-Help.xml
HelpUri: ''
Locale: en-US
Module Name: AppVentiX
module_version: 2026.707.1700
ms.date: 07-07-2026
PlatyPS schema version: 2024-05-01
title: Get-AppVManagementConnectionGroup
---

# Get-AppVManagementConnectionGroup

## SYNOPSIS

Retrieves App-V Connection Groups (Package Groups) from the Management Database.

## SYNTAX

### __AllParameterSets

```
Get-AppVManagementConnectionGroup [[-SQLServer] <string>] [[-SQLCredential] <pscredential>]
 [[-SQLInstance] <string>] [[-SQLDatabase] <string>] [[-ConnectionGroupName] <string>]
 [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,

## DESCRIPTION

Queries the App-V Management Database to retrieve Connection Group information including
members (packages) and their configuration.

## EXAMPLES

### EXAMPLE 1

Get-AppVManagementConnectionGroup -SQLServer "sql01.domain.local" -SQLCredential $cred

Retrieves all Connection Groups from the specified SQL Server.

### EXAMPLE 2

Get-AppVManagementConnectionGroup -SQLServer "sql01.domain.local" -SQLCredential $cred -ConnectionGroupName "Office Suite"

Retrieves a specific Connection Group named "Office Suite".

## PARAMETERS

### -ConnectionGroupName

Optional filter to retrieve a specific Connection Group by name.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 4
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -SQLCredential

PSCredential object for SQL Server authentication.
If not provided, integrated authentication will be used.

```yaml
Type: System.Management.Automation.PSCredential
DefaultValue: '[System.Management.Automation.PSCredential]::Empty'
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
  Position: 3
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
  Position: 2
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -SQLServer

The SQL Server instance hosting the AppVManagement database.
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

Function : Get-AppVManagementConnectionGroup
Author   : John Billekens
Copyright: (c) John Billekens Consultancy
Version  : 2026.130.945
Requires : SqlServer PowerShell module


## RELATED LINKS

- [Test-AppVManagementSQLConnection](Test-AppVManagementSQLConnection.md)
- [Get-AppVManagementPackage](Get-AppVManagementPackage.md)
- [Import-AppVManagementPackage](Import-AppVManagementPackage.md)
- [Import-AppVManagementConnectionGroup](Import-AppVManagementConnectionGroup.md)
- [New-AppVentiXPublishingTask](New-AppVentiXPublishingTask.md)
- [New-AppVentiXConnectionGroup](New-AppVentiXConnectionGroup.md)
