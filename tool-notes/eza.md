# eza

Modern `ls` replacement. Maintained fork of the (defunct) `exa`.

## Cool features

- **Git status column.** `eza --git` adds `--`, `-M`, `-N` etc. next to each file showing
  modified/new/ignored state. Replaces a separate `git status` for "what changed in this dir?"
- **Tree mode.** `eza --tree` recursively renders the directory as a tree. `--level 2` to limit depth.
- **Trailing markers (`ls -F`).** `eza -F` adds `/` after dirs, `*` after executables, `@` after
  symlinks. Identical to GNU `ls -F`.
- **Group directories first.** `--group-directories-first` (or `--group-directories-last`).
- **Icons** — `eza --icons` shows file-type emoji/Nerd Font glyphs. Requires a Nerd Font in your terminal.
- **Human-readable everywhere.** `-h` makes sizes "1.2K", "3.4M" etc. by default. (`-l` includes this.)
- **Header row.** `--header` adds column titles when listing.
- **Time field choice.** `--time=modified|accessed|created|changed` (the GNU `-t` flag is taken).

## Useful in FPOC

```bash
eza -lah --git audiopulse/                       # what changed in audiopulse/ since last commit
eza --tree --git-ignore audiopulse/calibration   # walk a module visually
eza -lah --git --sort=newest                     # newest-first listing
eza -lF                                           # quick ls with dir/exec markers
```

## Habit shifts from ls

| Old | New |
|---|---|
| `ls -la` | `eza -lah` |
| `ls -F` | `eza -F` (or `--classify`) |
| `ls -ltr` | `eza -l --sort=oldest` |
| `ls -lt` | `eza -l --sort=newest` |
| `tree` | `eza --tree` |

**Watch out**: `eza -t` is NOT "sort by time" (that conflicts with `--time=field`). Use `--sort=newest|oldest` instead. GNU muscle-memory pasting `-ltrp` will fail with "Option --time has no 'rp' setting" — that's the classic gotcha.

## Killer flags

- `--git` — git status column
- `--tree --level N` — tree view, depth-limited
- `-F` / `--classify` — type markers (`/` for dirs)
- `--icons` — file-type icons (needs Nerd Font)
- `--sort=newest|oldest|size|name` — explicit sort
- `--group-directories-first` — dirs at top
