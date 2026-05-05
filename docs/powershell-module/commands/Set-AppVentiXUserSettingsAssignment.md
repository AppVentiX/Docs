# Set-AppVentiXUserSettingsAssignment

Assigns an Active Directory group to an AppVentiX user setting.

## Syntax

```powershell
Set-AppVentiXUserSettingsAssignment
    -Id <String>
    -ADGroup <String>
    [-DomainFQDN <String>]
    [-ADGroupSID <String>]
    -Type <String>
    [<CommonParameters>]
```

## Description

The `Set-AppVentiXUserSettingsAssignment` function assigns an Active Directory group to an existing AppVentiX user setting. The assignment controls which users receive the user setting based on their AD group membership. The type of user setting must be specified to ensure the assignment is applied to the correct XML file.

## Parameters

### -Id

The unique identifier (filename without extension) of the user setting to assign the AD group to.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | True |
| Accept wildcard characters: | False |

### -ADGroup

The name of the Active Directory group to assign to the user setting.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -DomainFQDN

The fully qualified domain name (FQDN) of the domain containing the AD group.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | $Env:USERDNSDOMAIN |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -ADGroupSID

The Security Identifier (SID) of the AD group. When provided, the SID is stored alongside the group name.

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

### -Type

The type of user setting to assign the AD group to. Must be one of the following values:

- `EnvironmentVariables`
- `PrinterMapping`
- `DriveMapping`
- `GroupPolicy`
- `RegistrySettings`
- `Shortcuts`

| | |
|---|---|
| Type: | String |
| Position: | Named |
| Default value: | None |
| Accept pipeline input: | False |
| Accept wildcard characters: | False |

## Examples

### Example 1: Assign an AD group to a drive mapping

```powershell
Set-AppVentiXUserSettingsAssignment -Id "HomeDrive_UserSetting" -ADGroup "Domain Users" -Type DriveMapping
```

Assigns the 'Domain Users' AD group to the specified drive mapping user setting.

### Example 2: Assign with explicit domain FQDN

```powershell
Set-AppVentiXUserSettingsAssignment -Id "OfficeShortcuts" -ADGroup "Office Users" -DomainFQDN "domain.local" -Type Shortcuts
```

Assigns the 'Office Users' AD group in the specified domain to a shortcut user setting.

### Example 3: Assign with a group SID

```powershell
Set-AppVentiXUserSettingsAssignment -Id "PrinterConfig" -ADGroup "Print Users" -ADGroupSID "S-1-5-21-..." -Type PrinterMapping
```

Assigns an AD group by name and SID to a printer mapping user setting.

## Notes

- Requires a valid AppVentiX license
- The Type parameter must match the category of the target user setting XML file

## Related Links

- [Get-AppVentiXUserSettings](Get-AppVentiXUserSettings.md)
- [New-AppVentiXDriveMappingUserSetting](New-AppVentiXDriveMappingUserSetting.md)
- [New-AppVentiXEnvironmentVariableUserSetting](New-AppVentiXEnvironmentVariableUserSetting.md)
- [New-AppVentiXPrinterMappingUserSetting](New-AppVentiXPrinterMappingUserSetting.md)
- [New-AppVentiXRegistryUserSetting](New-AppVentiXRegistryUserSetting.md)
- [New-AppVentiXShortcutUserSetting](New-AppVentiXShortcutUserSetting.md)
- [New-AppVentiXGroupPolicyUserSetting](New-AppVentiXGroupPolicyUserSetting.md)
