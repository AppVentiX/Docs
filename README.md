# AppVentiX Documentation

[![Deploy MkDocs to GitHub Pages](https://github.com/AppVentiX/Docs/actions/workflows/deploy.yml/badge.svg)](https://github.com/AppVentiX/Docs/actions/workflows/deploy.yml)
[![Built with Material for MkDocs](https://img.shields.io/badge/Material_for_MkDocs-526CFE?logo=MaterialForMkDocs&logoColor=white)](https://squidfunk.github.io/mkdocs-material/)

Source repository for the AppVentiX technical documentation, published at [docs.appventix.com](https://docs.appventix.com).

## Built with

- [MkDocs](https://www.mkdocs.org/) - static site generator
- [Material for MkDocs](https://squidfunk.github.io/mkdocs-material/) - theme

## Local development

Install dependencies:

```powershell
pip install -r requirements.txt
```

Start the local dev server with live reload:

```powershell
python -m mkdocs serve --livereload
```

The site is available at `http://127.0.0.1:8000`.

!!! note
    Search does not work under `mkdocs serve` - it builds from an in-memory tree that [Pagefind](https://pagefind.app/) cannot index. To test search locally, build and index a static copy instead:

    ```powershell
    .\scripts\Serve-WithSearch.ps1
    ```

    This has no live reload; re-run it after making changes.

## PowerShell command reference

The pages under `docs/powershell-module/commands/` are generated from the AppVentiX PowerShell module's comment-based help, not written by hand. Do not edit them directly. To keep the reference accurate, fix the help in the module source and regenerate.

### Requirements

- A local checkout of the [AppVentiX PowerShell module](https://github.com/AppVentiX) next to this repository (default path `..\AppVentiX-Powershell-Module\AppVentiX\AppVentiX.psd1`).
- The `Microsoft.PowerShell.PlatyPS` module (v2):

  ```powershell
  Install-Module Microsoft.PowerShell.PlatyPS -Scope CurrentUser
  ```

### Regenerate

```powershell
# Uses the default module path shown above
.\scripts\Build-CommandReference.ps1

# Or point at a specific module manifest
.\scripts\Build-CommandReference.ps1 -ModulePath 'C:\path\to\AppVentiX.psd1'
```

The script documents every exported command, reads the module version from the manifest, and stamps a `category` into each page's front matter. It reports any commands that still have incomplete help, so those gaps can be fixed in the module source.

The site navigation for the command reference is built from that `category` front matter during the build (`scripts/gen_nav.py`), so a new command appears in the menu automatically. There is no command list to maintain in `mkdocs.yml`.

After regenerating, verify the build:

```powershell
python -m mkdocs build --strict
```

Strict mode fails on broken links or pages missing from the navigation, which catches drift before it ships. The same check runs in CI on every push.

### How the categories are decided

`scripts/CommandCategories.psd1` maps commands to menu categories. Most commands fall into the right category by name (for example anything matching `*PublishingTask*`). Add an entry there when a new command needs a different category, or when the script reports a command as uncategorized.

## Deployment

Pushing to the `main` branch automatically triggers a GitHub Actions workflow that builds and deploys the site to GitHub Pages at [docs.appventix.com](https://docs.appventix.com).
