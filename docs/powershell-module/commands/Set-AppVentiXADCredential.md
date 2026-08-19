---
category: configuration
category_title: Configuration Commands
document type: cmdlet
external help file: AppVentiX-Help.xml
HelpUri: ''
Locale: en-US
Module Name: AppVentiX
module_version: 2026.818.1700
ms.date: 08-19-2026
PlatyPS schema version: 2024-05-01
title: Set-AppVentiXADCredential
---

# Set-AppVentiXADCredential

## SYNOPSIS

Sets the Active Directory credentials used by AppVentiX services for directory lookups.

## SYNTAX

### __AllParameterSets

```
Set-AppVentiXADCredential [[-Credential] <pscredential>] [[-Server] <string>] [[-Port] <int>]
 [[-ConfigShare] <string>] [-AuthenticateConfigShare] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,

## DESCRIPTION

Set-AppVentiXADCredential configures the Active Directory credentials that AppVentiX uses internally for
directory queries.
The supplied credentials are stored in the module session scope and applied
as default parameter values for all AD cmdlets.

Optionally, the function can first authenticate to the AppVentiX configuration share using the provided
credentials before proceeding with the license check and credential configuration.

After the credentials are accepted, the function attempts to retrieve domain information via Get-AdsiADDomain
to automatically resolve and store the directory server and port.
If domain discovery fails, the credentials
are cleared and an error is returned.

Always run 'Clear-AppVentiXADCredential' when finished, or restart the PowerShell session, to remove the
stored credentials.

## EXAMPLES

### EXAMPLE 1

Set-AppVentiXADCredential

Prompts the user for Active Directory credentials and configures them for use by AppVentiX directory operations.
The directory server and port are resolved automatically.

### EXAMPLE 2

Set-AppVentiXADCredential -Credential (Get-Credential) -Server 'dc01.domain.local' -Port 636

Sets the specified credentials and explicitly targets 'dc01.domain.local' on port 636 for all directory operations.

### EXAMPLE 3

Set-AppVentiXADCredential -Credential $cred -AuthenticateConfigShare

Authenticates to the AppVentiX configuration share using the provided credentials before configuring the
Active Directory credentials for directory operations.

## PARAMETERS

### -AuthenticateConfigShare

When specified, authenticates to the AppVentiX configuration share using the provided credentials before
performing any other operations.
Useful when the configuration share requires explicit credentials.

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

### -ConfigShare

Internal parameter.
Points to the AppVentiX configuration share path.
Automatically populated from the
module configuration and does not normally need to be specified manually.

```yaml
Type: System.String
DefaultValue: $Script:AppVentix.ConfigShare
SupportsWildcards: false
Aliases:
- Config
- Share
- AppVentixConfigShare
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

### -Credential

The Active Directory credentials to use for directory operations.
If not provided, the user is prompted
interactively.
Accepts a PSCredential object or a username string (the password will be prompted).

```yaml
Type: System.Management.Automation.PSCredential
DefaultValue: '[System.Management.Automation.PSCredential]::Empty'
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

### -Port

The LDAP port to use for the Active Directory connection.
Default: 389.

```yaml
Type: System.Int32
DefaultValue: 389
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

### -Server

The Active Directory server (domain controller) to connect to.
If not specified, the server is resolved
automatically from the domain information returned by Get-AdsiADDomain.

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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutBuffer, -OutVariable, -PipelineVariable,
-ProgressAction, -Verbose, -WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## RELATED LINKS

- [Get-AppVentiXConfigShare](Get-AppVentiXConfigShare.md)
- [Set-AppVentiXConfigShare](Set-AppVentiXConfigShare.md)
- [Get-AppVentiXModuleVariable](Get-AppVentiXModuleVariable.md)
- [Clear-AppVentiXADCredential](Clear-AppVentiXADCredential.md)
