# New-AppVentiXGroupPolicyUserSetting

Creates a new AppVentiX Group Policy user setting XML file from ADMX/ADML policy definitions.

## Syntax

```powershell
# Parameter Set: AppVentiXParamsFile
New-AppVentiXGroupPolicyUserSetting
    -FriendlyName <String>
    [-Description <String>]
    [-ExecutionOrder <Int32>]
    [-ProcessAtLogin]
    [-ProcessAtRefresh]
    [-ProcessAtReconnectAndUnlock]
    [-MachineGroupFriendlyName <String>]
    -AdmxFilePath <String>
    [-AdmlFilePath <String>]
    [-AdmlLanguage <String>]
    -PolicyInputObject <PSCustomObject[]>
    [<CommonParameters>]

# Parameter Set: AppVentiXParamsContent
New-AppVentiXGroupPolicyUserSetting
    -FriendlyName <String>
    [-Description <String>]
    [-ExecutionOrder <Int32>]
    [-ProcessAtLogin]
    [-ProcessAtRefresh]
    [-ProcessAtReconnectAndUnlock]
    [-MachineGroupFriendlyName <String>]
    -AdmxContent <String>
    -AdmxFileName <String>
    [-AdmlContent <String>]
    [-AdmlFileName <String>]
    [-AdmlLanguage <String>]
    -PolicyInputObject <PSCustomObject[]>
    [<CommonParameters>]

# Parameter Set: InputObject
New-AppVentiXGroupPolicyUserSetting
    -InputObject <PSCustomObject>
    [<CommonParameters>]
```

## Description

The `New-AppVentiXGroupPolicyUserSetting` function creates a new AppVentiX user setting XML file that applies Group Policy settings based on ADMX/ADML policy template definitions. ADMX and ADML content can be provided either as file paths or as inline string content.

This function has the alias `New-AppVentiXGroupPolicy`.

## Parameters

### -FriendlyName

The display name for the Group Policy user setting.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -Description

An optional description for the Group Policy user setting.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -ExecutionOrder

The execution order for this user setting relative to others.

| | |
|---|---|
| Type: | Int32 |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -ProcessAtLogin

When specified, the Group Policy setting is processed at user login.

| | |
|---|---|
| Type: | SwitchParameter |
| Position: | Named |
| Default value: | False |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -ProcessAtRefresh

When specified, the Group Policy setting is processed at refresh.

| | |
|---|---|
| Type: | SwitchParameter |
| Position: | Named |
| Default value: | False |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -ProcessAtReconnectAndUnlock

When specified, the Group Policy setting is processed at reconnect and unlock.

| | |
|---|---|
| Type: | SwitchParameter |
| Position: | Named |
| Default value: | False |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -MachineGroupFriendlyName

The friendly name of the machine group to associate with this user setting.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | All Machine Groups |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -AdmxFilePath

The full path to the ADMX template file. Used with the AppVentiXParamsFile parameter set.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -AdmlFilePath

The full path to the ADML language file. Optional when using the AppVentiXParamsFile parameter set.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -AdmxContent

The raw XML content of the ADMX template. Used with the AppVentiXParamsContent parameter set.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -AdmxFileName

The filename to associate with the ADMX content when using inline content.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -AdmlContent

The raw XML content of the ADML language file. Optional when using the AppVentiXParamsContent parameter set.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -AdmlFileName

The filename to associate with the ADML content when using inline content.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -AdmlLanguage

The language code for the ADML file (e.g., 'en-US').

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | en-US |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -PolicyInputObject

An array of PSCustomObject items representing the individual policy settings to apply. Each object should describe a policy name and its configured value.

| | |
|---|---|
| Type: | PSCustomObject[] |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -InputObject

A PSCustomObject containing all Group Policy properties including embedded ADMX/ADML content. Used when piping output from `Get-IvantiWCPolicy` or similar functions.

| | |
|---|---|
| Type: | PSCustomObject |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | True |
| Accept wildcard characters: | False |

## Examples

### Example 1: Create a Group Policy setting from ADMX files

```powershell
$policies = Get-AdmxPolicySetting -Path "C:\ADMX\MyApp.admx" | Where-Object { $_.PolicyName -eq "DisableFeatureX" }
New-AppVentiXGroupPolicyUserSetting -FriendlyName "Disable Feature X" -AdmxFilePath "C:\ADMX\MyApp.admx" -AdmlFilePath "C:\ADMX\en-US\MyApp.adml" -PolicyInputObject $policies -ProcessAtLogin
```

Creates a Group Policy user setting from ADMX and ADML files.

## Notes

- Requires a valid AppVentiX license
- This function has the alias `New-AppVentiXGroupPolicy`
- ADMX and ADML content is embedded directly into the AppVentiX user setting XML

## Related Links

- [Get-AdmxPolicySetting](Get-AdmxPolicySetting.md)
- [Get-IvantiWCPolicy](Get-IvantiWCPolicy.md)
- [Import-IvantiWCPolicy](Import-IvantiWCPolicy.md)
- [Set-AppVentiXUserSettingsAssignment](Set-AppVentiXUserSettingsAssignment.md)
- [Get-AppVentiXUserSettings](Get-AppVentiXUserSettings.md)
