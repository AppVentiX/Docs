@{
    # ----------------------------------------------------------------------
    # Category resolution for the AppVentiX PowerShell command reference.
    #
    # Resolution order (see Build-CommandReference.ps1):
    #   1. Explicit override in 'Overrides' (exact command name).
    #   2. First matching rule in 'Patterns' (wildcard against command name).
    #   3. Fallback category 'uncategorized'.
    #
    # 'Categories' defines BOTH the menu order and the friendly section title.
    # A category id used in Patterns/Overrides must exist here.
    # ----------------------------------------------------------------------

    Categories = @(
        @{ Id = 'configuration';     Title = 'Configuration Commands' }
        @{ Id = 'license';           Title = 'License Commands' }
        @{ Id = 'machine-group';     Title = 'Machine Group Commands' }
        @{ Id = 'package';           Title = 'Package Commands' }
        @{ Id = 'publishing-task';   Title = 'Publishing Task Commands' }
        @{ Id = 'seamless';          Title = 'Seamless Publishing Commands' }
        @{ Id = 'user-settings';     Title = 'User Settings Commands' }
        @{ Id = 'diagnostics';       Title = 'Diagnostics Commands' }
        @{ Id = 'migration-appv';    Title = 'App-V Management Migration' }
        @{ Id = 'migration-ivanti';  Title = 'Ivanti Workspace Control Migration' }
        @{ Id = 'uncategorized';     Title = 'Other Commands' }
    )

    # Wildcard rules, evaluated top-to-bottom. Convention-over-configuration:
    # most commands land in the right bucket purely by name.
    Patterns = @(
        @{ Match = '*Seamless*';            Category = 'seamless' }
        @{ Match = '*PublishingTask*';      Category = 'publishing-task' }
        @{ Match = '*UserSetting*';         Category = 'user-settings' }
        @{ Match = '*IvantiWC*';            Category = 'migration-ivanti' }
        @{ Match = 'Get-AdmxPolicySetting'; Category = 'migration-ivanti' }
        @{ Match = '*AppVManagement*';      Category = 'migration-appv' }
        @{ Match = '*Licen*';               Category = 'license' }
        @{ Match = '*MachineGroup*';        Category = 'machine-group' }
        @{ Match = '*Package*';             Category = 'package' }
        @{ Match = '*ConnectionGroup*';     Category = 'package' }
        @{ Match = '*ConfigShare*';         Category = 'configuration' }
        @{ Match = '*ADCredential*';        Category = 'configuration' }
        @{ Match = '*DebugLogging*';        Category = 'diagnostics' }
    )

    # Exact-name overrides win over patterns. Use for the odd ones out.
    Overrides = @{
        'Get-AppVentiXModuleVariable' = 'diagnostics'
    }
}
