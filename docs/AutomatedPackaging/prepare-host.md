# Prepare the host

Host preparation is `AutomatedPackaging.PrepareHost.exe`, beside the application. It checks the host and fixes what it can. It turns on Hyper-V, creates an internal virtual switch, and adds you to Hyper-V Administrators. It creates a certificate authority and the listener certificate. It adds firewall rules for the DNS responder, the agent listener and KMS activation. It also creates the data folders, closes them and the working directory to other accounts, installs the ADK Deployment Tools, and writes two configuration files.

=== "GUI"

    1. Start **Automated Packaging** from the Start menu.
    2. Go to **Settings > This host**, and click **Prepare this host…**.

    The wizard has eight pages, with a bar across the top. **Only the last page changes the host.** The blue button at the bottom right is the next step: **Next** on pages 1 to 7, then **Apply the changes**.

    ![Host preparation, page 1: What this will change](images/wizard-what-changes.png)

    | # | Page | What it does |
    |---|---|---|
    | 1 | **What this will change** | Lists every change to the host that host preparation can make |
    | 2 | **Working directory** | Shows the folder selected at installation, read-only, and the folders it creates in it |
    | 3 | **The hypervisor** | The Hyper-V settings: **Virtual switch** (`PkgRobot-Internal`), **Host address** (`172.31.7.1`), **Host port** (`8443`), **Managed name prefix** and **Worker folder** |
    | 4 | **This host** | All checks, in two tables. Filter on **In the way**, **Worth knowing** or **Fine**. The last column says what happens to each item. **Re-read this host** reads the host again. **Listener port** fails when another program listens on the port of the listener, `8443` by default |
    | 5 | **Media** | What a worker is built from, the folder for each item, and what is missing. **Download** gets `adksetup.exe` into `<workingDir>\Tools` |
    | 6 | **Accounts** | The account in a new worker (`pkgbuilder`), and its password |
    | 7 | **The authority** | The private certificate authority that workers use to authenticate. Created if it is not there |
    | 8 | **Apply** | Lists what **Apply the changes** fixes. After the run, it shows what is done, what did not work, and what is still in the way |

    !!! warning "Leave three settings at their defaults"
        - The application attaches workers to the switch `PkgRobot-Internal`, and keeps them in `<workingDir>\Workers`. Leave **Virtual switch** and **Worker folder** at their defaults on page 3.
        - **Managed name prefix** on page 3 shows `PKG-`. The application uses the prefix under **Settings > Advanced**, `PKGMGR-` by default.
        - Workers built from the Workers screen always use the account `pkgbuilder` and a generated password, whatever page 6 shows.

    ![Host preparation, page 3: The hypervisor. Managed name prefix shows PKG-](images/wizard-hypervisor.png)

    Page 5, **Media**, shows what a worker is built from, and the folder for each item:

    ![Host preparation, page 5: Media](images/wizard-media.png)

    ### After Apply

    | The Apply page says | Do this |
    |---|---|
    | "This machine has to restart before they take effect…" | Click **Restart now**. The wizard opens again at your next sign-in, on the Apply page. Click **Apply the changes** again. Set again any value that you changed on the other pages |
    | "Sign out and back in before running a job…" | Sign out of Windows and sign in again. You are now in Hyper-V Administrators, and Windows reads the groups at sign-in |
    | "This host is ready. Close the Automated Packaging window and open it again…" | Close the application and start it again. It reads `agent-channel.json` and `media.json` only when it starts |

    Below the result, the Apply page says what host preparation did with the service **AppVentiX Automated Packaging**:

    | The Apply page says | Do this |
    |---|---|
    | "Host preparation restarted the AppVentiX Automated Packaging service…" | Nothing. The service uses the new settings |
    | "…because a restart stops the jobs that run: …" | Let the jobs that it names end. Then restart the service in **Services** |
    | "…because the service did not say whether a job runs…" | When no job runs, restart the service in **Services** |
    | "The AppVentiX Automated Packaging service is stopped…" | Nothing. The service reads the new settings when it starts |

    Host preparation restarts the service only when the service says that no job runs, because a stop of the service stops each job. When the machine has to restart, it leaves the service alone.

=== "CLI"

    Run host preparation without a window, from an elevated prompt:

    ```
    AutomatedPackaging.PrepareHost.exe --check  [--report <path>]
    AutomatedPackaging.PrepareHost.exe --apply  [--report <path>]
    ```

    - `--check` changes nothing. It lists what `--apply` would do.
    - `--apply` fixes what it can. After a change, it restarts the service **AppVentiX Automated Packaging** when no job runs. Its last line says what it did with the service, as the GUI tab shows.
    - `--set <name>=<value>` gives a hypervisor setting. `--help` shows the other options.

    | Exit code | Meaning |
    |---|---|
    | 0 | The host is ready |
    | 1 | Something still stops the host, or a fix was refused |
    | 2 | It could not run: incorrect arguments, or no hypervisor |
    | 3010 | Fixes applied. Restart the host, then run `--apply` again |
    | 3011 | Fixes applied. Sign out of Windows and sign in again |

    !!! note "In a script"
        The program is a window program that uses your console. In `cmd`, the prompt comes back before the report shows. To get the exit code, wait for the process: `start /wait` in `cmd`, or `Start-Process -Wait -PassThru` in PowerShell.

    The `--working-dir <path>` option is ignored on a host installed from the MSI. The registry value of the installer wins. Select the working directory with `WORKINGDIR=` at installation.

Each run writes a record to `<workingDir>\Logs\host-preparation-<date>-<time>.json`.

## Folder access

The application runs elevated. It runs the signing tools in `<workingDir>\Tools`, and it reads its settings from the data folder. So host preparation closes both folders to other accounts. Two checks on the **This host** page show the state.

**Working directory access** gives full control to `Administrators`, `SYSTEM` and `Hyper-V Administrators`, and **Modify** to `NT VIRTUAL MACHINE\Virtual Machines`. It removes the entries of other accounts in the folder tree. The fix does not change the owner of an item. When an item has an owner that is not an administrator, the result names each such item, and the check fails until it is gone. Find out what each item is, and delete it. If Windows refuses, run `takeown /a /f <item>` first, then delete it. Media that you copied in before the folder was closed can be such an item: delete it and copy it again.

When the working directory does not exist, the product creates it closed: only `Administrators`, `SYSTEM`, `Hyper-V Administrators` and the virtual machines that Hyper-V runs can change it. A working directory that exists already is not changed when the product starts.

**Data folder access** gives full control to `Administrators`, `SYSTEM` and `Hyper-V Administrators` only. Standard users can then not read the data folder.

Host preparation stops and changes nothing if the folder tree holds a link: a junction, a symbolic link or a hard link. Remove the link, or move its target into the tree. Host preparation does not change the folders above the working directory. If another account can change one of them, the check says so. Correct that folder yourself.

A job does not start while another account can change the tools or the packages. It stops with `AP-SG-010` and names the account and the folder.

What this means every day:

- An Explorer window that is not elevated cannot open these folders. Use an elevated Explorer or PowerShell, or the application.
- If Explorer offers **Continue**, it adds an entry for your account. The checks accept this for an account that is directly a member of `Administrators`.

Next: [Stage media](stage-media.md).
