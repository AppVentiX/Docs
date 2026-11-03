# Stage media

A worker is built from media that you supply. You put the files in folders of the working directory. The application then prepares the Windows ISOs. Media is prepared only in the application window. The command line has no command for it.

## 1. The packaging tool

Put the MSIX Packaging Tool bundle (`.msix` or `.msixbundle`) and its licence file (`.xml`) in `<workingDir>\Distro\Tools`.

!!! warning "Do not forget the licence file"
    Without the licence file, the tool installs and then does not start (`0x80072EE7`). This looks like a broken image, not like a missing file.

One copy serves all releases.

## 2. The ADK Deployment Tools

The application rebuilds the Windows ISOs with `oscdimg`, from the ADK Deployment Tools.

- **Apply the changes** in host preparation downloads `adksetup.exe` into `<workingDir>\Tools`. It then installs only the Deployment Tools.
- On a host with no internet, put `adksetup.exe` in `<workingDir>\Tools` first. `adksetup.exe` still downloads its payload from Microsoft during the installation.

To install the Deployment Tools manually:

```
adksetup.exe /ceip off /norestart /quiet /features OptionId.DeploymentTools
```

A download by the product keeps the file only when all three are true:

- Its name is `adksetup.exe`.
- It is smaller than 32 MB.
- Windows accepts it as signed by Microsoft.

## 3. The Windows media

For each release, put **both** ISOs in `<workingDir>\_import\<release>`. For example, `_import\Windows11-25H2`:

- the Windows installation ISO,
- the Features on Demand ISO of the same release.

The folder name tells the product the release of the two ISOs. See [Supported Windows releases](requirements.md#supported-windows-releases) for the folder names.

## 4. Scan and prepare

1. In the application, go to **Images**, then the **OS media** tab. While a release is not ready, the tab shows a count, for example **2 waiting**.
2. Click **Look again** after you add files or install the ADK. It reads the drop folders again, and checks again for `oscdimg`.
3. Select the release under **Release to prepare into**.
4. Click **Scan and prepare…**.

The scan reads each ISO in the drop folder of that release:

| ISO | What the scan does | Result |
|---|---|---|
| Windows installation ISO | Rebuilds it so that it starts with no key press | `Distro\OS\<release>\ISO\<name>-pkgmanaged.iso` |
| Features on Demand ISO | Reduces it to the capture driver | `Distro\OS\<release>\FOD\<release>-CaptureDriver.iso` |

A rebuild takes several minutes for each ISO. A bar and a line under the buttons show the ISO, the step and the time. The rest of the window stays available.

- **Stop** stops after the current ISO. The current ISO is completed first.
- The scan writes each ISO with a temporary name, `.iso.partial`. It renames the file only when it is complete. An ISO that was not completed never counts as staged.
- A release with both ISOs staged is not read again.

The release is ready when its row says "Installation media and capture driver both staged — ready to build a worker." Its badge then shows **ready**. The other badges are **partway** (one of the two ISOs) and **not staged**.

Next: [Build a worker image](build-image.md).
