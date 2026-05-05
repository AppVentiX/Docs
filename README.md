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
python -m mkdocs serve
```

The site is available at `http://127.0.0.1:8000`.

## Deployment

Pushing to the `main` branch automatically triggers a GitHub Actions workflow that builds and deploys the site to GitHub Pages at [docs.appventix.com](https://docs.appventix.com).
