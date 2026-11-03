"""MkDocs build hooks.

Registered via `hooks:` in properdocs.yml.
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


# Hidden sections: reachable by URL only, for a limited group of readers.
# The URL prefixes are `extra.hidden_url_prefixes` in properdocs.yml. Each
# prefix is also under `not_in_nav` there (so the build does not report the
# pages as missing from the nav), and overrides/main.html gives the section
# its own sidebar. For these pages this hook:
#   - excludes them from Material's search index (search/search_index.json),
#   - asks search engines not to index them (robots noindex),
#   - marks <body> data-pagefind-ignore="all", so Pagefind indexes nothing on
#     them.
# overrides/sitemap.xml leaves them out of the sitemap. To publish a section,
# follow README.md, "Hidden sections".


def is_hidden(page, config):
    prefixes = tuple(config["extra"].get("hidden_url_prefixes") or ())
    return bool(prefixes) and page.url.startswith(prefixes)


def on_page_markdown(markdown, page, config, files):
    if is_hidden(page, config):
        page.meta["search"] = {"exclude": True}
    return markdown


def on_post_page(output, page, config):
    if not is_hidden(page, config):
        return output
    if output.count("<head>") != 1 or output.count("<body ") != 1:
        raise ValueError(f"Cannot mark hidden page {page.url}: unexpected <head>/<body>")
    output = output.replace(
        "<head>", '<head>\n<meta name="robots" content="noindex, nofollow">', 1
    )
    return output.replace("<body ", '<body data-pagefind-ignore="all" ', 1)


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
