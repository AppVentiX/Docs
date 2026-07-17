"""MkDocs build hooks.

Registered via `hooks:` in mkdocs.yml.
"""

# Maps a page's top-level URL segment to the section label used by the
# Pagefind search filter checkbox (see overrides/partials/search.html and
# docs/assets/js/pagefind-search.js). Admin Guide, How To, and Quickstart are
# grouped under one "Docs" checkbox; PowerShell Module is the other. Pages
# whose first URL segment isn't listed here (e.g. the homepage, release
# notes) are left untagged and are always included in every filter
# combination.
SECTION_BY_URL_PREFIX = {
    "admin-guide": "Docs",
    "howto": "Docs",
    "quickstart": "Docs",
    "powershell-module": "PowerShell Module",
}


def on_page_content(html, page, config, files):
    prefix = page.url.split("/", 1)[0]
    section = SECTION_BY_URL_PREFIX.get(prefix)
    if section is None:
        return html

    # NOTE: this does not scope Pagefind's indexing to just this wrapper
    # (that would need data-pagefind-body added consistently to every page,
    # tagged or not, or untagged pages like the homepage and release notes
    # would silently drop out of the index). Until that's done site-wide,
    # Pagefind indexes the whole <body>, which occasionally surfaces small
    # incidental fragments (e.g. a bare "nav" result) alongside real pages.
    return (
        f'<div data-pagefind-filter="section:{section}" '
        f'data-pagefind-meta="section:{section}" style="display:contents">'
        f"{html}"
        f"</div>"
    )
