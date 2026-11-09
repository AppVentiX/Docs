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

## Check and add a recipe

```powershell
AutomatedPackaging.Cli recipe validate D:\Recipes\7-zip.json
AutomatedPackaging.Cli recipe add D:\Recipes\7-zip.json
AutomatedPackaging.Cli recipe list
```

`recipe validate` changes nothing and does not need an elevated prompt. `recipe add` puts the file in the `recipes` folder of the data folder. Only administrators can add a recipe.

A version never changes. `recipe add` refuses other content under a name and version that the host has (`AP-IM-029`). Give the recipe a higher version.

An AI agent checks a recipe with the MCP tool `validate_recipe`, and lists the recipes with `list_recipes`. Only a person adds a recipe.

An AI agent can see what a recipe changes before a job, with the MCP tool `preview_recipe`. It runs the recipe on the capture of a finished job of the built-in engine. It does not use a worker and makes no package. It gives the number of captured entries that each `RC-` rule matches, the applications with their programs, and each item that the recipe drops or changes.

## See the recipes of this host

=== "GUI"

    Open **Settings > Exclusions**. The **Recipes** card shows each file of the `recipes` folder: the name, the version, the application and the SHA-256. A file that a job cannot use shows why, for example `AP-IM-027`. You cannot change a recipe there.

=== "CLI"

    ```powershell
    AutomatedPackaging.Cli recipe list
    ```

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
