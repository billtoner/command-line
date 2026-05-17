# ripgrep (`rg`)

Replacement for `grep -r`. Faster, smarter defaults, gitignore-aware.

## Cool features

- **Recursive by default.** `rg pattern` already does what `grep -r pattern .` does.
- **Smart case** — lowercase pattern is case-insensitive; mixed-case is sensitive. No flag dance.
- **Respects `.gitignore`.** Doesn't waste time on `.venv/`, `__pycache__/`, build artifacts.
- **Type-aware filtering.** `rg "TODO" -t py` scans only Python files. See `rg --type-list` for the full taxonomy.
- **File-list output.** `rg -l "pattern"` lists files only — pipe to anything: `rg -l "boto3" | xargs code`.
- **Context windows.** `-C 3` shows 3 lines before/after each match; `-A` after only, `-B` before only.
- **Multiline regex.** `-U` flag lets your pattern span lines: `rg -U "def __init__\(.*\n.*ble_utils"`.
- **Inverse match.** `rg --files-without-match '"""' audiopulse/` — files missing a docstring.
- **Stats summary.** `--stats` adds match-count totals at the end.
- **Replace preview.** `rg "old" -r "new"` shows what the replacement would look like (read-only).

## Useful in FPOC

```bash
rg "assert .* is not None" audiopulse/     # find the pyright-fix asserts
rg "Optional\[" audiopulse/                # places where None is allowed
rg "TODO|FIXME|XXX" -t py                  # outstanding work markers
rg '@self\.app\.route'                      # Flask routes
rg -l "boto3" -t py                         # files that talk to DynamoDB
rg --stats "import sqlite3"                 # how widespread is sqlite usage?
rg -C 2 "compute_session_score"             # function uses with surrounding context
```

## Habit shifts from grep

| Old | New |
|---|---|
| `grep -rn "x" .` | `rg x` |
| `grep -i "x" .` | `rg x` (smart-case handles it) |
| `find . -name "*.py" -exec grep "x" {} \;` | `rg x -t py` |

## Killer flags

- `-l` — files with matches only
- `-w` — whole-word only
- `-g '!tests/'` — glob exclude (with `!`)
- `--hidden` — search hidden files
- `-uu` — also bypass `.gitignore` (use sparingly)
