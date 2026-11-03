# AppVentiX Documentation

[![Deploy MkDocs to GitHub Pages](https://github.com/AppVentiX/Docs/actions/workflows/deploy.yml/badge.svg)](https://github.com/AppVentiX/Docs/actions/workflows/deploy.yml)
[![Built with Material for MkDocs](https://img.shields.io/badge/Material_for_MkDocs-526CFE?logo=MaterialForMkDocs&logoColor=white)](https://squidfunk.github.io/mkdocs-material/)

Source repository for the AppVentiX technical documentation, published at [docs.appventix.com](https://docs.appventix.com).

## Built with

- [ProperDocs](https://properdocs.org/) - static site generator (a maintained continuation of MkDocs 1.x)
- [Material for MkDocs](https://squidfunk.github.io/mkdocs-material/) - theme

## Local development

Install dependencies:

```powershell
pip install -r requirements.txt
```

Start the local dev server with live reload:

```powershell
python -m properdocs serve
```

The site is available at `http://127.0.0.1:8000`.

!!! note
    Search does not work under `properdocs serve` - it builds from an in-memory tree that [Pagefind](https://pagefind.app/) cannot index. To test search locally, build and index a static copy instead:

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

The site navigation for the command reference is built from that `category` front matter during the build (`scripts/gen_nav.py`), so a new command appears in the menu automatically. There is no command list to maintain in `properdocs.yml`.

After regenerating, verify the build:

```powershell
python -m properdocs build --strict
```

Strict mode fails on broken links or pages missing from the navigation, which catches drift before it ships. The same check runs in CI on every push.

### How the categories are decided

`scripts/CommandCategories.psd1` maps commands to menu categories. Most commands fall into the right category by name (for example anything matching `*PublishingTask*`). Add an entry there when a new command needs a different category, or when the script reports a command as uncategorized.

## Hidden sections

A hidden section is built and published, but reachable by URL only. It is for a limited group of readers, such as testers of a product before its release. Today there is one: **AppVentiX Automated Packaging**, at `/AutomatedPackaging/` (`docs/AutomatedPackaging/`).

What keeps a section hidden:

| Where | What it does |
|---|---|
| `not_in_nav` in `properdocs.yml` | Lets pages exist outside `nav:` without a build message. Nothing in the main navigation, the home page or the other pages links to them |
| `extra.hidden_url_prefixes` in `properdocs.yml` | The URL prefixes that `hooks.py` and `overrides/sitemap.xml` treat as hidden |
| `hooks.py` | Leaves the pages out of `search/search_index.json`, adds `<meta name="robots" content="noindex, nofollow">`, and marks `<body>` with `data-pagefind-ignore="all"`, so Pagefind indexes no page of the section |
| `overrides/sitemap.xml` | Leaves the pages out of `sitemap.xml` |
| `overrides/main.html` and `extra.automated_packaging_nav` | Give the section its own sidebar, because Material has none for pages outside `nav:` |

What it does **not** hide: anybody with the URL can open the pages, and anybody who can read this repository can read their source. The pages are not protected; they are only not advertised.

The Automated Packaging pages are written from the product repository (its customer guides and its code). A change to operator-facing behaviour there updates these pages too.

`docs/AutomatedPackaging/tester-kit-instructions.md` and `docs/AutomatedPackaging/downloads/automated-packaging-tester-kit.zip` are generated from the product's `tester-kit/`: never edit them by hand. Commit the change there, then run `.\scripts\Update-AutomatedPackagingTesterKit.ps1`.

`docs/AutomatedPackaging/error-codes.md` is generated: never edit it by hand. The product generates its register, `docs/reference/error-codes.md`, from `ApCodes.cs`. Commit the change there, then copy it here:

```powershell
.\scripts\Update-AutomatedPackagingErrorCodes.ps1
# or, for a checkout somewhere else
.\scripts\Update-AutomatedPackagingErrorCodes.ps1 -ProductRepo 'C:\path\to\AutomatedPackaging'
``` Where a task can be done in the application window and on the command line, a page shows both as tabs labelled exactly `GUI` and `CLI`; `content.tabs.link` keeps the reader's choice from page to page.

### Bring a hidden section into the site

1. Add its pages to `nav:` in `properdocs.yml`. For Automated Packaging, the entries of `extra.automated_packaging_nav` can move there as they are.
2. Remove its line under `not_in_nav`, and its prefix under `extra.hidden_url_prefixes`.
3. For Automated Packaging, remove `extra.automated_packaging_nav` and `overrides/main.html`.
4. Remove the "Preview documentation" note from `docs/AutomatedPackaging/index.md`, and link the section from the home page.
5. Optional: add a section label for the Pagefind filter in `SECTION_BY_URL_PREFIX` in `hooks.py`.
6. Run `python -m properdocs build --strict` and check that the pages are now in `sitemap.xml` and in search.

## Deployment

Pushing to the `main` branch automatically triggers a GitHub Actions workflow that builds and deploys the site to GitHub Pages at [docs.appventix.com](https://docs.appventix.com).
