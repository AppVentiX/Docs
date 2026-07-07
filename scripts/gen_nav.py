"""
mkdocs-gen-files hook: build the PowerShell command-reference navigation from the
'category' / 'category_title' front matter that Build-CommandReference.ps1 stamps
into each command page.

Runs automatically during `mkdocs build` / `mkdocs serve`. Emits a literate-nav
file (`powershell-module/commands/_nav.md`) that mkdocs-literate-nav turns into the
categorized sidebar. New commands appear in the menu automatically -- no manual
edits to mkdocs.yml.
"""
import re
from pathlib import Path

import mkdocs_gen_files

COMMANDS_DIR = "powershell-module/commands"
NAV_FILE = f"{COMMANDS_DIR}/_nav.md"
INDEX_FILE = "index.md"  # relative to COMMANDS_DIR

# Section order. Categories not listed here are appended (alphabetically by title)
# so a newly introduced category can never silently vanish from the menu.
CATEGORY_ORDER = [
    "configuration", "license", "machine-group", "package",
    "publishing-task", "seamless", "user-settings", "diagnostics",
    "migration-appv", "migration-ivanti", "uncategorized",
]

_FM = re.compile(r"^---\s*\n(.*?)\n---\s*\n", re.DOTALL)


def _front_matter(text):
    m = _FM.match(text)
    if not m:
        return {}
    fm = {}
    for line in m.group(1).splitlines():
        if ":" in line:
            k, _, v = line.partition(":")
            fm[k.strip()] = v.strip()
    return fm


root = Path(__file__).resolve().parent.parent  # docs repo root
commands_path = root / "docs" / COMMANDS_DIR

buckets = {}   # category id -> list[(command, filename)]
titles = {}    # category id -> friendly title

for md in sorted(commands_path.glob("*.md")):
    if md.name in ("index.md", "_nav.md"):
        continue
    fm = _front_matter(md.read_text(encoding="utf-8"))
    if "category" not in fm:
        # Not a generated command page (e.g. a hand-written extra) -- skip nav here.
        continue
    cat = fm.get("category", "uncategorized")
    titles.setdefault(cat, fm.get("category_title", cat))
    cmd = fm.get("title", md.stem)
    buckets.setdefault(cat, []).append((cmd, md.name))

ordered = [c for c in CATEGORY_ORDER if c in buckets]
ordered += sorted((c for c in buckets if c not in CATEGORY_ORDER),
                  key=lambda c: titles.get(c, c))

lines = [f"* [Command Reference]({INDEX_FILE})"]
for cat in ordered:
    lines.append(f"* {titles.get(cat, cat)}")
    for cmd, fname in sorted(buckets[cat]):
        lines.append(f"    * [{cmd}]({fname})")

with mkdocs_gen_files.open(NAV_FILE, "w") as f:
    f.write("\n".join(lines) + "\n")
