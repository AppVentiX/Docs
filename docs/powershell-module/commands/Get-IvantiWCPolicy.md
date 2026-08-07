---
category: migration-ivanti
category_title: Ivanti Workspace Control Migration
document type: cmdlet
external help file: AppVentiX-Help.xml
HelpUri: ''
Locale: en-US
Module Name: AppVentiX
module_version: 2026.806.1845
ms.date: 08-07-2026
PlatyPS schema version: 2024-05-01
title: Get-IvantiWCPolicy
---

# Get-IvantiWCPolicy

## SYNOPSIS

Reads, decodes, and correlates Ivanti Workspace Control policy sets from a Building Block XML file.

## SYNTAX

### AppVentiX (Default)

```
Get-IvantiWCPolicy -Path <string> [-IncludeADMFiles] [-ExportFor <string>]
 [-IncludePolicyDescription] [<CommonParameters>]
```

### Export

```
Get-IvantiWCPolicy -Path <string> -SaveResourceFiles -ExportPath <string> [-IncludeADMFiles]
 [-ExportFor <string>] [-IncludePolicyDescription] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,

## DESCRIPTION

Reads an Ivanti Workspace Control Building Block XML file, pre-loads all embedded ADMX/ADML
templates, and processes each policy set found within the file.
For each policy set it correlates
the applied registry settings with their ADMX definitions (via Get-AdmxPolicySetting) and returns
a structured PowerShell object per policy set.

Supports two export modes via -ExportFor:
- WEM: returns correlated policy data only (default).
- AppVentiX: additionally returns an AppVentiXParams property containing pre-structured policy
  data ready to pass directly to New-AppVentiXGroupPolicy -PolicyInputObject.

Policy state (Enabled/Disabled/Unconfigured) is determined in priority order:
1.
POLICY:1/2 indicator from the embedded PolicySettings data.
2.
Policy-level registry value compared against ADMX enabledValue/disabledValue.
3.
Presence of element-level registry values (implies Enabled).

List-type ADMX elements (values stored as numbered entries under a sub-key) are fully supported.
Boolean elements with explicit trueValue/falseValue nodes are resolved correctly.

## EXAMPLES

### EXAMPLE 1

# Export policy data for use with AppVentiX
$Policies = Get-IvantiWCPolicy -Path 'C:\temp\LAB-BB.xml' -IncludeADMFiles -ExportFor AppVentiX
$result = $Policies | ForEach-Object {
    New-AppVentiXGroupPolicy `
        -FriendlyName $_.Name `
        -AdmxContent $_.ADMXContent `
        -AdmxFileName $_.ADMX `
        -AdmlContent $_.ADMLContent `
        -AdmlFileName $_.ADML `
        -PolicyInputObject $_.AppVentiXParams
}

### EXAMPLE 2

# Inspect correlated policy data as JSON
Get-IvantiWCPolicy -Path 'C:\temp\LAB-BB.xml' | ConvertTo-Json -Depth 5

### EXAMPLE 3

# Save decoded resource files for inspection
Get-IvantiWCPolicy -Path 'C:\temp\LAB-BB.xml' -SaveResourceFiles -ExportPath 'C:\temp\TempPolicy'

## PARAMETERS

### -ExportFor

Target export format.
'AppVentiX' adds the AppVentiXParams property to each output object.

```yaml
Type: System.String
DefaultValue: AppVentiX
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

### -ExportPath

Directory path where decoded resource files are saved when -SaveResourceFiles is used.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: Export
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -IncludeADMFiles

If specified, includes the ADMX and ADML filenames and their base64-encoded content in the output
for each policy set.
Required when piping output to New-AppVentiXGroupPolicy.

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

### -IncludePolicyDescription

If specified, includes the ADMX ExplainText (policy description) in the PolicySettings output.

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

### -Path

Path to the Ivanti Workspace Control Building Block XML file.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -SaveResourceFiles

If specified, saves the decoded ADMX/ADML files and the raw PolicySettings/RegistryFile data
to disk at the path specified by -ExportPath.

```yaml
Type: System.Management.Automation.SwitchParameter
DefaultValue: False
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: Export
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

## NOTES

Function  : Get-IvantiWCPolicy
Author    : John Billekens
Copyright   : (c) John Billekens Consultancy
Version   : 2026.0308.1500


## RELATED LINKS

- [Import-IvantiWCPolicy](Import-IvantiWCPolicy.md)
