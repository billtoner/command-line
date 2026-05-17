# fd

Replacement for `find`. Smart-case, gitignore-aware, parallel exec.

## Cool features

- **`fd pattern`** — regex search on filenames, recursive, smart-case, respects `.gitignore`.
- **Extension filter.** `fd -e py` for all `.py`. Can repeat: `fd -e py -e pyi`.
- **Type filter.** `-t f` (files), `-t d` (dirs), `-t l` (symlinks).
- **Parallel exec — the killer feature.** `fd -e py -x ruff check {}` runs the command on every match, in parallel. Use `-X` (capital) to invoke once with all paths (xargs-style).
- **Time filters.** `fd --changed-within 1week`, `--changed-within 1day`, even `--changed-before 1month`.
- **Size filters.** `fd -S +1M` (>1MB), `fd -S -10k` (<10KB).
- **Glob mode.** `fd -g '*.json' config/` — glob syntax instead of regex when you want it.
- **Override the gitignore opt-in.** `-I` includes gitignored files; `-H` includes hidden files.

## Useful in FPOC

```bash
fd -e py audiopulse/calibration            # all Python in calibration/
fd -t f test_ tests/                       # all test_* files
fd -e py --changed-within 1day             # recently-edited Python
fd -e log -S +1M                            # logs bigger than 1MB
fd -e py audiopulse/ble -x ruff check       # lint only BLE files
fd -t d __pycache__ -x rm -rf               # purge all __pycache__ dirs
fd -e py -x wc -l | sort -rn | head         # 10 biggest Python files
```

## Habit shifts from find

| Old | New |
|---|---|
| `find . -name "*.py"` | `fd -e py` |
| `find . -name "foo*"` | `fd foo` |
| `find . -newer file` | `fd --changed-within 1week` |
| `find . -type d -name node_modules -exec rm -rf {} +` | `fd -t d node_modules -x rm -rf` |

## Killer flags

- `-x` — parallel exec on each match
- `-X` — single exec with all matches (xargs-style)
- `-e ext` — extension filter
- `-t f` / `-t d` — type filter
- `--prune` — don't descend into matches
