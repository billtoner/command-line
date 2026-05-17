# examples — search the bt-knowledge-base notes repo and open matching .md files in the browser.
#
# Usage:
#   examples <term>
#
# Behavior:
#   1. If tool-notes/<term>.md exists, opens it directly (no picker).
#   2. Otherwise, ripgreps the term across all .md files and:
#        - opens the single match directly, OR
#        - shows an fzf picker (Tab to multi-select, Enter to open).
#   Selected files open in the default browser via a shared grip server
#   started in the background on first use (so cross-file links resolve).
#
# Requires: grip, lsof, open (macOS).  Fallback search also needs rg and fzf.
# To install: add `source ~/Documents/repos/bt-knowledge-base/bin/examples.zsh` to ~/.zshrc

examples() {
    local repo="$HOME/Documents/repos/bt-knowledge-base"
    local port=6419
    local term="$1"

    if [[ -z "$term" ]]; then
        echo "usage: examples <term>"
        return 1
    fi

    # Always-required deps
    local missing=()
    for c in grip lsof open; do
        command -v "$c" >/dev/null 2>&1 || missing+=("$c")
    done
    if (( ${#missing[@]} > 0 )); then
        echo "missing dependencies: ${missing[*]}"
        return 1
    fi

    # --- 1. Try direct tool-note match ---
    local direct="$repo/tool-notes/$term.md"
    local picks
    if [[ -f "$direct" ]]; then
        picks="$direct"
    else
        # --- 2. Fall back to ripgrep + fzf ---
        for c in rg fzf; do
            command -v "$c" >/dev/null 2>&1 || {
                echo "no tool-note named '$term', and $c not installed for fallback search"
                return 1
            }
        done

        local matches
        matches=$(rg -l --type md -- "$term" "$repo")
        if [[ -z "$matches" ]]; then
            echo "no matches for: $term"
            return 1
        fi

        if [[ $(printf '%s\n' "$matches" | wc -l | tr -d ' ') == "1" ]]; then
            picks="$matches"
        else
            picks=$(printf '%s\n' "$matches" | \
                fzf -m \
                    --header="Tab to multi-select, Enter to open" \
                    --preview="rg --color=always -n -C 2 -- '$term' {}")
        fi
        [[ -z "$picks" ]] && return
    fi

    # --- 3. Ensure a grip server is running at the repo root ---
    if ! lsof -ti tcp:$port >/dev/null 2>&1; then
        echo "starting grip server at $repo (port $port)..."
        (cd "$repo" && grip . --quiet >/dev/null 2>&1 &)
        local i
        for i in {1..30}; do
            lsof -ti tcp:$port >/dev/null 2>&1 && break
            sleep 0.1
        done
        if ! lsof -ti tcp:$port >/dev/null 2>&1; then
            echo "grip didn't come up on port $port"
            return 1
        fi
    fi

    # --- 4. Open each pick via the grip URL ---
    while IFS= read -r file; do
        local rel="${file#$repo/}"
        open "http://localhost:$port/$rel"
    done <<< "$picks"
}
