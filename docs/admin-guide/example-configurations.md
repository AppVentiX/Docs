# Example Configurations of the AppVentiX Agent

The following examples can give you insight into how AppVentiX can be configured. These configurations are validated to work, but they are only intended to give you an idea of the possibilities. They can be used as a guideline but are not written down here to serve as best practice or recommended configuration.

Feel free to contact [support@appventix.com](mailto:support@appventix.com). We are always happy to discuss which approach is the best for your environment.

---

## App-V Scenarios

### Non-Persistent Machines with App-V

- Move the cache to a persistent drive (for example the same one as the write cache)
- Configure in the AppVentiX agent settings to detect the image state (do not deploy packages when in read/write mode)
- Configure the agent to clean the cache after reboot (needed because the drive is persistent)
- Use SCS mode in combination with the mount specific packages option (mount packages that either perform better when fully cached or if you want them to be highly available). This combination gives you the best of both worlds.

### Large Scale Non-Persistent VDI with App-V

- Keep the cache on the default location
- Enable the detect image state option and configure to mount all packages in the cache in private mode and use SCS mode when in read-only mode
- The rest of the configuration will be configured automatically according to the above setting

In this deployment mode, when the image is booted in private mode (during Windows update or build update), all the latest packages will be mounted in the cache automatically. An event will be logged when the pre-cache operation is done (you can configure your automatic build method to check for this event).

When the image is in read-only mode, new packages can be deployed to the machines. In read-only mode, new packages will be added automatically by using SCS mode (reading package content directly from the share). In this way the write cache is not polluted.

This deployment mode gives you the best of both worlds in large VDI deployments: lower IO during boot and the ability to deploy packages and application updates during runtime of the machine.

### Persistent Machines with App-V (RDS/AVD and Physical Machines)

- Keep the cache on the default location
- Do not clean the cache at machine reboot
- Configure the AppVentiX agent to remove packages that are no longer on the source share (keep cache in balance with source)
- Use SCS mode in combination with the mount specific packages option (mount packages that either perform better when fully cached or if you want them to be highly available). This combination gives you the best of both worlds. Or mount all packages by default if disk space is not an issue.

---

## MSIX Scenarios

### Non-Persistent Machines with MSIX

- Leave the MSIX cache location at default or redirect to a persistent drive in the agent settings
- Configure the AppVentiX agent to detect the image state (agent setting). Do not deploy packages when in read/write mode. In this scenario, only deploy packages when the image is read-only.
- You can use both MSIX App Attach and normal MSIX package delivery. Normal packages will be cached on the persistent drive or temporary write cache location (depending on whether you redirected the cache in the agent settings).
- Clean the MSIX cache after reboot (agent setting) when redirected to a persistent drive
- Using the above combination gives you the best of both worlds in terms of space utilization and performance.

### Large Scale Non-Persistent VDI with MSIX

- Keep the cache on the default location
- Enable the detect image state option and configure to load all packages in the cache in private mode
- Place all MSIX packages on a content store with the pre-cache option enabled
- Place MSIX App Attach packages on a content store with pre-cache disabled

In this deployment mode, when the image is booted in private mode (during Windows update or build update), all the latest MSIX packages will be loaded in the cache automatically. An event will be logged when the pre-cache operation is done.

When the image is in read-only mode you can deliver MSIX packages through App Attach to users, which will not consume any disk space. You can also decide to deliver all packages through App Attach, but this example will give you an indication of the possibilities with AppVentiX to achieve the best possible combination.

This deployment mode gives you the best of both worlds in large VDI deployments: lower IO during boot (MSIX packages already exist in the image) and the ability to deploy packages and apply application updates during runtime of the machine.

### Persistent Machines with MSIX (RDS/AVD and Physical Machines)

- Keep the cache on the default location
- Do not clean the cache at machine reboot
- Configure the AppVentiX agent to remove packages that are no longer on the source share (keep cache in balance with source). This is enabled by default.
- You can use a combination of normal MSIX deployment and MSIX App Attach:
  - Use normal MSIX delivery to have less pressure on the content store (packages are loaded in the cache and published from there to users). Also when the share goes down there is less downtime (App Attach needs constant availability to the content store). Because packages are published from the local cache of the machine, the application might work faster.
  - Use App Attach to save disk space on the machines and speed up the registration of bigger packages (the package does not have to be loaded on the machine; package data will be accessed over the network through the attached disk).

---

With AppVentiX you are in complete control over the deployment. There is always a combination available that suits your use case the best. Feel free to contact [support@appventix.com](mailto:support@appventix.com). We are always happy to discuss which approach is the best for your environment.
