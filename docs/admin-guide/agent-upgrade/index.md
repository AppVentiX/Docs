# Upgrading the Agent

An upgrade uses the same three options as a new installation, push agent, GUI or silent, see [Install the AppVentiX Agent](../../quickstart/agent-installation.md). When an older version is detected, it is upgraded automatically and users can stay logged in.

The connection string does not have to be specified again, because the agent reuses the one it is already configured with. A silent upgrade therefore only needs:

```cmd
msiexec /i "AppVentiX Agent.msi" /quiet
```

Passing `CONNECTIONSTRING` anyway is allowed and will not break the installation.

!!! note
    An upgrade keeps the existing connection details. To change how an installed agent reaches the configuration store, for example after switching to a service account, see [Service Accounts](../service-accounts/index.md).
