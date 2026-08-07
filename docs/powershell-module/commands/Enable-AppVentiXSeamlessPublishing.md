---
category: seamless
category_title: Seamless Publishing Commands
document type: cmdlet
external help file: AppVentiX-Help.xml
HelpUri: ''
Locale: en-US
Module Name: AppVentiX
module_version: 2026.806.1845
ms.date: 08-07-2026
PlatyPS schema version: 2024-05-01
title: Enable-AppVentiXSeamlessPublishing
---

# Enable-AppVentiXSeamlessPublishing

## SYNOPSIS

Enables seamless publishing for the specified publishing task.

## SYNTAX

### IDAzureAll (Default)

```
Enable-AppVentiXSeamlessPublishing -Id <string> -SubscriptionId <string> -TenantId <string>
 -ResourceGroupName <string> -ApplicationGroupName <string> -HostPoolName <string>
 -AssignmentName <string> [-RunVirtual] [-ConfigShare <string>] [<CommonParameters>]
```

### IDCitrixDaaS

```
Enable-AppVentiXSeamlessPublishing -Id <string> -CustomerID <string>
 -ServicePrincipalCredential <pscredential> [-DeliveryGroupName <string>] [-Server <string>]
 [-Port <int>] [<CommonParameters>]
```

### IDCitrixLocal

```
Enable-AppVentiXSeamlessPublishing -Id <string> -AdminAddress <string> [-DeliveryGroupName <string>]
 [-Server <string>] [-Port <int>] [<CommonParameters>]
```

### IDAzureApps

```
Enable-AppVentiXSeamlessPublishing -Id <string> -SubscriptionId <string> -TenantId <string>
 -ResourceGroupName <string> -ApplicationGroupName <string> -HostPoolName <string>
 -AssignmentName <string> -SeamlessApps <psobject[]> [-ConfigShare <string>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,

## DESCRIPTION

The Enable-AppVentiXSeamlessPublishing function enables seamless publishing for the specified publishing task.

## EXAMPLES

### EXAMPLE 1

Enable-AppVentiXSeamlessPublishing -Id '12345678-1234-1234-1234-123456789012' -SubscriptionId '12345678-1234-1234-1234-123456789012' -TenantId '12345678-1234-1234-1234-123456789012' -ResourceGroupName 'MyResourceGroup' -ApplicationGroupName 'MyApplicationGroup' -HostPoolName 'MyHostPool' -AssignmentName 'MyAADGroup'

Enables seamless publishing for the publishing task with the specified ID for all applications available in the package and publishes them to Azure Virtual Desktop.

### EXAMPLE 2

Enable-AppVentiXSeamlessPublishing -Id '12345678-1234-1234-1234-123456789012'
Enables seamless publishing for the publishing task with the specified ID for all applications available in the package.
Because no Azure parameters are provided, the function will return the parameters that should be used to publish the applications.

### EXAMPLE 3

$params = @{
    SubscriptionId = '12345678-1234-1234-1234-123456789012'
    ResourceGroupName = 'MyResourceGroup'
    ApplicationGroupName = 'MyApplicationGroup'
    HostPoolName = 'MyHostPool'
    AssignmentName = 'MyAADGroup'
}
$newTask | Enable-AppVentiXSeamlessPublishing @params
Uses the output of the New-AppVentiXPublishingTask function to enable seamless publishing for the publishing task with the specified ID for all applications available in the package.

### EXAMPLE 4

Enable-AppVentiXSeamlessPublishing -Id '12345678-1234-1234-1234-123456789012' -SeamlessApps @(
    [PSCustomObject]@{
        Order = '0'
        Executable = 'MSIXApp1.exe'
        Argument = ''
        IconPath = 'C:\Program Files\WindowsApps\App.1.1.1.1_x64__abcdefghijkl\Assets\App1-Square44x44Logo.scale-100.png'
        FriendlyName = 'App1'
        RunVirtual = $false
        Description = 'This is the first application'
    },{
        Order = '1'
        Executable = 'MSIXApp2.exe'
        Argument = ''
        IconPath = 'C:\Program Files\WindowsApps\App.1.1.1.1_x64__abcdefghijkl\Assets\App2-Square44x44Logo.scale-100.png'
        FriendlyName = 'App2'
        RunVirtual = $false
        Description = 'This is the second application'
    }
)
Enables seamless publishing for the publishing task with the specified ID for the specified applications.
Because no Azure parameters are provided, the function will return the parameters that should be used to publish the applications.

## PARAMETERS

### -AdminAddress

Specifies the address of the Citrix Delivery Controller (Citrix on-premises publishing).

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: IDCitrixLocal
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -ApplicationGroupName

Specifies the name of the application group in which the applications are published.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases:
- ApplicationGroup
ParameterSets:
- Name: IDAzureApps
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: IDAzureAll
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

Specifies the name of the Azure AD group or user that should be assigned to the application group.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: IDAzureApps
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: IDAzureAll
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

Specifies the path to the AppVentiX configuration share.
You can omit this parameter if the configuration store was already set with Set-AppVentiXConfigShare,
or when it can be detected automatically (for example on a machine where AppVentiX Central View is installed and configured).

```yaml
Type: System.String
DefaultValue: $Script:AppVentix.ConfigShare
SupportsWildcards: false
Aliases:
- Config
- Share
- AppVentixConfigShare
ParameterSets:
- Name: IDAzureApps
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: IDAzureAll
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -CustomerID

