# tools — list every tool note in the bt-knowledge-base notes repo, grouped by category.
#
# Usage:
#   tools                # all categories
#   tools <filter>       # only categories whose filename matches <filter> (e.g. `tools network`)
#
# Output is one tool name per line under each category header — like `ls -1` per group.
# Category headers come from the `# H1` of each `doc/categories/*.md` file, so casing
# and punctuation match (e.g. "AWS CLI", "Linux Services").

tools() {
    local repo="$HOME/Documents/repos/bt-knowledge-base"
    local cat_dir="$repo/doc/categories"
    local filter="$1"
    local cat_file cat_name

    if [[ ! -d "$cat_dir" ]]; then
        echo "category directory not found: $cat_dir"
        return 1
    fi

    for cat_file in "$cat_dir"/*.md; do
        # Optional filename-substring filter
        if [[ -n "$filter" ]]; then
            [[ "$(basename "$cat_file" .md)" == *"$filter"* ]] || continue
        fi

        cat_name=$(head -1 "$cat_file" | sed 's/^# //')
        echo "=== $cat_name ==="
        grep -oE 'tool-notes/[^)]+\.md' "$cat_file" \
            | sed 's|tool-notes/||; s|\.md||'
        echo
    done
}
