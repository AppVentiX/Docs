---
category: publishing-task
category_title: Publishing Task Commands
document type: cmdlet
external help file: AppVentiX-Help.xml
HelpUri: ''
Locale: en-US
Module Name: AppVentiX
module_version: 2026.818.1700
ms.date: 08-19-2026
PlatyPS schema version: 2024-05-01
title: Copy-AppVentiXPublishingTask
---

# Copy-AppVentiXPublishingTask

## SYNOPSIS

Copies AppVentiX publishing tasks to a new machine group with optional Azure Virtual Desktop seamless publishing.

## SYNTAX

### ID (Default)

```
Copy-AppVentiXPublishingTask -Id <string> -NewMachineGroupFriendlyname <string> [-NewGroup <string>]
 [-DontPublishSeamless] [-ConfigShare <string>] [<CommonParameters>]
```

### IDAzure

```
Copy-AppVentiXPublishingTask -Id <string> -NewMachineGroupFriendlyname <string>
 -SubscriptionId <string> -ResourceGroupName <string> -ApplicationGroupName <string>
 -HostPoolName <string> -AssignmentName <string> [-NewGroup <string>] [-ConfigShare <string>]
 [<CommonParameters>]
```

### MachineGroupFriendlynameAzure

```
Copy-AppVentiXPublishingTask -MachineGroupFriendlyname <string>
 -NewMachineGroupFriendlyname <string> -SubscriptionId <string> -ResourceGroupName <string>
 -ApplicationGroupName <string> -HostPoolName <string> -AssignmentName <string>
 [-ConfigShare <string>] [<CommonParameters>]
```

### MachineGroupFriendlyname

```
Copy-AppVentiXPublishingTask -MachineGroupFriendlyname <string>
 -NewMachineGroupFriendlyname <string> [-DontPublishSeamless] [-ConfigShare <string>]
 [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,

## DESCRIPTION

The Copy-AppVentiXPublishingTask function copies one or more AppVentiX publishing tasks from an existing machine group to a new machine group.
It supports both standard copying and Azure Virtual Desktop (AVD) seamless publishing scenarios.

The function performs the following operations:
- Validates that AppVentiX is properly licensed
- Retrieves existing publishing tasks and machine groups from the configuration
- Copies task configuration including package paths, groups, and seamless applications
- Automatically adjusts content share paths for the new machine group
- Optionally configures Azure Virtual Desktop seamless publishing
- Updates Active Directory group assignments with SID resolution
- Preserves or disables seamless publishing based on parameters

When copying tasks with seamless publishing enabled, the function can automatically configure Azure Virtual Desktop
application groups, host pools, and user assignments.

## EXAMPLES

### EXAMPLE 1

Copy-AppVentiXPublishingTask -Id "a1b2c3d4-e5f6-7890-abcd-ef1234567890" -NewMachineGroupFriendlyname "Production"

Copies a single publishing task to the Production machine group, preserving all settings including group assignments and seamless publishing.

### EXAMPLE 2

Copy-AppVentiXPublishingTask -MachineGroupFriendlyname "Development" -NewMachineGroupFriendlyname "Testing"

Copies all publishing tasks from the Development machine group to the Testing machine group.

### EXAMPLE 3

Copy-AppVentiXPublishingTask -MachineGroupFriendlyname "Development" -NewMachineGroupFriendlyname "Production" -NewGroup "CONTOSO.local\Prod-Users"

Copies all publishing tasks from Development to Production and assigns them to the CONTOSO.local\Prod-Users AD group.

### EXAMPLE 4

Copy-AppVentiXPublishingTask -Id "a1b2c3d4-e5f6-7890-abcd-ef1234567890" -NewMachineGroupFriendlyname "Testing" -DontPublishSeamless

Copies a publishing task to Testing but disables seamless publishing even if the source task had it enabled.

### EXAMPLE 5

Get-AppVentiXPublishingTask -MachineGroupFriendlyName "Development" | Copy-AppVentiXPublishingTask -NewMachineGroupFriendlyname "Staging"

Uses pipeline input to copy all publishing tasks from Development to Staging.

### EXAMPLE 6

$Params = @{
        Id                        = "a1b2c3d4-e5f6-7890-abcd-ef1234567890"
        NewMachineGroupFriendlyname = "AVD-Production"
        SubscriptionId            = "12345678-1234-1234-1234-123456789012"
        ResourceGroupName         = "RG-AVD-Prod"
        ApplicationGroupName      = "AppGroup-Office"
        HostPoolName              = "HostPool-Prod"
        AssignmentName            = "Office-Users-Assignment"
    }
PS C:\> Copy-AppVentiXPublishingTask @Params

Copies a publishing task with Azure Virtual Desktop seamless publishing configuration, including subscription, resource group,
application group, host pool, and user assignment details.

### EXAMPLE 7

Copy-AppVentiXPublishingTask -MachineGroupFriendlyname "Development" -NewMachineGroupFriendlyname "Production" -NewGroup "CONTOSO.local\ProdUsers"

Copies tasks and assigns them to ProdUsers group (domain will be inherited from original task if not specified).

## PARAMETERS

### -ApplicationGroupName

Specifies the Azure Virtual Desktop application group name for seamless publishing.
This parameter has an alias: ApplicationGroup.
Mandatory for Azure-specific parameter sets.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases:
- ApplicationGroup
ParameterSets:
- Name: MachineGroupFriendlynameAzure
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: IDAzure
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -AssignmentName

Specifies the name for the Azure Virtual Desktop user assignment.
This is used to create or update user group assignments for seamless applications.
Mandatory for Azure-specific parameter sets.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: MachineGroupFriendlynameAzure
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: IDAzure
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -ConfigShare

Specifies the AppVentiX configuration share path.
By default, uses the configuration share from the module's current session variable.
This parameter is hidden from normal parameter discovery.

```yaml
Type: System.String
DefaultValue: $Script:AppVentix.ConfigShare
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: MachineGroupFriendlynameAzure
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: MachineGroupFriendlyname
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: IDAzure
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: ID
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -DontPublishSeamless

