# zoxide

Smarter `cd` based on **frecency** (frequency + recency). Learns where you go.

## Cool features

- **`z fragment`** jumps to the most-frecent directory matching the fragment, anywhere on the system.
- **Multi-fragment narrowing.** `z fpoc tests unit` matches any directory containing all three in
  order along the path. Killer for navigating deep trees you visit often.
- **`zi`** opens an fzf-based interactive picker — type-to-filter, Enter to jump. Requires `fzf` installed.
- **`z -` (or `z dash`)** — jumps back to previous directory (like `cd -`).
- **`zoxide query` (no cd)** — `zoxide query fpoc` prints the path without jumping. Useful in scripts.
- **`zoxide query -l`** — list all known directories ranked by frecency.
- **Per-directory frecency decay.** Old directories drop in priority over time, so a dir you used
  to live in but haven't touched in a month is naturally deprioritized.
- **Zero config.** No setup beyond `eval "$(zoxide init zsh)"` in your shell rc.

## Useful in FPOC

```bash
z fpoc                       # → ~/Documents/repos/FPOC
z fpoc bin                   # → ~/Documents/repos/FPOC/bin
z fpoc tests unit            # → ~/Documents/repos/FPOC/tests/unit
z dotfiles launchd           # → ~/dotfiles/launchd
z                            # → top-frecency dir overall (often FPOC for you)
zi                           # interactive picker — for when you forget the name
zoxide query -l | head -20   # see your top 20 most-visited dirs
```

## Habit shifts from cd

- `cd ../../..` — zoxide doesn't replace these. Use `cd` for relative navigation.
- `cd ~/known/full/path` — same; if you have it memorized, `cd` is fastest.
- "Jump to that one dir I work in" — `z` is the win here.

## Gotchas

- **`z foo`** doesn't move into a literal subdirectory named `foo`. It jumps to the highest-frecency
  match anywhere in your history. `cd foo` is still the right call if you want literal behavior.
- **Won't know a directory until you've cd'd there at least once** — zoxide builds its database
  from your `cd` history. First visit to a dir is via plain `cd`; subsequent visits can use `z`.

## Killer combos

```bash
z fpoc && rg "TODO" -t py            # jump + immediately search
z fpoc && just check                  # jump + run the gate
zi                                     # picker when name escapes you
```