Specifies the Citrix Cloud customer ID (Citrix DaaS publishing).

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: IDCitrixDaaS
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -DeliveryGroupName

Specifies the name of the Citrix Delivery Group to publish the applications to.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: IDCitrixLocal
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: IDCitrixDaaS
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

Specifies the name of the host pool in which the applications are published.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases:
- HostPool
ParameterSets:
- Name: IDAzureApps
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: IDAzureAll
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

Specifies the ID of the publishing task.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: IDCitrixDaaS
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: true
  ValueFromRemainingArguments: false
- Name: IDCitrixLocal
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: true
  ValueFromRemainingArguments: false
- Name: IDAzureApps
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: true
  ValueFromRemainingArguments: false
- Name: IDAzureAll
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: true
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Port

Specifies the LDAP port used for Citrix publishing.
Defaults to 389.

```yaml
Type: System.Int32
DefaultValue: 389
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: IDCitrixLocal
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: IDCitrixDaaS
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -ResourceGroupName

Specifies the name of the resource group in which the host pool and application group are located.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: IDAzureApps
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: IDAzureAll
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -RunVirtual

Publishes the applications to run inside the virtual environment (Run Virtual).

```yaml
Type: System.Management.Automation.SwitchParameter
DefaultValue: False
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: IDAzureAll
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -SeamlessApps

Specifies the applications that should be published seamlessly.
Only the following array of objects is supported:
@(
    [PSCustomObject]@{
        Order = '0'
        Executable = 'MSIXApp1ID#Path\To\MSIXApp1.exe'
        Argument = ''
        IconPath = 'C:\Program Files\WindowsApps\App.1.1.1.1_x64__abcdefghijkl\Assets\App1-Square44x44Logo.scale-100.png'
        FriendlyName = 'App1'
        RunVirtual = $false
        Description = 'This is the first application'
    },{
        Order = '1'
        Executable = 'MSIXApp1ID#Path\To\MSIXApp2.exe'
        Argument = ''
        IconPath = 'C:\Program Files\WindowsApps\App.1.1.1.1_x64__abcdefghijkl\Assets\App2-Square44x44Logo.scale-100.png'
        FriendlyName = 'App2'
        RunVirtual = $false
        Description = 'This is the second application'
    }
)

```yaml
Type: System.Management.Automation.PSObject[]
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: IDAzureApps
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: true
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Server

Specifies the Active Directory server (domain) used for Citrix publishing.
Defaults to the user DNS domain.

```yaml
Type: System.String
DefaultValue: '"${Env:USERDNSDOMAIN}"'
SupportsWildcards: false
Aliases:
- DomainName
ParameterSets:
- Name: IDCitrixLocal
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: IDCitrixDaaS
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -ServicePrincipalCredential

Specifies the Citrix Cloud API credentials (API key as username, secret key as password) used for Citrix DaaS publishing.

```yaml
Type: System.Management.Automation.PSCredential
DefaultValue: ''
SupportsWildcards: false
Aliases:
- Credential
ParameterSets:
- Name: IDCitrixDaaS
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

Specifies the subscription ID of the Azure subscription.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: IDAzureApps
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: IDAzureAll
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -TenantId

Specifies the Azure tenant ID used to connect to Azure.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: IDAzureApps
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: IDAzureAll
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

### System.Management.Automation.PSObject[]

## OUTPUTS

## NOTES

Function: Enable-AppVentiXSeamlessPublishing
Author: John Billekens
Copyright: (c) John Billekens Consultancy & AppVentiX
Version: 2026.130.1000
Requires : Valid AppVentiX license


## RELATED LINKS

- [Disable-AppVentiXSeamlessPublishing](Disable-AppVentiXSeamlessPublishing.md)
- [Get-AppVentiXSeamlessPublishCommand](Get-AppVentiXSeamlessPublishCommand.md)
- [Export-AppVentiXSeamlessApplicationsReport](Export-AppVentiXSeamlessApplicationsReport.md)
- [Get-AppVentiXPublishingTask](Get-AppVentiXPublishingTask.md)
- [New-AppVentiXPublishingTask](New-AppVentiXPublishingTask.md)
