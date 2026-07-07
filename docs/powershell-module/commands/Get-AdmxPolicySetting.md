---
category: migration-ivanti
category_title: Ivanti Workspace Control Migration
document type: cmdlet
external help file: AppVentiX-Help.xml
HelpUri: ''
Locale: en-US
Module Name: AppVentiX
module_version: 2026.707.1700
ms.date: 07-07-2026
PlatyPS schema version: 2024-05-01
title: Get-AdmxPolicySetting
---

# Get-AdmxPolicySetting

## SYNOPSIS

Retrieves Group Policy setting details from ADMX/ADML files matching a registry key path and value name.

## SYNTAX

### Path (Default)

```
Get-AdmxPolicySetting -AdmxPath <string> [-Recurse] [-All] [-RegistryKey <string>]
 [-ValueName <string>] [<CommonParameters>]
```

### XmlFile

```
Get-AdmxPolicySetting -AdmxFilePath <string> [-AdmlFilePath <string>] [-All] [-RegistryKey <string>]
 [-ValueName <string>] [<CommonParameters>]
```

### XmlContent

```
Get-AdmxPolicySetting -AdmxContent <string> [-AdmlContent <string>] [-AdmxFileName <string>]
 [-AdmlFileName <string>] [-All] [-RegistryKey <string>] [-ValueName <string>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,

## DESCRIPTION

Parses ADMX files to find policy settings matching a given registry key and value name,
returning registry type, element type, policy metadata, and display strings resolved from
the corresponding ADML file.

Supports three parameter sets:
- Path     : Provide a path to an ADMX file or directory containing ADMX files.
- XmlFile  : Provide file paths to ADMX and optionally ADML files as strings.
- XmlContent : Provide raw XML content strings for ADMX and optionally ADML.

Use -All to return every policy in the file(s) without filtering.
Otherwise, both -RegistryKey and -ValueName are required.

ADML auto-detection order (Path and XmlFile sets):
1.
Subfolder matching the current UI culture (e.g., en-GB) in the ADMX directory.
2.
Fallback to en-US subfolder.
3.
Any available language subfolder found.

## EXAMPLES

### EXAMPLE 1

Get-AdmxPolicySetting -AdmxPath 'C:\Windows\PolicyDefinitions' `
    -RegistryKey 'SOFTWARE\Policies\Microsoft\Edge' `
    -ValueName 'HomepageIsNewTabPage' -Recurse

### EXAMPLE 2

Get-AdmxPolicySetting -AdmxFilePath 'C:\PolicyDefs\msedge.admx' `
    -AdmlFilePath 'C:\PolicyDefs\en-US\msedge.adml' `
    -RegistryKey 'SOFTWARE\Policies\Microsoft\Edge' `
    -ValueName 'HomepageIsNewTabPage'

### EXAMPLE 3

$admxXml = Get-Content 'C:\PolicyDefs\msedge.admx' -Raw
$admlXml = Get-Content 'C:\PolicyDefs\en-US\msedge.adml' -Raw
Get-AdmxPolicySetting -AdmxContent $admxXml -AdmlContent $admlXml `
    -RegistryKey 'SOFTWARE\Policies\Microsoft\Edge' `
    -ValueName 'HomepageIsNewTabPage'

## PARAMETERS

### -AdmlContent

Raw XML string content of the ADML file (XmlContent parameter set).
Optional.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: XmlContent
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -AdmlFileName

Optional filename hint for the ADML source when using the XmlContent parameter set
(e.g.
'ControlPanel.adml').
Populates the AdmlFile and SourceAdml output fields.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: XmlContent
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -AdmlFilePath

File path to a single ADML file (XmlFile parameter set).
Optional; if omitted,
auto-detection is attempted relative to the ADMX file location.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: XmlFile
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -AdmxContent

Raw XML string content of the ADMX file (XmlContent parameter set).

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: XmlContent
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -AdmxFileName

Optional filename hint for the ADMX source when using the XmlContent parameter set
(e.g.
'ControlPanel.admx').
Populates the AdmxFile and SourceFile output fields.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: XmlContent
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -AdmxFilePath

File path to a single ADMX file (XmlFile parameter set).

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: XmlFile
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -AdmxPath

Path to a single ADMX file or a directory containing ADMX files.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: Path
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -All

Return all policy settings from the ADMX file(s) without filtering by registry key or value name.
When specified, -RegistryKey and -ValueName are not required.

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

### -Recurse

When AdmxPath is a directory, recurse into subdirectories to find ADMX files.

```yaml
Type: System.Management.Automation.SwitchParameter
DefaultValue: False
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: Path
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -RegistryKey

The registry key path to match (e.g., 'SOFTWARE\Policies\Microsoft\Edge').
HKLM/HKCU prefixes are stripped automatically.

```yaml
Type: System.String
DefaultValue: ''
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

### -ValueName

The registry value name to match.

```yaml
Type: System.String
DefaultValue: ''
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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutBuffer, -OutVariable, -PipelineVariable,
-ProgressAction, -Verbose, -WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

Function  : Get-AdmxPolicySetting
Author    : John Billekens
Copyright   : (c) John Billekens Consultancy & AppVentiX
Version   : 2026.0307.1000


## RELATED LINKS

- [New-AppVentiXGroupPolicyUserSetting](New-AppVentiXGroupPolicyUserSetting.md)
- [Import-IvantiWCPolicy](Import-IvantiWCPolicy.md)
- [Get-IvantiWCPolicy](Get-IvantiWCPolicy.md)
