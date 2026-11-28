# Recipes

A recipe tells a job what to change for one application. It is a JSON file that a person or an AI agent writes. The job applies it in the same way each time, without a person or an AI deciding again.

A recipe can do five things:

- **Exclusions.** Leave files, folders and registry keys out of the package. Both engines use them.
- **Shortcuts.** Keep or drop shortcuts. The built-in engine only.
- **File types.** Keep or drop file type associations. The built-in engine only.
- **Protocols, execution aliases and COM classes.** Keep or drop each of them. The built-in engine only.
- **Fix-ups.** Change the display name of an application, keep it off the Start list, give it arguments, or set its working folder. The built-in engine only.

!!! warning "What a recipe cannot add"
    A recipe cannot add capabilities, services, startup tasks or firewall rules. A person must approve each of these. A recipe with such a field is refused with `AP-IM-028`.

You select a recipe on the **Build** screen, from the command line (`--recipe`), and from AI agents (MCP).

## The format

```json
{
  "format": "automated-packaging-recipe",
  "formatVersion": 1,
  "name": "7-zip",
  "version": 2,
  "application": "7-Zip",
  "exclusions": [
    { "rule": "%USERPROFILE%\\AppData\\Local\\7-Zip\\Cache", "note": "Written at the first start." },
    { "rule": "HKCU\\Software\\7-Zip\\FM\\Columns" }
  ],
  "shortcuts": { "drop": ["7-Zip Help"] },
  "fileTypes": { "drop": [".cab"] },
  "fixUps": [
    { "kind": "displayName", "application": "7zFM.exe", "value": "7-Zip File Manager" },
    { "kind": "hide", "application": "7zG.exe" }
  ]
}
```

