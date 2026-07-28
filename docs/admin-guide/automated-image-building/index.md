# Automated Image Building and Deployment Actions

## Image Build Events

AppVentiX is often used as part of automated image building procedures. To check if AppVentiX has finished pre-caching packages in the image, the below PowerShell scripts can be used. The script will check the AppVentiX finished event and then continue.

### App-V: Check for Pre-Cached Event (Event ID 122)

```powershell
$eventlogname = "AppVentiX Agent"

# Check for all packages pre-cached event
Do {
    $allpackagesloadedevent = Get-EventLog -LogName $eventlogname -Source "APPV" -Newest 5 |
        Where-Object { $_.InstanceId -eq 122 }
    if ($allpackagesloadedevent) {
        Write-Host "Finished, all App-V packages are pre-cached"
    }
    else {
        Write-Host "Not finished, sleep 30 seconds"
        Start-Sleep -Seconds 30
    }
} While (!$allpackagesloadedevent)
```

### MSIX: Check for Refresh Cycle Finished Event (Event ID 2000)

```powershell
$eventlogname = "AppVentiX Agent"

# Check for refresh cycle finished event
Do {
    $allpackagesloadedevent = Get-EventLog -LogName $eventlogname -Source "Service" -Newest 5 |
        Where-Object { $_.InstanceId -eq 2000 }
    if ($allpackagesloadedevent) {
        Write-Host "Refresh cycle finished, all MSIX packages are pre-cached"
    }
    else {
        Write-Host "Not finished, sleep 30 seconds"
        Start-Sleep -Seconds 30
    }
} While (!$allpackagesloadedevent)
```

> **Note for MSIX App Attach:** It is not recommended to place App Attach packages on a content store configured for a machine group where the build VM is a member. App Attach packages are not needed to pre-cache in the image because they are virtual disks attached to the VM at runtime.

---

## Run the Refresh Cycle from the Command Line

The refresh cycle automatically runs when the machine boots. The refresh cycle can also be invoked from the Agent GUI, based on a timer, or remotely through the Central View console (recommended).

It is also possible to invoke the refresh cycle with PowerShell:

```powershell
(Get-Service 'AppVentiXService').ExecuteCommand(254)
```

---

## When Central View Console Takes Longer to Start

When the machine running the Central View console does not have internet access, the console can be slow to start. This is default behaviour for .NET applications that are signed with a certificate: because there is no internet connection, the Microsoft CRL checking process cannot check the certificate used to sign the AppVentiX executables.

To work around the issue:

| Solution | Steps |
|----------|-------|
| Disable CRL checking machine-wide | Control Panel, Internet Options, Advanced. Under Security, uncheck the "Check for publisher's certificate revocation" option. |
| Manually update the CRL | Download and install the latest CRL manually. |
| Enable internet access | Allow outbound connections for certificate validation. |

> **Note:** AppVentiX does not make any internet (outbound) connections at all, so internet access is not needed for AppVentiX to work. Also make sure to check the connection to the central configuration store. The further the Central View console is placed from the central configuration store, the longer it can take to retrieve the configuration.
