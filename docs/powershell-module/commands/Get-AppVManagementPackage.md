---
category: migration-appv
category_title: App-V Management Migration
document type: cmdlet
external help file: AppVentiX-Help.xml
HelpUri: ''
Locale: en-US
Module Name: AppVentiX
module_version: 2026.818.1700
ms.date: 08-19-2026
PlatyPS schema version: 2024-05-01
title: Get-AppVManagementPackage
---

# Get-AppVManagementPackage

## SYNOPSIS

Retrieves App-V packages with AD access entitlements from the Microsoft App-V Management database.

## SYNTAX

### All (Default)

```
Get-AppVManagementPackage [-SQLServer <string>] [-SQLInstance <string>] [-SQLDatabase <string>]
 [-SQLCredential <pscredential>] [-EnabledOnly] [<CommonParameters>]
```

### ByName

```
Get-AppVManagementPackage -Name <string> [-SQLServer <string>] [-SQLInstance <string>]
 [-SQLDatabase <string>] [-SQLCredential <pscredential>] [-EnabledOnly] [<CommonParameters>]
```

### ByVersionGuid

```
Get-AppVManagementPackage -VersionGuid <guid> [-SQLServer <string>] [-SQLInstance <string>]
 [-SQLDatabase <string>] [-SQLCredential <pscredential>] [<CommonParameters>]
```

### ByPackageGuid

```
Get-AppVManagementPackage -PackageGuid <guid> [-SQLServer <string>] [-SQLInstance <string>]
 [-SQLDatabase <string>] [-SQLCredential <pscredential>] [-EnabledOnly] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,

## DESCRIPTION

The Get-AppVManagementPackage function queries the App-V Management database
to retrieve complete package information including package metadata, version details,
applications, shortcuts, file type associations, and AD entitlements.

Each package includes:
- DeploymentConfigurationXml: Global deployment configuration (one per package)
- ADGroups: Array of AD entitlements, each with:
  - UserConfigurationXml: The AD group's specific user configuration (if any)
  - DeploymentConfigurationXml: Combined deployment config where the UserConfiguration
    element from the global deployment config is replaced with this AD group's
    UserConfiguration (if UserConfigurationXml exists for the group)

## EXAMPLES

### EXAMPLE 1

Get-AppVManagementPackage -SQLServer "sql01.domain.local"
Retrieves all packages with their AD entitlements from the App-V Management database.

### EXAMPLE 2

$cred = Get-Credential
Get-AppVManagementPackage -SQLServer "sql01.domain.local" -SQLCredential $cred
Retrieves all packages using SQL Server authentication.

### EXAMPLE 3

Get-AppVManagementPackage -SQLServer "SQLSRV01" -SQLInstance "INSTANCE01" -EnabledOnly
Retrieves only enabled packages from a named SQL Server instance.

### EXAMPLE 4

Get-AppVManagementPackage -SQLServer "SQLSRV01" -Name "Adobe*"
Retrieves all packages with names starting with "Adobe".

### EXAMPLE 5

Get-AppVManagementPackage -SQLServer "SQLSRV01" -PackageGuid "FB4267F4-6B2B-45E1-A55B-0FE9C69A3DC2"
Retrieves all versions of a specific package by PackageGuid with AD entitlements.

## PARAMETERS

### -EnabledOnly

Returns only enabled packages (Enabled = 1).

```yaml
Type: System.Management.Automation.SwitchParameter
DefaultValue: False
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: ByName
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: ByPackageGuid
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: All
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Name

Filters packages by name using wildcards (*).
Example: "Adobe*" will return all packages starting with "Adobe".

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: ByName
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -PackageGuid

Retrieves a specific package by its PackageGuid.
This can be used to get all versions of a specific package.

```yaml
Type: System.Guid
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: ByPackageGuid
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -SQLCredential

Specifies the PSCredential object for SQL Server authentication.
If not specified, Windows Integrated Authentication will be used.

```yaml
Type: System.Management.Automation.PSCredential
DefaultValue: '[System.Management.Automation.PSCredential]::Empty'
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: ByName
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: ByVersionGuid
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: ByPackageGuid
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: All
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -SQLDatabase

Specifies the App-V Management database name.
Default value: AppVManagement

```yaml
Type: System.String
DefaultValue: AppVManagement
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: ByName
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: ByVersionGuid
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: ByPackageGuid
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: All
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -SQLInstance

Specifies the SQL Server instance name.
If not specified, the default instance will be used.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: ByName
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: ByVersionGuid
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: ByPackageGuid
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: All
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -SQLServer

Specifies the SQL Server hostname or IP address.
Default value: localhost

```yaml
Type: System.String
DefaultValue: localhost
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: ByName
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: ByVersionGuid
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: ByPackageGuid
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: All
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -VersionGuid

Retrieves a specific package version by its VersionGuid.

```yaml
Type: System.Guid
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: ByVersionGuid
  Position: Named
  IsRequired: true
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

## RELATED LINKS

- [Test-AppVManagementSQLConnection](Test-AppVManagementSQLConnection.md)
- [Get-AppVManagementConnectionGroup](Get-AppVManagementConnectionGroup.md)
- [Import-AppVManagementPackage](Import-AppVManagementPackage.md)
- [Import-AppVManagementConnectionGroup](Import-AppVManagementConnectionGroup.md)
- [New-AppVentiXPublishingTask](New-AppVentiXPublishingTask.md)
- [New-AppVentiXConnectionGroup](New-AppVentiXConnectionGroup.md)
