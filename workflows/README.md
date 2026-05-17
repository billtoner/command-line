# workflows

Multi-step procedures that cross tool boundaries. Where `tool-notes/` answers
"how do I use tool X", `workflows/` answers "I'm in situation Y, what do I do."

The audience is future-you. Each workflow is a procedural cheat-sheet: numbered
steps with copy-paste commands, decision points with trade-offs, and the kind
of context that gets forgotten between rare repetitions.

## Workflows

- [rotate-leaked-gitlab-pat](rotate-leaked-gitlab-pat.md) — what to do when a
  GitLab Personal Access Token shows up in git history (or when an audit finds
  several): scope → notify owner → revoke → reissue → refresh clones → decide
  on history rewrite → wire up `gitleaks` so it can't happen again.

## Style

- **One workflow per file.** Kebab-case names. Imperative title.
- **Numbered steps.** Each step short enough to scan; commands in code blocks.
- **Decision points get tables.** When the path forks, show the trade-offs side by side.
- **No tutorial prose.** Future-you doesn't need motivation; they need the sequence.
- **Real examples, not placeholders.** If the workflow references FPOC, use FPOC
  paths. Generalize only where the procedure differs from one project to another.
- **Cross-link tool-notes** for any tool the reader might need to brush up on.

## When to add a workflow

Whenever you find yourself thinking "I figured this out before but I don't
remember how" — that's the signal. The activation energy to write it down once
is much lower than re-deriving it next time.

Candidates not yet captured:
- Recover audiopulse-2 when WiFi config is broken (you already have a script)
- Deploy a new FPOC version to the Pi end-to-end
- Provision a fresh Pi (you have ansible but no narrative walk-through)
- Pre-commit setup on a new clone of a project
- Restore a Mac from Time Machine + Brewfile (you have `MAC-BOOTSTRAP.md` in dotfiles — could live here too, or stay there)

## Adding a new workflow

1. Write `workflows/<name>.md` in the style above.
2. Add a bullet to this README (alphabetical).
3. If a tool referenced in the workflow doesn't have a tool note yet, that's a
   signal to write one — or note "TODO: tool-notes/<x>.md" in the workflow.