| Field | Required | What it is |
|---|---|---|
| `format` | Yes | Always `automated-packaging-recipe` |
| `formatVersion` | Yes | Always `1` in this version |
| `name` | Yes | A letter or digit, then letters, digits, `.`, `-` and `_`. 64 characters at most |
| `version` | Yes | A whole number from 1 to 999999. Give a changed recipe a higher version |
| `application` | No | The name of the application, for the list of recipes |
| `notes` | No | Text for people. The product does not use it |
| `exclusions` | No | At most 500 rules, each with `rule` and an optional `note`. A rule uses the syntax of [Exclusions](settings.md#exclusions). The rules get the IDs `RC-001`, `RC-002` and so on |
| `shortcuts` | No | `keep` or `drop`, not both: shortcut names, without the folder and without `.lnk`. With `keep`, the job keeps only these |
| `fileTypes` | No | `keep` or `drop`, not both: file types with their dot, for example `.7z` |
| `protocols` | No | `keep` or `drop`, not both: URL schemes, for example `sevenzip-help`. A scheme starts with a letter |
| `executionAliases` | No | `keep` or `drop`, not both: alias names, for example `7z.exe` |
| `comClasses` | No | `keep` or `drop`, not both: COM class IDs, with or without braces. A dropped class takes its shell menu handlers with it |
| `internetHosts` | No | 1 to 200 host names that a job of this recipe can reach through the host proxy while it installs: `download.example.com`, `*.example.com`, `lan:fs01`. The proxy must be on. A list in the job wins over this one. See [Internet for a worker](worker-internet.md) |
| `fixUps` | No | At most 200. Each has `kind` and `application`, the file name of the program. The kinds are in the next table |

| Fix-up `kind` | `value` | What it does |
|---|---|---|
| `displayName` | The new display name | Changes the name of the application on the Start list |
| `hide` | None | Keeps the application off the Start list |
| `arguments` | The arguments, 2000 characters at most | Starts the application with these arguments, from the Start list too |
| `workingFolder` | A folder of the package, for example `VFS\ProgramFilesX64\7-Zip` | Starts the application in this folder on Windows 11. Windows 10 ignores it |

A fix-up that matches no application, or a `workingFolder` that the package does not have, is not applied. The job's `engine\writer-evidence.json` names each one.

Where `arguments` and `workingFolder` apply:

- From the Start list, Windows 11 starts the application with the arguments and in the folder. Windows 10 gives the arguments and ignores the folder.
- On Windows 11, **Open** on the application in `shell:AppsFolder` gives neither. That is how Windows starts it from there.
- With the Package Support Framework on, its launcher starts the program. The program gets the arguments, and starts in the folder.

Any other field is refused with `AP-IM-027`. The error names the field.

!!! note "A schema for AI agents"
    An AI agent gets the JSON Schema of the recipe format with the MCP tool `recipe_schema`. The product's own check is the authority. Always check a recipe with `recipe validate` or `validate_recipe`.

A dropped shortcut is not in the package, and does not make an application.

## A recipe to share: format version 2

Format version 2 also holds how a job starts and how it builds. A file of this format has the extension `.aprecipe`. Give it to another host, or keep it for the next version of the installer. The product still reads format version 1.

```json
{
  "format": "automated-packaging-recipe",
  "formatVersion": 2,
  "name": "7-zip",
  "version": 3,
  "application": "7-Zip",
  "match": { "installerType": "msi", "fileName": "7z*-x64.msi" },
  "start": {
    "name": "7-Zip",
    "publisher": "Igor Pavlov",
    "installMode": "silent",
    "arguments": "/qn",
    "mustRunOn": "Windows11Only"
  },
  "build": {
    "transforms": [ { "fileName": "site.mst" } ]
  },
  "packaging": {
    "exclusions": [ { "rule": "HKCU\\Software\\7-Zip\\FM\\Columns" } ]
  }
}
```

| Part | Required | What it is |
|---|---|---|
| `match` | No | How the product knows the installer, also for the next versions: `installerType` (`msi` or `exe`), `fileName` (with `*` and `?`), `signerSubject`, `upgradeCode` and `productName`. Each field that the recipe gives must agree with the installer. There is no SHA-256: each new version has a new one |
| `start` | Yes | The minimum to start a job: `name`, `publisher`, `installMode` (`silent` or `interactive`), `mustRunOn`, and optional `arguments`. The package version comes from the installer |
| `build` | No | Values of the **Build** screen. Each field is optional on its own, for example only `transforms`. A field that is not there takes the value of the host |
| `packaging` | No | The fields of format version 1: exclusions, shortcuts, file types, fix-ups, protocols, execution aliases, COM classes and internet hosts |

A recipe never holds signing, host paths, a machine or the export. The host gives them. A field such as `certificate` or `machine` is refused with `AP-IM-027`.

**Transforms by file name.** A transform is its file name, with an optional SHA-256. The product looks for it beside the installer first, then in the folders below the installer, three folders down at most. Two files with the name below the installer are refused. When the recipe gives the SHA-256, the file must have it.

!!! note "A schema for AI agents"
    The MCP tool `recipe_schema` gives the JSON Schema of format version 2. With `formatVersion` 1, it gives the first format.

## Start a job from a recipe file

=== "GUI"

    Select the installer on the **Build** screen. Then click **Open file…** under **Recipe**. The recipe fills the form. It does not start a job. You can also double-click an `.aprecipe` file: the application opens on the **Build** screen with it, also when the application is open already. When the file gives internet hosts for the worker or fix-ups, a line under **Recipe** names them. **Build** then lists them and asks first. When you click **No**, the file is not added and no job starts.

    When the `match` of the recipe does not name the installer, a warning is under **Recipe**. When you click **Build**, the product asks if you want to build this installer with the recipe.

    The recipe joins the recipes of this host when you click **Build**.

=== "CLI"

    ```powershell
    AutomatedPackaging.Cli convert D:\Installers\7z2601-x64.msi --recipe-file D:\Recipes\7-zip.aprecipe
    ```

    The product adds the file to the recipes of this host, as `recipe add` does. An option on the command line wins over the file. An installer that the `match` does not name is refused with `AP-IM-038`; add `--ignore-match` to use the recipe one time. A transform that is not found once is refused with `AP-IM-039`. A file that gives internet hosts or fix-ups is refused until you add `--accept-recipe`; the refusal names each host and each fix-up.

An AI agent sets `recipe` on `convert` to a recipe of this host. A recipe of format version 2 fills the job, and the values of the call win. Set `ignoreMatch` to use it with another installer. MCP refuses a recipe with transforms or the files beside the installer: start such a job on the **Build** screen or with the command line.

## Make a recipe from a job

=== "GUI"

    On the **Jobs** screen, select a job that built a package. Then click **More** > **Save as recipe…**. On the **Build** screen, **Save as file…** under **Recipe** saves the form.

=== "CLI"

    ```powershell
    AutomatedPackaging.Cli recipe export 20261124-101500-a1b2c3 --out D:\Recipes\7-zip.aprecipe
    ```

The file has the values of the job and the packaging rules of the recipe of the job. A transform is its file name, with its SHA-256 while the file is there. `match` has the installer type, and the signer and UpgradeCode while the installer is still there. Add a `fileName` or `productName` pattern when the next versions use the same form. The file holds the arguments and the MSI properties of the job: do not share it when they hold a key or a password. An AI agent gets the text of the file with the MCP tool `export_recipe`, for its own jobs only.

## Check and add a recipe

=== "GUI"

    Open **Settings > Recipes** and click **Add recipe...**. Select the file. The application checks the file first. A file with internet hosts or fix-ups shows a question that names each host and each fix-up, as **Open recipe file** on the Build screen does. Click **Yes** to add the file, or **No** to add nothing. **LAST ACTION** on the page says what happened.

=== "CLI"

    ```powershell
    AutomatedPackaging.Cli recipe validate D:\Recipes\7-zip.json
    AutomatedPackaging.Cli recipe add D:\Recipes\7-zip.json
    AutomatedPackaging.Cli recipe list
    ```

    `recipe validate` changes nothing and does not need an elevated prompt. `recipe add` puts the file in the `recipes` folder of the data folder.

Only administrators can add a recipe.

A version never changes. `recipe add` refuses other content under a name and version that the host has (`AP-IM-029`). Give the recipe a higher version.

An AI agent checks a recipe with the MCP tool `validate_recipe`, and lists the recipes with `list_recipes`. Only a person adds a recipe.

An AI agent can see what a recipe changes before a job, with the MCP tool `preview_recipe`. It runs the recipe on the capture of a finished job of the built-in engine. It does not use a worker and makes no package. It gives the number of captured entries that each `RC-` rule matches, the applications with their programs, and each item that the recipe drops or changes.

## See the recipes of this host

=== "GUI"

    Open **Settings > Recipes**. The **Recipes** card shows each file of the `recipes` folder: the name, the version, the application and the SHA-256. A file that a job cannot use shows why, for example `AP-IM-027`. You cannot change a recipe there.

=== "CLI"

    ```powershell
    AutomatedPackaging.Cli recipe list
    ```

## The recipes of earlier jobs: Built before

The host keeps the recipe of each job that succeeds, also after housekeeping removes the job. A test job and a job from an earlier capture are not kept. Jobs that succeeded before the product kept recipes are not kept.

- **Application.** An MSI is known by its UpgradeCode. A signed EXE is known by its signer and the product name of its version information. Any other installer is known by the application name.
- **Variant.** Other arguments, MSI properties or transforms make a new variant of the application.
- **Revision.** Any other change makes a new revision of the variant, for example another engine, other exclusions or another program to start. A job with the settings of a revision adds a job to that revision. The host keeps every revision.
- **Not kept:** the certificate, the output (MSIX, AppGo or App Attach) and the machine. The engine is kept.

**Settings > Recipes** has the card **Built before**. It shows each revision with its arguments and MSI properties, its engine and its jobs. A value whose name looks like a password, key, serial, licence, token or credential is hidden. Click **Show** to see it. The host keeps the value as the job used it, because a new job needs it.

On the Build screen, a line **Built before** shows after you select an installer, when a kept recipe can fit it:

- **This same file**: a job built this file before.
- **This application**: the same UpgradeCode, or the same signer and product name.
- **The same name only**: only the application name is the same.

When one variant fits as the same file or the same application, the line names the revision that a job used last. Click **Fill from it** to put its settings into the form. Nothing changes before you click. When more variants fit, or only the name, click **Choose...** and select a revision. **Fill from it** in that window fills the form. The certificate and the output on the form stay as they are. The form uses the recipe of this host that the earlier job used, when this host still has the same file. If not, the form has no recipe, and the line says so. The line does not show for a new version of a job (Jobs > **New version...**) or while a recipe file that you opened fills the form.

The command line and MCP do not show the kept recipes.

## Use a recipe for a job

=== "GUI"

    On the **Build** screen, select the recipe in **Recipe**. **None** is the default. The list has each recipe of this host, with its version and application. The line under the list shows the SHA-256 of the recipe.

    **New version…** on the **Jobs** screen shows the recipe of the earlier job. Select **None** to build without it. If the recipe file changed or is gone, the list beside **Build** shows `AP-IM-029` before you start the job.

    The **Jobs** screen shows the recipe of each job under its facts: the name, the version and the SHA-256.

=== "CLI"

    ```powershell
    AutomatedPackaging.Cli convert D:\Installers\7z2408-x64.msi --recipe 7-zip
    AutomatedPackaging.Cli convert D:\Installers\7z2408-x64.msi --recipe 7-zip@2 --engine builtin
    ```

    Without `@version`, the job uses the highest version. `convert --from-job <id>` uses the recipe of the earlier job. An AI agent sets the `recipe` parameter of `convert`.

The job records the name, the version and the SHA-256 of the recipe. A new version of the job uses the same recipe. If the recipe file changed or is gone, the job is refused with `AP-IM-029`, and no worker is touched.

| Part of the recipe | Microsoft's MSIX Packaging Tool | Built-in engine |
|---|---|---|
| Exclusions | Yes | Yes |
| Shortcuts | No | Yes |
| File types | No | Yes |
| Protocols, execution aliases, COM classes | No | Yes |
| Fix-ups | No | Yes |

The job folder has `recipe.json`. It names the recipe and the engine, and tells for each part if the engine applied it.
