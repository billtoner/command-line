# atuin

Replaces zsh's Ctrl-R with a TUI fuzzy-search backed by SQLite. Stores rich metadata per command.

## Cool features

- **TUI fuzzy search on Ctrl-R** — type to filter, scroll, Enter to run, Tab to edit before running.
- **Rich metadata** — every command stored with: cwd, hostname, exit code, duration, timestamp, session ID.
- **Filter modes** — press Ctrl-R repeatedly inside the TUI to cycle:
    - **Global** (default) — all history, all dirs
    - **Host** — this machine only (relevant if synced)
    - **Session** — only this terminal tab
    - **Directory** — only commands ever run in the current `cwd` ← killer
- **SQLite-backed** at `~/.local/share/atuin/history.db` — durable, queryable.
- **Optional sync** — cross-machine history via atuin.sh or self-hosted server.
- **Stats.** `atuin stats` shows top commands, most-used aliases, etc.

## First-time setup gotcha

Atuin only stores commands typed *after install*. Run this once:

```bash
atuin import zsh
```

Sucks in your existing `~/.zsh_history`. Now Ctrl-R sees your archive.

## Daily commands beyond Ctrl-R

```bash
atuin history list | tail -20                    # last 20 commands
atuin search 'brew install'                      # search from CLI (no TUI)
atuin search --filter-mode directory 'just'      # commands in current dir
atuin stats                                       # fun stats
atuin update                                      # update atuin itself
```

## Privacy escape hatch

- **Leading space prefix** — any command typed with a leading space is NOT saved
  (relies on `setopt hist_ignore_space` in zsh, which atuin respects).
- **`history_filter` in config** — regex list of commands to never store. Useful for credential exports:

```toml
# ~/.config/atuin/config.toml
history_filter = [
    "^export.*TOKEN",
    "^export.*KEY",
    "^export.*SECRET",
    "^export.*PASSWORD",
]
```

## What atuin DOESN'T replace

- **Up-arrow** still uses zsh's native history (per-session). Atuin only binds Ctrl-R.
  Up-arrow = "last thing I ran"; Ctrl-R = "any command I've ever run, fuzzy-searchable."
- To make up-arrow also use atuin: `filter_mode_shell_up_key_binding = "session"` in config.

## Useful in FPOC

```bash
# Directory mode is the win. Try:
cd ~/Documents/repos/FPOC
Ctrl-R Ctrl-R Ctrl-R Ctrl-R   # cycle to [Directory] mode
# Now you see only FPOC commands. Type 'pyright', 'pytest', 'bump', etc.

# Cross-session reach
# That brew install you did 6 weeks ago in a now-closed tab? Ctrl-R + type the package name.

# Audit your own habits
atuin stats    # what do you actually run all day?
```

## Sync (defer)

```bash
atuin register -u <username> -e <email>
atuin login -u <username>
atuin sync
```

Defer until you actually want cross-machine history. Considerations: trust an external server with your shell history, or self-host.
