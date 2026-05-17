# Command Line commands

## System

## Hardware Information

## File and Directory

- [bat](../tool-notes/bat.md) — `cat` with syntax highlighting and paging
- [eza](../tool-notes/eza.md) — modern `ls` replacement
- [zoxide](../tool-notes/zoxide.md) — smarter `cd` based on frecency

## Search and Sort

- [ripgrep](../tool-notes/ripgrep.md) — fast, gitignore-aware `grep -r` replacement
- [fd](../tool-notes/fd.md) — friendlier `find` replacement

## Archiving

## Installing packages

## Performance and Monitoring

- [aiomonitor](../tool-notes/aiomonitor.md) — telnet console into a running asyncio event loop
- [py-spy](../tool-notes/py-spy.md) — sampling profiler that attaches to running Python processes
- [viztracer](../tool-notes/viztracer.md) — trace-based profiler with an interactive web viewer

## Network

## Linux Services

### systemctl

```bash
# Unit lifecycle
sudo systemctl start  nginx
sudo systemctl stop   nginx
sudo systemctl restart nginx
sudo systemctl reload nginx                 # SIGHUP — re-read config without dropping connections
sudo systemctl enable --now nginx           # start now AND on boot
sudo systemctl disable --now nginx          # stop now AND remove from boot

# Status & inspection
systemctl status nginx                      # state, recent log lines, main PID, cgroup tree
systemctl is-active nginx                   # scriptable: prints "active" / "inactive"
systemctl is-enabled nginx                  # scriptable: prints "enabled" / "disabled" / "masked"
systemctl cat nginx                         # show the unit file (and any drop-ins)
systemctl show nginx                        # every property, key=value (great for `grep`)
systemctl show nginx -p MainPID,ActiveState,SubState

# What's running / what's broken
systemctl list-units --type=service                    # active services
systemctl list-units --type=service --state=failed     # just the failures
systemctl --failed                                     # shortcut for the above
systemctl list-unit-files --state=enabled              # everything that will start at boot
systemctl list-dependencies nginx                      # dependency tree

# Edit a unit safely (creates a drop-in under /etc/systemd/system/<unit>.d/)
sudo systemctl edit nginx                   # override fragment only — survives package upgrades
sudo systemctl edit --full nginx            # edit the whole unit file
sudo systemctl daemon-reload                # after hand-editing unit files

# Boot analysis
systemd-analyze                             # total boot time
systemd-analyze blame                       # slowest units, ranked
systemd-analyze critical-chain              # what's actually on the critical path
systemd-analyze plot > boot.svg             # gorgeous SVG timeline of boot

# Run a transient service or scope (great for one-off jobs with limits)
systemd-run --unit=backup --on-calendar='daily' /usr/local/bin/backup.sh
systemd-run --scope -p MemoryMax=512M ./hungry-script.py
```

### journalctl

```bash
# Logs for one unit
journalctl -u nginx                         # all entries
journalctl -u nginx -f                      # follow (like `tail -f`)
journalctl -u nginx -n 200                  # last 200 lines
journalctl -u nginx -e                      # jump to end (paged)

# Time ranges — accepts natural language
journalctl -u nginx --since "1 hour ago"
journalctl -u nginx --since today
journalctl -u nginx --since "2026-05-15 09:00" --until "2026-05-15 10:00"
journalctl -u nginx --since yesterday --until today

# Boots
journalctl --list-boots                     # index of recent boots
journalctl -b                               # current boot only
journalctl -b -1                            # previous boot (post-mortem after a crash)
journalctl -k                               # kernel ring buffer (dmesg equivalent, persistent)

# Severity
journalctl -p err                           # err and above (err, crit, alert, emerg)
journalctl -p warning..err -u nginx         # range of priorities

# Output formats
journalctl -u nginx -o cat                  # message only, no timestamps/host (clean for `grep`)
journalctl -u nginx -o json-pretty          # full structured record — every field journald captured
journalctl -u nginx -o short-iso            # ISO-8601 timestamps

# Filtering by structured fields (this is the superpower)
journalctl _PID=1234
journalctl _UID=1000 --since today
journalctl _SYSTEMD_UNIT=nginx.service _TRANSPORT=stdout
journalctl --field _SYSTEMD_UNIT            # list all values for a field

# Disk usage & retention
journalctl --disk-usage
sudo journalctl --vacuum-time=7d            # drop entries older than 7 days
sudo journalctl --vacuum-size=500M          # cap journal at 500 MB

# Health check
journalctl --verify                         # checksum-verify the journal files
```

## Git

- [delta](../tool-notes/delta.md) — syntax-highlighted, language-aware git diff pager
- [lazygit](../tool-notes/lazygit.md) — full-screen TUI for git
- [tig](../tool-notes/tig.md) — TUI for browsing git history, diff, blame, refs

## Disk

## Text Processing

## AWS CLI

- [NoSQL Workbench](../tool-notes/nosql-workbench.md) — AWS GUI for designing and querying DynamoDB tables

## Useful Tools

- [atuin](../tool-notes/atuin.md) — TUI fuzzy-search shell history backed by SQLite
- [DB Browser for SQLite](../tool-notes/db-browser-for-sqlite.md) — GUI for inspecting and editing SQLite databases
- [sqlite-utils](../tool-notes/sqlite-utils.md) — CLI for querying, dumping, and importing SQLite data


