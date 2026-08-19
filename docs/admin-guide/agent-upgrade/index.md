# Upgrading the Agent

An upgrade uses the same three installation methods as a new install: push agent, GUI, or silent. See [Install the AppVentiX Agent](../../quickstart/agent-installation.md) for details.

If users are logged in to the machine, the agent is upgraded without them noticing anything.

The agent reuses its existing connection string, so it does not need to be specified again. A silent upgrade therefore only needs:

```cmd
msiexec /i "AppVentiX Agent.msi" /quiet
```

Passing `CONNECTIONSTRING` anyway is allowed and will not break the installation.

!!! note
    An upgrade keeps the existing connection details. To change how an installed agent reaches the configuration store, for example after switching to a service account, see [Service Accounts](../service-accounts/index.md).