Disables seamless publishing for the copied tasks, even if the original tasks had seamless publishing enabled.
Use this switch when you want to copy task configurations without enabling seamless application publishing.
Only applicable for non-Azure parameter sets.

```yaml
Type: System.Management.Automation.SwitchParameter
DefaultValue: False
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: MachineGroupFriendlyname
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: ID
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -HostPoolName

Specifies the Azure Virtual Desktop host pool name associated with the application group.
This parameter has an alias: HostPool.
Mandatory for Azure-specific parameter sets.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases:
- HostPool
ParameterSets:
- Name: MachineGroupFriendlynameAzure
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: IDAzure
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Id

Specifies the GUID of a specific publishing task to copy.
This parameter accepts pipeline input by property name and is mandatory when copying a single task.
The value must be a valid GUID format.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: IDAzure
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: true
  ValueFromRemainingArguments: false
- Name: ID
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: true
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -MachineGroupFriendlyname

Specifies the friendly name of the source machine group containing the publishing tasks to copy.
All publishing tasks from this machine group will be copied to the new machine group.
This parameter accepts pipeline input by property name.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: MachineGroupFriendlynameAzure
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: true
  ValueFromRemainingArguments: false
- Name: MachineGroupFriendlyname
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: true
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -NewGroup

Specifies the new Active Directory group to assign to the copied publishing tasks.
Can be specified as "GroupName" or "DOMAIN\GroupName".
If only the group name is provided, the domain from the original task will be reused.
If not specified, the original task's group assignment will be retained.
The function will attempt to resolve the group SID automatically.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: IDAzure
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: ID
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -NewMachineGroupFriendlyname

Specifies the friendly name of the destination machine group where tasks will be copied.
This parameter is mandatory for all parameter sets.
The machine group must already exist in the AppVentiX configuration.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: MachineGroupFriendlynameAzure
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: MachineGroupFriendlyname
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: IDAzure
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: ID
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -ResourceGroupName

Specifies the Azure resource group name containing the AVD resources.
This parameter is mandatory when using Azure-specific parameter sets.
The resource group must contain the specified host pool and application group.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: MachineGroupFriendlynameAzure
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: IDAzure
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -SubscriptionId

Specifies the Azure subscription ID for Azure Virtual Desktop seamless publishing.
This parameter is mandatory when using Azure-specific parameter sets (IDAzure or MachineGroupFriendlynameAzure).
Required for configuring AVD application groups and assignments.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: MachineGroupFriendlynameAzure
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: IDAzure
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

### System.String

## OUTPUTS

## RELATED LINKS

- [Get-AppVentiXPublishingTask](Get-AppVentiXPublishingTask.md)
- [New-AppVentiXPublishingTask](New-AppVentiXPublishingTask.md)
- [Set-AppVentiXPublishingTask](Set-AppVentiXPublishingTask.md)
- [Remove-AppVentiXPublishingTask](Remove-AppVentiXPublishingTask.md)
- [Export-AppVentiXPublishingTaskReport](Export-AppVentiXPublishingTaskReport.md)
- [Get-AppVentiXMachineGroup](Get-AppVentiXMachineGroup.md)
