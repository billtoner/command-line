# Command Line commands

A categorized index of CLI tools I want to refresh on. Click into a category for its tools; each tool links to a note with examples. Empty categories below are placeholders waiting for content.

## Find a tool

Run from the repo root:

```bash
# 1. Open a tool note by exact name (tab-completion works)
bat tool-notes/<name>.md                 # e.g. bat tool-notes/nmcli.md

# 2. Search all tool notes by keyword (matches inside the files)
rg -li <keyword> tool-notes/             # files that mention <keyword>
rg <keyword> tool-notes/                 # with surrounding lines

# 3. Fuzzy-find and open (requires fzf)
fd . tool-notes/ -e md | fzf --preview 'bat --color=always {}' | xargs -r $EDITOR

# 4. List every tool currently documented
fd . tool-notes/ -e md -x basename {} .md
```

Shell function (optional — add to `~/.zshrc` for `tool <name>`):

```bash
tool() {
    local repo="$HOME/Documents/repos/command-line"
    if [[ -z "$1" ]]; then
        fd . "$repo/tool-notes" -e md | fzf --preview "bat --color=always {}" | xargs -r ${EDITOR:-bat}
    else
        ${EDITOR:-bat} "$repo/tool-notes/$1.md"
    fi
}
```

## Categories

- System
- Hardware Information
- [File and Directory](categories/file-and-directory.md)
- [Search and Sort](categories/search-and-sort.md)
- Archiving
- Installing packages
- [Performance and Monitoring](categories/performance-and-monitoring.md)
- [Network](categories/network.md)
- [Linux Services](categories/linux-services.md)
- [Bluetooth](categories/bluetooth.md)
- [Audio](categories/audio.md)
- [Git](categories/git.md)
- Disk
- Text Processing
- [AWS CLI](categories/aws-cli.md)
- [Ansible](categories/ansible.md)
- [Useful Tools](categories/useful-tools.md)
