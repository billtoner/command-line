# Rotate a leaked GitLab Personal Access Token

A token (or several) has appeared in git history. Maybe gitleaks pre-commit alerted,
maybe `git log -p -S 'glpat-'` turned them up during an audit, maybe GitLab's secret
scanner flagged the project. The token might be revoked, current, or you might not know.

This walks through revoke → reissue → clone refresh, with a decision point on whether
to rewrite history.

## When to use this

- A pre-commit `gitleaks` hook fires on a `glpat-…` string
- `git log -p -S 'glpat-' | head` finds historical commits with tokens
- A collaborator reports "I saw a glpat- in your repo"
- Routine audit before opening the repo to a new collaborator

## 1. Scope: how many tokens, where

```bash
cd <repo>

# Distinct tokens (truncated prefix — safe to share, identifies in GitLab)
git log --all -p -S 'glpat-' | grep -oE 'glpat-[A-Za-z0-9_-]{8}' | sort -u

# Commits that introduce or remove a glpat-* line
git log --all --oneline -S 'glpat-'

# Comprehensive scan for other secret formats too (AWS, GitHub, Slack…)
gitleaks detect --no-banner
```

Note the **first 8 characters** of each token. That's enough to identify them in
GitLab's "Access Tokens" list without exposing the full value anywhere.

## 2. Notify the project owner (if it's not you)

Mandatory before any action on a repo you don't own. Provide:

- Distinct token count + 8-char prefixes
- Commits/dates of introduction (top of `git log --all --oneline -S 'glpat-'`)
- Which token (if any) is currently in your local `.git/config`
- Whether you want a new one issued now

```text
Heads up — audit on <date> found N distinct GitLab PATs in <repo> git
history, prefixes:
    glpat-AAAA…
    glpat-BBBB…
    glpat-CCCC…

These are in commits going back to <date>. The one I currently use is
glpat-XXXX… — let me know if I need a new value or if it's still valid.

Recommend:
  1. Revoke all N at GitLab → Project → Settings → Access Tokens
  2. Issue replacements for active collaborators
  3. Decide whether to rewrite history (most projects: skip, the
     revoked tokens are useless even though still visible)
```

## 3. Revoke at GitLab

For **project** access tokens: Project → Settings → Access Tokens → "Revoke"
next to each. For **personal** access tokens: User → Settings → Access Tokens.

Revocation is immediate. Any clone using a revoked token gets `401` on next push.

## 4. Issue replacements

Per active collaborator:

- Settings → Access Tokens → "Add new token"
- Scope minimally: `read_repository` and/or `write_repository`
- Expiry: 90 days or 1 year (don't go infinite — forces a rotation cadence)
- Copy the value ONCE — GitLab hides it after the page reload
- Deliver via a secure channel: 1Password share, Signal, encrypted email.
  Never Slack DM, never plaintext email.

## 5. Replace in each local clone

```bash
cd <repo>
git remote -v                                  # current URL

# Replace with new token
git remote set-url origin \
    https://<user-id>:<new-glpat>@gitlab.com/<group>/<project>.git

git fetch --dry-run                            # verify it works
```

## 6. Decision: rewrite history or accept

The revoked tokens are still in commit diffs. They're **useless** (revoked means
GitLab won't accept them), but they remain *visible* to anyone with read access.

| Choice | Trade-off | Right for… |
|---|---|---|
| **Accept** (do nothing more) | Free. Tokens visible but inert. | Most private repos with controlled access. |
| **Rewrite history** with `git filter-repo` | Every commit hash downstream of the leak changes. Every collaborator must re-clone. CI/automation breaks. | Repos going public, compliance requirements, or when the format of leaked tokens reveals attack-useful structure. |

For FPOC (private, principal-controlled access): **accept**. The audit-and-revoke
cycle is the meaningful action; the visible-but-revoked tokens are a paper cut, not
a wound.

## 7. If you chose rewrite

```bash
# Install
pip install git-filter-repo

# Work on a FRESH clone — filter-repo refuses to touch the working repo
git clone <repo> /tmp/repo-cleanup
cd /tmp/repo-cleanup

# Strip the offending strings. List one per line in a replacements file:
cat > /tmp/leaked-tokens.txt <<'EOF'
glpat-AAAAAAAA==>REDACTED
glpat-BBBBBBBB==>REDACTED
glpat-CCCCCCCC==>REDACTED
EOF

git filter-repo --replace-text /tmp/leaked-tokens.txt

# Force-push the cleaned history
git push origin --force --all
git push origin --force --tags

# Tell every collaborator: re-clone. Existing clones can't fast-forward.
```

After this, any other clone's `git pull` will fail with "refusing to merge unrelated
histories" — they have to start fresh.

## 8. Wire up gitleaks pre-commit to prevent recurrence

```yaml
# .pre-commit-config.yaml
- repo: https://github.com/gitleaks/gitleaks
  rev: v8.30.1
  hooks:
    - id: gitleaks
```

Then `pre-commit install`. Next time someone tries to commit a `glpat-…`,
the commit is blocked with `RuleID: gitlab-pat`.

## 9. Verify end-to-end

```bash
# New token works
git fetch && git push --dry-run

# gitleaks no longer fires on the current working tree
gitleaks detect --no-banner

# Pre-commit blocks new attempts (smoke test).
# Generate the fake at runtime rather than hardcoding one — committing a
# realistic-looking token here is exactly what GitHub's push protection
# will refuse, and rightly so.
FAKE=$(openssl rand -base64 15 | tr -d '=+/' | head -c 20)
echo "TOKEN=glpat-$FAKE" > /tmp/test.txt
gitleaks detect --source /tmp/test.txt --no-git --no-banner   # should report 1 leak
rm /tmp/test.txt
```

## Related

- [`tool-notes/git.md`](../tool-notes/git.md) — git fundamentals
- [GitLab access tokens docs](https://docs.gitlab.com/ee/user/profile/personal_access_tokens.html)
- [`git-filter-repo` docs](https://github.com/newren/git-filter-repo)
