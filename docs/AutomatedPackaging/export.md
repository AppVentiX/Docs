# Export packages

A job that succeeds can copy its package to an **export location**. Use this for AppVentiX Central View, or for each tool that gets packages from a folder.

## Set the export location

Set the export location in the application. The command line uses it, but cannot set it.

1. Go to **Settings > Export**.
2. Enter the **Export location**: a full path, for example `\\server\share\packages` or `D:\Packages`.
3. Set **Export every successful package**:
    - On: each job exports, unless its **Advanced** setting is off.
    - Off: a job exports only when its **Advanced** setting is on.
4. Optional: tick **Remove a package from the output folder once it has been exported, with its notes**.
5. Click **Save export**. The next job uses the settings. No restart is necessary.

**Save export** also checks the location. **Check location** does the same check alone. The service makes a test folder, writes a file, replaces it and removes both. It says that the location can be written, or which step failed. A location that fails is still saved, and Settings shows a warning.

An empty location turns export off.

## Permissions

**The service writes every export, as its own account.** On a share, that is the computer account, `<computer name>$`, not your account. The product keeps no credentials for shares.

- In a domain, give the computer account, or a group such as **Domain Computers**, **Change** on the share and **Modify** on the folder.
- The account must be able to **create folders**. Each export first makes a folder for the package.
- In a workgroup, no other computer knows this computer account. Use a local folder, or a share on the host itself.

!!! warning "A share has two sets of permissions"
    An export through `\\server\share` must pass the folder permissions (NTFS) and the share permissions. The default share permission is **Everyone: Read**. With Read on the share, nobody can make a file through the share path, also not an elevated program.

    To test, make a folder in `\\server\share` in Explorer. Or run `Get-SmbShareAccess -Name <share>` on the machine with the share. For a share on the host itself, use the local path as the export location.

## Export one job

=== "GUI"

    In **Advanced…** on the Build screen, set **Export the package** on or off for this job. It is not available while no location is set.

=== "CLI"

    Add `--export` or `--no-export` to `convert`. They override the Settings default for this job.

    ```
    AutomatedPackaging.Cli convert D:\installers\7z2408-x64.msi --certificate-thumbprint <thumbprint> --export
    ```

    `--export` takes no path. With no location set, the run is refused. Exit code 4 means that the package is built, and did not reach the export location.

## What an export writes

```
<location>\<Name>_<Version>_<Architecture>\<Name>_<Version>_<Architecture>.msix
<location>\<Name>_<Version>_<Architecture>\dependencies.txt     only with dependencies or prerequisites
<location>\Certificates\<certificate name>_<thumbprint>.cer     only for a self-signed certificate
```

- The name, version and architecture come from the manifest of the package. For example, `7-Zip_26.3.0.0_x64`.
- A file with the same name is replaced. Nothing else in the folder changes.
- Each file is written with a temporary `.partial` name, then renamed. A reader never sees half a package.
- `dependencies.txt` lists what the target needs first: the dependencies of the package and the prerequisites of the job.
- The certificate file holds only the public key. A certificate from a certificate authority is not exported.
- A folder under the location that is a junction or a symbolic link is refused.

## When the copy fails

The job still ends as succeeded. The package is in the output folder. The job log ends with the warning `AP-PK-010` and the reason.

- The **Jobs** screen shows **Built, not exported**, with the reason under the facts of the job.
- The command line ends with exit code 4.

To try again:

1. Correct the location. **Check location** on **Settings > Export** says if it works now.
2. Select the job on the **Jobs** screen.
3. Click **Export again**.

**Export again** copies the package that the job built, with no worker and no new build. It works only while the package is still in the output folder.

A job waits at most 30 minutes for its export. After that, it shows **Built, not exported**, and the next job can start.
