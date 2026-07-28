# Create signing certificate for App Control Policies

App Control policies can be signed to protect them from tampering. To improve security, signed policies cannot be changed or removed after deployment to an Agent machine, unless the new policy is signed with a trusted certificate. This prevents an attacker, or even a local administrator, from disabling or replacing the policy.

> **NOTE**: For the policy sign option you'll need version 5.2.36 or higher.

Click **Configure Certificate for Policy Signing**.

![Click Configure Certificate for Policy Signing](app-control-create-certificate-01.png)

> **NOTE**: An Azure Artifact account is not free; this is a paid option provided by Microsoft.

Here you have two options:

* [Generate self-signed certificate](#generate-self-signed-certificate)
* [Create Azure Code Signing certificate](#create-azure-code-signing-certificate)

![Two options available](app-control-create-certificate-02.png)

## Generate self-signed certificate

Fill the fields with your details, enter a password, select a validity period, the location of the content store, and the directory where the generated PFX is stored. Select the checkbox to install the certificate in the machine's personal store.
Next, click **Generate and save certificate**.

![Fill the fields and click Generate and save certificate](app-control-create-certificate-03.png)

Click **Yes** to continue or **No** to cancel.

![Click Yes to continue](app-control-create-certificate-04.png)

Click **Close**.

![Click Close](app-control-create-certificate-05.png)

## Create Azure Code Signing certificate

Click **Configure Azure Code Signing**.

![Click Configure Azure Code Signing](app-control-create-certificate-06.png)

Here you have two options:

* [Automatic](#automatic)
* [Manual](#manual)

![Automatic or Manual](app-control-create-certificate-07.png)

### Automatic

With the automatic option, a wizard guides you through the necessary steps.
Select **Automatic** and click **Next**.

![Select Automatic and click Next](app-control-create-certificate-08.png)

Make sure that all required modules and software are installed before continuing.

![Required modules and software overview](app-control-create-certificate-09.png)

#### Installation of required modules

Install via WinGet:

```powershell
winget install --id Microsoft.Azure.ArtifactSigningClientTools
winget install --id Microsoft.DotNet.DesktopRuntime.8
winget install --id Microsoft.PowerShell --source winget --installer-type wix
cd "C:\Program Files\PowerShell\7"
.\pwsh.exe -Command "Install-Module -Name Az.ArtifactSigning -Force"
```

Or you can download the software here and install it yourself:

* [Download Artifact Signing Client Tools](https://download.microsoft.com/download/a3c24ba9-ff1f-444f-b626-eff710f345c3/ArtifactSigningClientTools.msi)
* [.NET Desktop Runtime 8.0.28](https://dotnet.microsoft.com/en-us/download/dotnet/8.0)
* [Windows PowerShell 7](https://learn.microsoft.com/en-us/powershell/scripting/install/install-powershell-on-windows)

If all prerequisites are installed, click **Next** to continue with the next step.

![Click Next](app-control-create-certificate-10.png)

Click **Sign in to Azure**.

![Click Sign in to Azure](app-control-create-certificate-11.png)

Close the browser when authentication is successful.

![Close the browser](app-control-create-certificate-12.png)

When signed in, click **Next**.

![Click Next](app-control-create-certificate-13.png)

Select the **Subscription** you want to use for the code signing certificate.
Select or create a new **Resource Group** in which to create the code signing certificate.
Enter a **code signing account** (Artifact Signing account). The **profile name** is pre-filled, but you can change the name.
Select the **Assign me the signer and identity-verifier roles ...** checkbox, or assign these roles manually in the Azure portal.
Select the store to which the certificate will be deployed.

![Enter the details and click Next](app-control-create-certificate-14.png)

Click the **Open identity validations in portal** button.

![Click Open identity validations in portal](app-control-create-certificate-15.png)

A browser opens with the newly created Artifact Signing account.
In the **Objects** menu on the left side, click (1) **Identity validations**.
Next, click **New identity** and select **Private**.

![Create a Private identity](app-control-create-certificate-16.png)

Make sure all required fields are filled and click **Create** when finished.

![Fill the required fields and click Create](app-control-create-certificate-17.png)

It can take a short while. You may have to click the **Refresh** link, but eventually, if everything is in order, the status changes to **Completed**. Click the **Identity validation id** and copy the value to the clipboard on the next screen.

![Copy the Identity validation id](app-control-create-certificate-18.png)

Paste the copied Identity validation ID in the field of the same name and click **Finish** to close the wizard.

![Paste the ID and click Finish](app-control-create-certificate-19.png)

You might get a popup stating that the root is not (yet) valid, or you may have waited too long and the authentication has expired. You can follow the [manual](#manual) steps to select the already created certificate and finalize the wizard.

![Click OK](app-control-create-certificate-20.png)

### Manual

Select the **Manual** option and click **Next**.

![Select Manual and click Next](app-control-create-certificate-21.png)

Before continuing, make sure the required modules [are installed](#installation-of-required-modules).
Click **Next** to continue.

![Click Next](app-control-create-certificate-22.png)

Log in to Azure and open your [Artifact Signing account](https://portal.azure.com/#blade/HubsExtension/BrowseResourceBlade/resourceType/Microsoft.CodeSigning%2Fcodesigningaccounts).
Make a note of your Artifact Signing account name (1) and the account URI (2).

![Make a note of the account name and URI](app-control-create-certificate-23.png)

Under **Certificate profiles**, make a note of the profile name.

![Make a note of the profile name](app-control-create-certificate-24.png)

Fill the fields with the gathered values and click **Finish**.

![Fill the fields and click Finish](app-control-create-certificate-25.png)

Click **OK**.

![Click OK](app-control-create-certificate-26.png)
