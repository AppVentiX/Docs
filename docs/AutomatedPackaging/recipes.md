# Recipes

A recipe tells a job what to change for one application. It is a JSON file that a person or an AI agent writes. The job applies it in the same way each time, without a person or an AI deciding again.

A recipe can do four things:

- **Exclusions.** Leave files, folders and registry keys out of the package. Both engines use them.
- **Shortcuts.** Keep or drop shortcuts. The built-in engine only.
- **File types.** Keep or drop file type associations. The built-in engine only.
- **Fix-ups.** Change the display name of an application, or keep it off the Start list. The built-in engine only.

!!! warning "What a recipe cannot add"
    A recipe cannot add capabilities, services, startup tasks or firewall rules. A person must approve each of these. A recipe with such a field is refused with `AP-IM-028`.

In this version, you use recipes from the command line and from AI agents (MCP). The Build screen cannot select a recipe yet.

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
| `fixUps` | No | Each has `kind` and `application`, the file name of the program. `displayName` also needs `value`. `hide` keeps the application off the Start list |

Any other field is refused with `AP-IM-027`. The error names the field.

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

## Use a recipe for a job

```powershell
AutomatedPackaging.Cli convert D:\Installers\7z2408-x64.msi --recipe 7-zip
AutomatedPackaging.Cli convert D:\Installers\7z2408-x64.msi --recipe 7-zip@2 --engine builtin
```

Without `@version`, the job uses the highest version. An AI agent sets the `recipe` parameter of `convert`.

The job records the name, the version and the SHA-256 of the recipe. A new version of the job uses the same recipe. If the recipe file changed or is gone, the job is refused with `AP-IM-029`, and no worker is touched.

| Part of the recipe | Microsoft's MSIX Packaging Tool | Built-in engine |
|---|---|---|
| Exclusions | Yes | Yes |
| Shortcuts | No | Yes |
| File types | No | Yes |
| Fix-ups | No | Yes |

The job folder has `recipe.json`. It names the recipe and the engine, and tells for each part if the engine applied it.
