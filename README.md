# command-line

A personal cheat-sheet of CLI tools and commands worth refreshing on. Each tool has its own page with real-world examples.

## Start here

- **[doc/command-line.md](doc/command-line.md)** — the categorized index. Every tool lives under a category.
- **[CLAUDE.md](CLAUDE.md)** — the three-tier structure (index → category files → tool notes) and the style rules for adding new entries.

## Browse with rendered links

```bash
grip . --browser              # serves the whole repo on localhost; relative links work
# then navigate to /doc/command-line.md
```

`grip .` is required (not `grip doc/command-line.md`) so that links from category files into `tool-notes/` — which live one directory above — can resolve. See [tool-notes/grip.md](tool-notes/grip.md) for more grip recipes.
