# Signing

Every package is signed. The signing certificate decides the publisher of the package. To Windows, a different publisher is a different application.

You can sign with:

- a code signing certificate in the computer store of the host,
- an Azure Artifact Signing profile,
- a test certificate that the product makes, for evaluation.

## The packaging tools of the host

The host unpacks, packs and signs with `makeappx.exe`, `signtool.exe` and `makecat.exe` from the Windows SDK. The product does not ship them.

1. Go to **Settings > This host**, card **Packaging tools**.
2. Click **Get the packaging tools**.

The product gets the pinned `Microsoft.Windows.SDK.BuildTools` package from Microsoft. It checks that each file is signed by Microsoft, and puts the files in `<workingDir>\Tools`. Nothing goes to the network until you click the button. Each row must then say "… the acquired copy, signed by Microsoft." with a green check.

On a host with no internet, install the Windows SDK. The product then uses the tools under `Windows Kits\10\bin`, and says so.

## Certificates

Only the **computer** store signs a job: `LocalMachine\My`. The Automated Packaging service runs every job, and it cannot read your own store (`CurrentUser\My`).

=== "GUI"

    Go to **Settings > Signing**.

    - **Signing certificates** lists each certificate in the computer store that has a private key and can sign code.
    - **Test** signs a scratch file with the certificate. It shows the subject and the publisher that the certificate gives.
    - **In your own certificate store** lists code signing certificates that are only in your own store. **Move to this computer** moves the certificate and its private key to the computer store.

    A key that you cannot export cannot move. Import the certificate again from its PFX file into the computer store.

=== "CLI"

    List the certificates and the Azure profiles that this host can sign with:

    ```
    AutomatedPackaging.Cli certificates
    AutomatedPackaging.Cli certificates --json
    ```

    Give the thumbprint to `convert` with `--certificate-thumbprint`. When the host has exactly one certificate, `convert` uses it. Give the ID of an Azure profile with `--signing-profile` instead.

    The JSON output is one array. Certificates come first, with `"kind": "Certificate"`, `thumbprint`, `name`, `subject`, `selfSigned`, `expires` and `expired`. Then the Azure profiles, with `"kind": "AzureArtifactSigning"`, `id`, `name`, `subject` and `tested`.

## A test certificate

For an evaluation, go to **Settings > Signing** and click **Generate a test certificate**.

- The default subject is `CN=Automated Packaging Test Signing`. You can change it first. The subject becomes the publisher of each package that it signs.
- The certificate goes into the computer store, with a key that cannot be exported. It is valid for two years.
- It shows as **self-signed** on Settings and on the Build screen.

When it is done, the card shows "Generated a test certificate, valid until …", with the **Subject**, **Thumbprint**, **Publisher ID** and **Public certificate**. The public certificate is `%ProgramData%\AppVentiX\Automated Packaging\certificates\<thumbprint>.cer`. The card also gives the command for the target machines, with that path filled in.

A package signed this way installs only where the certificate is trusted. **Trust it on this machine…** adds it to Trusted People on the host. The card then says "This machine trusts it." Copy the `.cer` file to each target machine, and run this command there as administrator:

```powershell
Import-Certificate -FilePath '<path to the .cer>' -CertStoreLocation Cert:\LocalMachine\TrustedPeople
```

On a machine that does not trust the certificate, the package does not install. The package itself is correct. The product's code for this is `AP-VF-004`.

The smoke test trusts the certificate of the job in the worker. You do not need to do this for the worker.

## Azure Artifact Signing

An Azure Artifact Signing profile signs with a certificate that stays in Azure. Public Trust and Private Trust profiles are both supported.

1. Go to **Settings > Signing**, card **Azure Artifact Signing**.
2. Click **Add a profile**, or **Fill from Azure…** to fill the form from your Azure account.
3. Enter **Tenant ID**, **Subscription ID**, **Resource group**, **Signing account**, **Certificate profile**, **Region** and **Trust**.
4. Enter the **Client ID** and **Client secret** of a service principal. The service signs as this principal.
5. Click **Save profile**.
6. Click **Test** on the row of the profile.

**Remove** asks first. It deletes the client secret of the profile from this host, and you cannot undo it.

**Get the client tools** gets the Artifact Signing client tools from NuGet. **Test** also gets them when they are missing.

The service principal needs the *Artifact Signing Certificate Profile Signer* role on the certificate profile. The product keeps the client secret encrypted in the data folder.

A profile must pass **Test** before it can sign a job. The publisher of the package is the subject that the last test signed as. A Private Trust package shows a warning on the host (`AP-VF-004`), because its root is not trusted there. This is not a failure.

## A certificate on a hardware token

A certificate on a hardware token asks for its PIN each time SignTool signs. The product stops SignTool after 2 minutes. If nobody types the PIN in that time, the job fails with `AP-SG-008`.

To give more time, go to **Settings > Signing**, card **Time limit for SignTool**. Type a number of minutes from 1 to 30, and click **Save time limit**. The next job, **Test** and **Retry signing** use it.

A job that failed this way keeps its package. Click **Retry signing** on the **Jobs** screen to sign it again without a new capture.

## Change the certificate of an application

The certificate or profile of a job is the publisher of the package. A package with a new publisher installs beside the old package. It does not update it. Remove the old package from the machines that have it. The package name stays the same.

Next: [Convert an installer](convert.md).
