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
title: Import-AppVManagementConnectionGroup
---

# Import-AppVManagementConnectionGroup

## SYNOPSIS

Imports App-V Connection Groups from the Management Database to the AppVentiX configuration.

## SYNTAX

### __AllParameterSets

```
Import-AppVManagementConnectionGroup [[-SQLServer] <string>] [[-SQLInstance] <string>]
 [[-SQLDatabase] <string>] [[-SQLCredential] <pscredential>] [[-ConfigShare] <string>]
 [-MatchConnectionGroupWithMachineGroup] [-GUI] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,

## DESCRIPTION

The Import-AppVManagementConnectionGroup function retrieves Connection Groups from the
App-V Management Database and imports them into the AppVentiX configuration share.
This function allows you to synchronize Connection Groups from the Management Server
to make them available for seamless publishing.

## EXAMPLES

### EXAMPLE 1

Import-AppVManagementConnectionGroup -SQLServer "sql01.domain.local"
Imports all Connection Groups from the specified SQL Server.

### EXAMPLE 2

Import-AppVManagementConnectionGroup -SQLServer "sql01.domain.local" -GUI
Displays a GUI to select specific Connection Groups to import.

### EXAMPLE 3

$cred = Get-Credential
Import-AppVManagementConnectionGroup -SQLServer "sql01.domain.local" -SQLCredential $cred -GUI
Imports Connection Groups using SQL authentication and GUI selection.

## PARAMETERS

### -ConfigShare

Specifies the AppVentiX configuration share path.
This parameter is hidden and uses the module's configured ConfigShare by default.

```yaml
Type: System.String
DefaultValue: $Script:AppVentiX.ConfigShare
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

### -GUI

When specified, displays a graphical user interface to select Connection Groups to import.

```yaml
Type: System.Management.Automation.SwitchParameter
DefaultValue: False
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -MatchConnectionGroupWithMachineGroup

When specified, packages in a Connection Group are matched to the Machine Group whose Content Share
contains them, and the resulting publishing task is targeted at that Machine Group.
When the packages
span multiple Machine Groups, the Connection Group is published to 'All Machine Groups'.

```yaml
Type: System.Management.Automation.SwitchParameter
DefaultValue: False
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: Named
  IsRequired: false
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

Specifies the App-V Management database name.
Default value: AppVManagement

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

Specifies the SQL Server instance name.
If not specified, the default instance will be used.

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

Specifies the SQL Server hostname or IP address.
Default value: localhost

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

Function : Import-AppVManagementConnectionGroup
Author   : John Billekens
Copyright: (c) John Billekens Consultancy & AppVentiX
Version  : 2026.707.1400
Requires : Valid AppVentiX license


## RELATED LINKS

- [Test-AppVManagementSQLConnection](Test-AppVManagementSQLConnection.md)
- [Get-AppVManagementPackage](Get-AppVManagementPackage.md)
- [Get-AppVManagementConnectionGroup](Get-AppVManagementConnectionGroup.md)
- [Import-AppVManagementPackage](Import-AppVManagementPackage.md)
- [New-AppVentiXPublishingTask](New-AppVentiXPublishingTask.md)
- [New-AppVentiXConnectionGroup](New-AppVentiXConnectionGroup.md)
