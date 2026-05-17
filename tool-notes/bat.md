# bat

`cat` with syntax highlighting, line numbers, and pager smarts.

## Cool features

- **Syntax highlighting** for ~200 languages — auto-detected from extension.
- **Line numbers** by default. Disable with `-p` or `--style=plain`.
- **Git status integration** — shows `+`/`-` next to lines that differ from HEAD.
- **Automatic paging** when output exceeds one screen; passes through when piped.
- **Themes.** `bat --list-themes` to preview; set with `--theme="Dracula"` or `BAT_THEME` env var.
- **Diff highlighting.** Pipe a diff in: `git diff | bat -l diff`.
- **Range printing.** `bat --line-range 50:100 file.py` (just lines 50-100).
- **Multiple files.** `bat file1 file2 file3` shows each with a header — easier than `cat` chains.

## Useful in FPOC

```bash
bat audiopulse/calibration/score.py              # pretty view of a module
bat -p audiopulse/__main__.py | head -30         # plain (no line nums) for piping-into-eyes
bat /tmp/commit-msg.txt                          # see proposed commit message in color
git diff | bat -l diff                            # if you don't have delta as pager
bat --diff README.md                              # show just the parts changed from git HEAD
```

## Habit shifts from cat

`cat` still works fine for piping into other commands — `bat` auto-detects when it's not at a terminal and falls back to plain output. So you can just alias `cat=bat` if you want (most people don't, since `cat` is muscle memory).

## Useful side use: MANPAGER

```bash
# In ~/.zshrc
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
```

Now `man rg`, `man bat`, etc., come out colored and scrollable.

## Killer flags

- `-p` / `--style=plain` — strip line numbers, headers, decorations
- `-r/-l start:end` — line range
- `--diff` — only changed lines vs HEAD
- `-l lang` — force a specific language highlighting
- `--theme="name"` — switch theme inline
