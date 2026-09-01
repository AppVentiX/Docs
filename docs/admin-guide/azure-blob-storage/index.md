# Azure Blob storage configuration

With a Azure Blob storage it's possible to store configuration settings securely and make it available for your clients outside of your network.
With Azure Blob storage you don't have any dependency with Active directory or challenges you might experience with SMB shares.

If you want to create a (new) separate site to start with, [check this page out first](../sites/index.md#create-a-new-site).

To start the (initial) configuration, click the **Setup Wizard**

![Azure Blob storage configuration](azure-blob-storage-01.png)

You have two options for configuring:

* [Create New](#create-new)
* [Connect to Existing](#connect-to-existing)

## Create New

With the create new you have two options, by default **Automatic - ...** is selected. The manual option is also available.

* [Automatic setup](#automatic-setup)
* [Manual setup](#manual-setup)

### Automatic setup

With the automatic option, AppVentiX will do all the configuration for you.

To continue, you account needs at least one of the following (subscription) roles

* Owner
* Contributor + User Access Administrator

Select **Automatic - sign in to Azure**

![Select Automatic](azure-blob-storage-automatic-01.png)!

Click **Sign in to Azure...**

![Sign in to Azure...](azure-blob-storage-automatic-02.png)

A browser popup will appear for you to sign in with your company credentials, log in.

![sign in with your company credentials](azure-blob-storage-automatic-03.png)

A **Permissions requested** dialog may appear, requesting for Microsoft Graph Command Line Tools permissions.
Click **Accept** to continue.

![Accept permissions](azure-blob-storage-automatic-04.png)

When login is successful, you can close the browser and continue in AppVentiX Central View.

![Close the browser](azure-blob-storage-automatic-05.png)

Click **Next** to start the storage account creation.

![Start automatic configuration](azure-blob-storage-automatic-06.png)

Select the subscription you want to use for the Storage Account.
Next, select an existing Resource Group or click **New** to create a new Resource Group for the storage account.

![Select subscription](azure-blob-storage-automatic-07.png)

Enter a Resource Group Name and select a Region.
Click **Create** when you are ready.

![Click Create](azure-blob-storage-automatic-08.png)

Click **New** to create a new Storage Account.

![Click New](azure-blob-storage-automatic-09.png)

Enter a __unique__ storage account name.
If you enter a name that already exists, you may be presented with a warning message.

![Enter SA Name](azure-blob-storage-automatic-10.png)

Click **Create** to start the creation of the Storage Account, this can take a short time.
During this period, the Storage Account is created, permissions are set and blob containers are created.

![Click Create](azure-blob-storage-automatic-11.png)

Click **Next**

![Click Next](azure-blob-storage-automatic-12.png)

A new App Registration will be created by default with the correct required permissions.
You can change the Display name according to your companies policy.

To **Use an existing app registration** you can create your own App Registration.
You can follow [this](../custom-app-registration/index.md) guide  to configure your own App Registration.

!!! note
    After Automatic App Registration creation, Storage Blob Data Contributor role will be assigned to it.

Click **Next** to start this process.

![App Registration](azure-blob-storage-automatic-13.png)

On the next screen, an Agent client certificate will be created. AppVentiX (Central View and Agents) will use this certificate to authenticate to the Storage Account.
You can however [select your own pxf certificate](../client-certificate/index.md)

The default validity is 3 years, you can change this accordingly.

!!! note
    The Public key will be automatically configured, no manual action is required. The public key saved is for your records only.

![Create or select client certificate](azure-blob-storage-automatic-14.png)

Click **Finish** to finalize the wizard.
Some last configuration settings will be set and containers will be created.

![Finish](azure-blob-storage-automatic-15.png)

Click **Close**.

![Click Close](azure-blob-storage-automatic-16.png)

Click **Save** to start using this new configuration settings.

![Click Save](azure-blob-storage-automatic-17.png)

A popup may appear for you to login again.
Enter your password and approve MFA if required.

![alt text](azure-blob-storage-automatic-18.png)

When the login is successful, a popup may appear, click **Close**

![alt text](azure-blob-storage-automatic-19.png)

You are now ready for the next step.

## Connect to Existing

If you already have an existing (pre-configured) storage account, or want to connect a new management machine to an existing storage account, you can use the manual connect option.

Click **Connect to Existing** to start the process.

![Connect to Existing](azure-blob-connect-existing-01.png)

A browser popup may appear for you to sign in with your company credentials, log in.
If you are already signed in, the login prompt will not be shown.

![sign in with your company credentials](azure-blob-storage-automatic-03.png)

Enter the existing storage account name and click **OK** to continue.

![Enter storage account name](azure-blob-connect-existing-02.png)

When the storage account is found and the connection is made, you will be presented with a confirmation. Click **Close** to close this popup.

![Confirmation dialog](azure-blob-connect-existing-03.png)

You are now ready for the next step.

### Manual setup

In some situations you might not be able to run the [automatic](#automatic-setup) option to create a storage account. For example if another team manages the Azure platform. This procedure can than be followed to (pre) create the storage account and after which you can run the [manual](#manual-setup) steps to connect to the newly created storage account.

#### Storage account

First login to the [Azure portal](https://portal.azure.com)

Navigate to Storage accounts and click the **+ Create** button.

![Create new Storage account](azure-blob-connect-existing-manual-01.png)

Select your **Subscription** where you want to create the new Storage Account.
Select an existing resource group or create a new one.
Enter your new **Storage account name** and **Region**.
The **Performance** can be left at **Standard**. AppVentiX support can you in some cases instruct to change this to **Premium**
Configure **Primary service** to **Azure Blob Storage or Azure Data Lake Storage**
The **Redundancy** can be set to **Locally redundant storage (LRS)**.
Click **Next**

![Select resources and new sa name](azure-blob-connect-existing-manual-02.png)

**Advanced** tab can be left to default values
On the **Networking** tab, make sure that **Public network access** is **enabled** and **Public network access scope** is set to **Enable from all networks**. Without this setting, public devices line Laptops can not connect to the storage account.
Leave **Routing preference** on **Microsoft network routing**

![Configure network settings](azure-blob-connect-existing-manual-03.png)

Make sure that on the **Data Protection** tab **Days to retain deleted containers** is set to **7** for
- **Enable soft delete for blobs**
* **Days to retain deleted blobs**

![Configure Data Protection](azure-blob-connect-existing-manual-04.png)

On the **Security** tab, make sure that **Require secure transfer for REST API operations** is checked. Rest can be left to default values.

![Configure Security](azure-blob-connect-existing-manual-05.png)

You can leave the values on the default values on the **Encryption** tab.

![Configure Encryption](azure-blob-connect-existing-manual-06.png)

When there are no errors you can click **Create** to start creating the new storage account.

![Start creating the sa](azure-blob-connect-existing-manual-07.png)

When the deployment is successful, you will receive a message.
Click on **Go to resource** or browse to the new Storage Account.

![Deployment successful](azure-blob-connect-existing-manual-08.png)

Next the user or a (user) Group for the Administrator role must be added to the storage account. Without this permission AppVentiX Central view cannot be managed. For more details or other scenarios visit [this page](../share-permissions/index.md#azure-blob-storage)
You can set the admin permission on the storage account (globally) or set the _Storage Account Data Reader_ globally and configure per container permissions.

To add a role for your admin user, Click **+ Add** and click **Add role assignment** in tme **Account Control (IAM)** section.

![Add role assignment](azure-blob-connect-existing-manual-09.png)

Search for and select the role **Storage Blob Data Contributor**.
Click ***Next**.

![Select the Storage Blob Data Contributor role](azure-blob-connect-existing-manual-10.png)

Select the members you want to assign. This can be one or more users or a Group.

Click ***Next** 2 times.

![Select members](azure-blob-connect-existing-manual-11.png)

Click **Review + assign**

![Click Review + assign](azure-blob-connect-existing-manual-12.png)

Next we need to create 5 containers.
IN the left menu in the storage account, Expand **Data storage** and select **Containers**.
Next click **+ Add container**

![Add container](azure-blob-connect-existing-manual-13.png)

Enter the name **machinegroups** and click **Create**

![Create container](azure-blob-connect-existing-manual-14.png)

Repeat this process for the remaining 4 containers. And set the admin user permissions accordingly.

!!! Important
    Create the containers exactly as described with small caps and no spaces!

| Container Name | Permissions |
|---|---|
| machinegroups | Admin (user) - Storage Blob Data Contributor |
| publishing | Admin (user) - Storage Blob Data Contributor |
| content | Admin (user) - Storage Blob Data Contributor |
| inventory | Admin (user) - Storage Blob Data Contributor |
| centralview | Admin (user) - Storage Blob Data Contributor<br> |

!!! note
    If you want to assign RBAC roles, you can visit [this page](../rbac/index.md) for more details.

![Created containers](azure-blob-connect-existing-manual-15.png)

Select **Containers** in the **Data Storage** section.
Select a container, for example **inventory**

![Select a container](azure-blob-connect-existing-manual-33.png)

Select **Access Control (IAM)** in the left menu, click the **+ Add** button and select **Add role assignment**.

![Add role assignment](azure-blob-connect-existing-manual-34.png)

Configure the roles according to the following table. Repeat the process fo all the other containers listed in the table as well.

| Container Name | Permissions |
|---|---|
| machinegroups | Agent (machine) - Storage Blob Data Reader |
| publishing | Agent (machine) - Storage Blob Data Reader |
| content | Agent (machine) - Storage Blob Data Reader |
| inventory | Agent (machine) - Storage Blob Data Contributor (preferred)<br>Or Storage Blob Data Reader for minimal permissions |

#### App Registration

Go to App Registrations to create a new App Registration.
The App registration is used for the agent to access the configuration store (read only) using certificate based authentication. Access to configuration and content is read-only, access to the inventory location (optional) is read and write.

Click **New registration**

![New registration](azure-blob-connect-existing-manual-16.png)

Give the App Registration a meaningful name.
**Single tenant only - xxx** is good for most configurations.
No **Redirect URI** is necessary.
When finished click **Register**.

![Create App Registration](azure-blob-connect-existing-manual-17.png)

Copy the **Application (client) ID** and the **Directory (tenant) ID** values, we need these for the next steps.

![Note the values](azure-blob-connect-existing-manual-18.png)

Switch back to the AppVentiX Central View settings wizard and select the **Manual** option.
Click **Next**

![Select Manual](azure-blob-connect-existing-manual-19.png)

Enter the **Storage account name** exactly as created earlier and click **Next**.

![Enter sa name](azure-blob-connect-existing-manual-20.png)

Enter the **Tenant ID** and **Client ID** values saved earlier.
Click **Next**

![Enter the tenant and client id](azure-blob-connect-existing-manual-21.png)

Select **Generate a new certificate** and optionally change the other values.
You have the option to import your own pfx.
Note the path here, we need this certificate for one of the next steps.
Click **Next**.

![Generate a new certificate](azure-blob-connect-existing-manual-22.png)

Click **Finish**

![Finish](azure-blob-connect-existing-manual-23.png)

!!! note
    You might have to login into Azure after clicking on Finish. Login with a admin account configured for access to the Storage account earlier.

The AppVentiX Central View Storage account configuration is almost done. We now need to add the certificate to the App Registration first.
You can click **Close**

![Wait here](azure-blob-connect-existing-manual-24.png)

Navigate back to the App Registration we created earlier.
Open the **Manage** menu and select **Certificates & secrets**.
Select **Certificates** and click the **Upload certificate** button.

![Upload certificate](azure-blob-connect-existing-manual-25.png)

Select the certificate we created earlier and provide a Description.
Click **Add**.

![Select the certificate](azure-blob-connect-existing-manual-26.png)

Select **Authentication** in the **Manage** section.
Select **Redirect URI Configuration** and select **+ Add Redirect URI**

![Add redirect URI](azure-blob-connect-existing-manual-27.png)

Next click the **Mobile and desktop applications** option.

![Select Mobile and desktop applications](azure-blob-connect-existing-manual-28.png)

Enter the following value and click **Configure** when ready.

`ms-appx-web://microsoft.aad.brokerplugin/e05585a2-c70c-46fc-bcf9-74ad966e2837`

![Add Redirect URI](azure-blob-connect-existing-manual-29.png)

Navigate to **API permissions**.

![Navigate to API permissions](azure-blob-connect-existing-manual-30.png)

Click the **Grant admin consent for AppVentiX Corp** button

![Grant admin consent](azure-blob-connect-existing-manual-31.png)

Click **Yes**.

![Click Yes](azure-blob-connect-existing-manual-32.png)

Finally click **Save** in the AppVentiX Central View Settings wizard.

![Save settings](azure-blob-connect-existing-manual-35.png)
