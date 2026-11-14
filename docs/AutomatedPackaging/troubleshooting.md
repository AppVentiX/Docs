# Troubleshooting

Many failures do not look like their cause. A missing licence file looks like a broken image. A firewall rule looks like a job that did nothing. Find the symptom here before you change things.

`<workingDir>` is the working directory, by default `C:\AutomatedPackaging`. `<dataFolder>` is `%ProgramData%\AppVentiX\Automated Packaging`.

## Where to look

| You want to know | Look here |
|---|---|
| Why a job failed | `<workingDir>\jobs\<job id>\job.log`, or select the job on the **Jobs** screen. The last lines give the `AP-` code |
| What the installer did in the worker | `<workingDir>\jobs\<job id>\Collected files\`. The conversion log of the packaging tool holds the command and the exit code |
| Why an image build or update failed | `<workingDir>\Logs\prep-<worker>-<run id>.log` |
| What hardening changed in a worker | `<workingDir>\Logs\<run id>\image-prep-manifest.json` |
| What host preparation changed | `<workingDir>\Logs\host-preparation-<date>-<time>.json` |
| What the application did | `<workingDir>\Logs\app-<date>.log` |
| What the service did | `<workingDir>\Logs\service-<date>.log` |
| What the command line did | `<workingDir>\Logs\cli-<date>.log` |
| Which PowerShell commands the product sent to a worker | `<workingDir>\Logs\diagnostics-<yyyyMMdd>.log`. One line for each command. It is on by default |

=== "GUI"

    A failed job on the **Jobs** screen shows a failure card: the code, the step, **What to try** and **Copy diagnostic**. A failed image build shows the code under the step list on the Workers screen.

=== "CLI"

    A failed `convert` exits with code 2, and shows the `AP-` code and the detail. With `--json`, the code is in `failureCode`. Exit code 1 lists what stopped the job before it started.

### Turn off the diagnostic trace

The diagnostic trace is on by default. To turn it off, set this registry value on the host:

| Key | Value | Type | Data |
|---|---|---|---|
| `HKEY_LOCAL_MACHINE\Software\AppVentiX\Automated Packaging` | `DiagnosticLogging` | DWORD | `0` turns the trace off. `1`, or no value, keeps it on |

The application, the host service and the command line read the value when they start. After a change, restart the application and the service `AutomatedPackaging`. If the product cannot read the value, the trace stays on. Support can ask you for this file, so turn it on again before you reproduce a problem.

## Installation and host preparation

| Symptom | Cause | What to do |
|---|---|---|
| The MSI stops: "needs the .NET 10 Desktop Runtime (x64)" or "the ASP.NET Core 10 Runtime (x64)" | A runtime is missing | Install both runtimes, then start the MSI again |
| The MSI stops: "The data folder … is not safe to use" | Another account owns or can change the data folder | See [Install](install.md#what-the-installer-does) |
| The MSI stops: "The working directory … is not safe to use" or "must be a folder, not a drive" | A first installation checks a working directory that is already there. An account that is not an administrator owns it or can change it, or it holds a link. Or `WORKINGDIR` is the root of a drive | See [Install](install.md). Delete or move the folder, or give a folder, for example `D:\AutomatedPackaging` |
| SmartScreen or "unknown publisher" on the MSI | A check build is signed for checking, not with a certificate that Windows trusts by default | Expected for a check build |
| Exit code 3010, or the Apply page asks for a restart | Host preparation turned on Hyper-V | Restart, then apply again |
| Exit code 3011, or `hyperv.operatorgroup` still fails | You were added to Hyper-V Administrators | Sign out of Windows and sign in again |
| Host check **Host service in Hyper-V Administrators** warns | `NT SERVICE\AutomatedPackaging` is not in Hyper-V Administrators. MCP clients cannot build a worker until it is | Let **Apply the changes** fix it. Apply adds only that account to only that group. The service uses the group after it starts again. Host preparation restarts it when no job runs |
| MCP `worker_build` stops at step 1: "Operator group: NT SERVICE\AutomatedPackaging is not in Hyper-V Administrators" | Through MCP, the service builds the worker, and Hyper-V Administrators must include its account. The application and the command line do not use the service | Run host preparation and apply **Host service in Hyper-V Administrators**. It adds only that account to only that group. Host preparation then restarts the service when no job runs. If a job runs, restart the service in Services later |
| `hyperv.workervolume` fails | Less than 60 GB free, or the volume is not NTFS or ReFS | Free disk space, or install again on a different volume |
| `product.listener.allow` or `product.sinkhole.allow` fails | No firewall rule lets the service receive the agent port or UDP 53. Without it, a job ends after three minutes and does nothing | Let **Apply the changes** make the rules |
| `product.kms.allow` warns | For one or more of the programs that run the KMS relay, no inbound firewall rule lets a worker reach it on TCP 1688. The program that builds or updates an image runs the relay: the application, the command line (`worker build`, `worker update`), or the service (MCP). The check names the programs that have no rule | Let **Apply the changes** make the missing rules: "Automated Packaging KMS relay", "… (command line)" and "… (service)". Apply leaves the rules that are there already |
| `product.workers.address` warns: "… share 172.31.7.2" | Two workers have the same address | **Update** each worker that it names |
| `product.adk` warns | `oscdimg` is not installed. **Scan and prepare…** is not available | Click **Apply the changes** in host preparation, or install the Deployment Tools manually |
| `product.sinkhole.block` fails | An enabled inbound **Block** rule covers the ports of the service. Windows creates these rules when somebody closes a firewall prompt. Windows applies Block before Allow, and creates the rules again later | Let **Apply the changes** turn them off. Apply turns off only a rule that names a program of this product. It names each other rule and does not change it: a rule with no program, or for a different program, can be on purpose. If such a rule is not necessary, turn it off yourself. This check runs each time on purpose |
| `product.listener.certificate` (**Listener certificate**) fails: "… is not from the current channel authority of this host" | The channel authority of this host was replaced. The certificate of the listener is from the earlier authority. After its build or update, a worker trusts only the current authority, so each job fails `AP-AG-005` | Let **Apply the changes** issue a new certificate for the listener. Host preparation then restarts the service **AppVentiX Automated Packaging** when no job runs, and removes the earlier certificate and its key. If a job runs, restart the service afterwards and apply host preparation again |
| **Listener certificate** passes and says "… certificate(s) have the issuer name of the channel authority…" | A listener certificate from an earlier version of the product stayed in the store when host preparation issued a new one. Host preparation cannot prove that the certificate is its own, so it does not remove it. No job fails because of it | Make sure that the thumbprint is not `serverCertificateThumbprint` in `agent-channel.json`. Then remove the certificate and its key in an elevated PowerShell: `Remove-Item Cert:\LocalMachine\My\<thumbprint> -DeleteKey` |
| `product.service.certificates` (**Certificates of the service**) fails | The service runs as its own account. It reads only the certificate stores of the computer, not your own. A trusted authority of `agent-channel.json` is only in your store, so the service refuses each worker that it issued. Or a signing certificate in the Personal store of the computer has a root that only your store trusts. A job with it fails at the end with `0x800B010A` (`AP-SG-008`) | For an authority, let **Apply the changes** copy it to the computer's store, then restart the service. For a signing certificate, import the root that the check names into **Trusted Root Certification Authorities** of the computer. Or remove the certificate from the Personal store of the computer. Host preparation does not trust a root for you |
| `product.service.certificates` warns | A root or intermediate certificate of a signing certificate is in no store of this computer. When Windows signs, it can get a public root. If it cannot, the job fails with `0x800B010A` (`AP-SG-008`). Worker builds continue | Let the computer get the root from Windows Update. Or import the root and the intermediate certificates into the stores of the computer |
| **Working directory access** fails | Another account can change the folder, or an item has an owner that is not an administrator | Let **Apply the changes** fix it. See [Folder access](prepare-host.md#folder-access). Read the result: it names each item that a different account owns. Apply does not change that owner. Delete each such item yourself; if Windows refuses, run `takeown /a /f <item>` first. A link, or the folder above, stays in the way until you correct it by hand |
| **Data folder access** fails | Another account can change the folder | Let **Apply the changes** fix it |
| "Automated Packaging is already running on this machine" | One instance for each host. A session of another administrator counts | Use the open instance |

## Staging media

| Symptom | Cause | What to do |
|---|---|---|
| **Scan and prepare…** is not available | `oscdimg` is not installed | Install the ADK Deployment Tools, then click **Look again** |
| A release is not in the list | The list was read before you added the ISO | Click **Look again**. The ISOs must be directly in `_import\<release>` |
| "… could not be prepared" | The ISO is not Windows installation media and not Features on Demand media | Check the download |
| A release stays at "Installation media staged. Still needs the Features on Demand ISO…" | Only one of the two ISOs is in the drop folder | Add the other ISO, and scan again |

## Building a worker image

| Step | Symptom | Cause | What to do |
|---|---|---|---|
| Before | **Build image** is not available, with a message about the name | The name rules | Use the prefix, 15 characters at most, letters, digits and hyphens |
| 1 | "This host is not ready to build" | A host check fails | **Prepare this host…** on **Settings > This host** |
| 3 | `AP-HV-008`, "A virtual machine named … already exists" | A failed build left the machine | Remove it under **Incomplete machines**, or use a different name |
| 4 | `AP-IM-014` after 60 minutes | Windows Setup waits on a dialog. Often the edition is not on the media | Open the console of the worker in Hyper-V Manager, and read it |
| 5 | `AP-IM-010`, "The capture driver did not install" | The Features on Demand media is from a different release | Put the correct ISO in the drop folder, and scan again |
| 5 | `AP-IM-009`, or "The packaging tool does not start" at step 11 | The licence file of the packaging tool is missing | Put the licence `.xml` beside the bundle in `Distro\Tools`, then build again |
| 6 | `AP-AG-003` | Host preparation did not make the certificate authority | Run host preparation, start the application again, and build again |
| 6 | "This host issues certificates from channel authority …, but agent-channel.json names … first" (`AP-AG-003`) | The first thumbprint in `trustedAuthorityThumbprints` is not the newest channel authority of this host. After the update, the worker would read **Update required** again. The product stops before it changes the worker | Run host preparation and apply the changes. It puts the authority of this host first. Then update the worker again |
| 7 | `AP-IM-022` | A prerequisite failed | Check its arguments, success codes and detection rule on the **Prerequisites** screen |
| 8 | `AP-IM-015`, "Tamper Protection is on" | Defender Tamper Protection is on in the worker | Use **Rebuild from media** |
| 9 | `AP-IM-021` | Windows did not activate through the KMS server. The message gives the answer | Correct the KMS server, or apply the **KMS relay reachable** firewall rule. Then **Update** |
| 10 | `AP-IM-017` | Calibration recorded nothing, or recorded noise that it cannot exclude | Read the step 5 result in the preparation log. Run **Update** again |

A build that fails or stops keeps its machine. Remove it under **Incomplete machines**.

## Running a job

| Symptom | Cause | What to do |
|---|---|---|
| "The Automated Packaging service does not answer." | The service is stopped, or it stopped when it started | In **Services**, start **AppVentiX Automated Packaging**. If it stops again, read `<workingDir>\Logs\service-<date>.log`. If that file has no new line, read `%ProgramData%\AppVentiX\Automated Packaging\logs\service-<date>.log`. The service writes there when it cannot use the working directory |
| In the Windows System log, event 7024 says that the service stopped with a service-specific error, for example "Incorrect function" | The service stopped when it started, and gave Windows its exit code. Windows prints its own text for that number. That text is not the cause. Exit code 1: the service could not read or prepare its folders, or an error stopped the start. Exit code 2: the local group **AppVentiX Packaging Operators** does not exist. Exit code 3: the service refused the database. `sc start` shows no error for such a start. `Start-Service` and **Services** show it | Read the cause in the service log, as the row above says. For exit code 2, repair the installation |
| "The Automated Packaging service cannot run jobs: the working directory … is not safe to use." | When the service starts, it examines the working directory and the folders above it. It also examines `Logs`, `_import`, `Distro`, `Tools` and `Packages`, where it writes at start. An account that is not an administrator owns one of them or can change it, or one of them holds a link. The message names each problem. The service wrote nothing in the working directory. It refuses each job, and MCP clients get no worker tools. Its log is in `%ProgramData%\AppVentiX\Automated Packaging\logs` | Run host preparation and apply **Working directory access**. Delete each item that it names. Then restart the service |
| "Automated Packaging cannot build workers or start jobs: the working directory … is not safe to use." | The window shows this message when it starts. It examines the same folders as the service, and the message names each problem. The window wrote nothing in the working directory. Its log is in `%ProgramData%\AppVentiX\Automated Packaging\logs`. **Settings > This host** names the problem under **Working directory access**, and **Build**, **Workers**, **OS media** and **Prerequisites** are locked. The window does not remove old job folders. Some actions write in the working directory. They show this message and do nothing. On **Settings**, these are getting the packaging tools, PSF and the client tools. On **Jobs**, they are **Export again**, re-sign, **Sign for release**, **Re-sign a package** and **Free up space** | On **Settings > This host**, click **Prepare this host…** and apply **Working directory access**. Delete each item that it names. Restart the service. Then close the window and start it again |
| "This command uses the working directory, so it did not start." | The command line examines the same folders as the service when it starts. The message names each problem. The command line wrote nothing in the working directory. Its log is in `%ProgramData%\AppVentiX\Automated Packaging\logs`. The exit code is 3. `certificates`, `machines`, `exclusions`, `recipe` and `improvement` use only the data folder, and they still run | Run host preparation and apply **Working directory access**. Delete each item that it names. Then restart the service |
| A certificate is not in the list of the Build screen | It is in your own store, not in the computer store | **Move to this computer** on **Settings > Signing** |
| "No image can build for …" | No image serves the target | Build an image for the target, or select a different target |
| "AP-IM-024: the job was not started. … has no Finish packaging shortcut." | The job is interactive, and the image was built or updated before it got the shortcut | Click **Update** for the worker on the **Workers** screen, or select **Silent** |
| "AP-IM-030: the job was not started. The agent of … is version …" and "Update this worker to use: …" | The job uses a feature that needs a newer agent, for example the built-in engine. The agent in the image of each worker for the target is older | Click **Update** for the worker on the **Workers** screen, or change the job so that it does not use the feature. See [When an image is behind](maintain-images.md#when-an-image-is-behind) |
| "AP-IM-023: the job was not started. … must be updated." | Each image for the target reads **Update required** | Do what each reason says on the **Workers** screen. See [When an image is behind](maintain-images.md#when-an-image-is-behind) |
| "No worker for this image is free." | A job runs on the worker, or the worker is held | Wait. For a hold: **Revert worker** on **Jobs**, or **Put it back** on **Workers** |
| The job fails after three minutes and captured nothing | The agent never connected. Usually the firewall | Run host preparation |
| `AP-IN-017` | Nobody clicked **Finish packaging** before the time of the interactive job ended | Start the job again, or set a longer time in **Advanced** |
| `AP-IN-008` or `AP-IN-010` | The installer waits on a dialog. The silent arguments are not correct | Check the arguments. Read the conversion log in `Collected files` |
| `AP-IN-012` | The installer exit code is not in the accepted list | Check the silent arguments. The detail explains common Windows Installer codes |
| `AP-IN-009` | Something restarted the worker during the capture | Use a switch that stops the restart. For an MSI, keep `REBOOT=ReallySuppress`. For an installer that must restart, use an interactive job on the built-in engine |
| `AP-IN-013` | The installer left work that only a restart can do | Find what the installer replaces at the next start |
| "… are in …\Tools, but they are not one of the Windows SDK build tools' files" | A file in the tools folder of the working directory is not one of the build tools. A tool can load a DLL from its own folder, so it does not run. The note `.what-goes-here.txt`, `adksetup.exe` and folders such as `psf` are permitted | Find out who put the file there, and delete it. Then start the job again. Do not keep other files in this folder |
| "The installer finished. Then MakeAppx refused the package that the packaging tool made: …" | The install worked. Then MakeAppx refused what the packaging tool captured. The installer is not the cause | Send the support information of the job with the error after the colon |
| `AP-SG-010` | Another account can change the tools or the packages | Run host preparation, and apply **Working directory access** |
| `AP-SG-008` | Signing failed. For example, a token waited for a PIN | **Retry signing** on the **Jobs** screen |
| `AP-PK-010`, **Built, not exported** | The copy to the export location failed. Usually permissions of the computer account | See [Export packages](export.md#permissions), then **Export again** |
| `AP-PK-010` with "is not the package this job built" | Another job with the same name and version replaced the file in the output folder | Build the job again |
| `AP-VF-001` with "The shortcut variable 'Desktop' is not supported" | Windows 11 22H2 refuses a package with a desktop shortcut | Use a Windows 11 24H2 or later worker, or turn off the desktop shortcut of the installer |
| `AP-VF-002` or `AP-VF-003` | The application did not start, or closed at once | Often an application that writes to its own folder. Try the Package Support Framework |
| "The smoke test did not find the PSF fixup …" | The application started, but the fixup of the Package Support Framework did not load in it. The package was built | Test the package on a target computer before you use it. Without the fixup, the application cannot write in its own folder |
| `AP-AG-008` | The worker refused its password. Workers built before 0.2.14 have a password that expires after 42 days | Run `Repair-WorkerPassword.ps1` from the product `scripts\image` folder, then **Update** the worker. Or use **Rebuild from media** |
| "Attempt 1 of 2 hit a transient infrastructure failure…" | One automatic retry after a lost connection | Nothing, unless the second attempt also fails |

## Common error codes

This is the short list. [Error codes](error-codes.md) has every code, with its cause and what to do.

| Code | Meaning |
|---|---|
| `AP-HV-007` | The worker runs a job, or is held |
| `AP-HV-008` | The worker could not be created |
| `AP-NW-005` | The connection to the agent was lost. Retried once |
| `AP-NW-006` | The DNS sinkhole does not work. Run host preparation |
| `AP-NW-007` | The job uploaded more than the host accepts |
| `AP-AG-005` | The agent stopped in the worker. Retried once |
| `AP-IM-009` | The licence of the packaging tool is not in the image |
| `AP-IM-010` | The capture driver is not in the image |
| `AP-IM-014` | Windows did not complete its installation |
| `AP-IN-009` | The worker restarted during the capture. A retry gives the same result |
| `AP-IN-012` | The installer did not report success |
| `AP-IN-013` | The installer left work that only a restart can do |
| `AP-AN-011` | The installer declares a Windows service. Only a note |
| `AP-AN-012` | The file cannot be read as an installer. Often an incomplete download |
| `AP-AN-013` | The installer installs a driver. The job is refused |
| `AP-LC-006` | The starter allowance is used. Install a licence |
| `AP-PK-005` | The package has nothing to start. The installer made no Start menu shortcut |
| `AP-SG-008` | The package could not be signed. Use **Retry signing** |
| `AP-SG-011` | The package changed after the job built it. Build the job again |
| `AP-SG-014` | An AI agent's job signed with a test certificate. The product does not export it. Use **Sign for release** on the **Jobs** screen |
| `AP-VF-004` | The certificate is not trusted on the target. The package is correct |

On MCP, the tool `explain_code` gives the cause and remedy of each code.

## The support information

**Settings > Diagnostics > Collect support information** writes one redacted zip file. See [Settings](settings.md#diagnostics). Read it, then send it with a problem report. Add the `Collected files` folder of the job when the problem is in a job.

The product writes one file at a time. The folder keeps the newest five files and removes older ones. A log larger than 8 MB goes in with its last 8 MB only, and the file says so.

## Report a finding while you test

When you test a build, an AI can help you write down what you find. It asks for the build first, then asks questions about each problem, and writes a Markdown file for each day. Give it this as your first message:

```{.text .wrap}
Read https://docs.appventix.com/AutomatedPackaging/tester-kit-instructions/ and follow the instructions on it. Start a findings session.
```

For an AI tool that works in a folder, download the tester kit instead. [Report findings with an AI](tester-kit.md) has both ways, and how to send the files.
