# Network

File transfer, HTTP, connectivity, and interface configuration.

- [ssh](../../tool-notes/ssh.md) — secure shell; remote exec, port forwarding, jump hosts, connection multiplexing
- [ssh-add](../../tool-notes/ssh-add.md) — manage keys in the ssh-agent; macOS Keychain integration
- [scp](../../tool-notes/scp.md) — copy files between hosts over SSH; uses your `~/.ssh/config` aliases
- [curl](../../tool-notes/curl.md) — HTTP(S) client; headers, methods, multipart upload, custom timing, debug tracing
- [httpie](../../tool-notes/httpie.md) — friendly HTTP client; JSON by default, colorized output, sane defaults
- [nmcli](../../tool-notes/nmcli.md) — NetworkManager CLI; persistent profiles for Wi-Fi, Ethernet, VPN, hotspot
- [ifconfig](../../tool-notes/ifconfig.md) — configure and inspect network interfaces (deprecated in favor of `ip`)
- [iwconfig](../../tool-notes/iwconfig.md) — configure and inspect wireless interfaces (deprecated in favor of `iw`; no WPA support)
- [ss](../../tool-notes/ss.md) — modern `netstat`; what's listening or connected, by process, with kernel-level filters
- [ip](../../tool-notes/ip.md) — addresses, links, routes, neighbors, namespaces; the modern replacement for `ifconfig`/`route`/`arp`
- [dig](../../tool-notes/dig.md) — DNS lookups, authoritative queries, `+trace` from the root, resolver comparison
- [mtr](../../tool-notes/mtr.md) — continuous traceroute + ping; finds where packets drop on a flaky path
- [tcpdump](../../tool-notes/tcpdump.md) — packet capture with BPF filters; remote-capture-to-local-Wireshark recipes
- [iperf3](../../tool-notes/iperf3.md) — active throughput measurement; TCP/UDP, parallel streams, bidirectional
- [nmap](../../tool-notes/nmap.md) — port scanning, host discovery, service/version fingerprinting, NSE scripts
- [wget](../../tool-notes/wget.md) — recursive downloader; resume, mirror sites, URL lists, link checking
- [nc](../../tool-notes/nc.md) — TCP/UDP swiss army knife; port probe, banner grab, ad-hoc listener, throwaway HTTP responder
- [host](../../tool-notes/host.md) — friendlier one-shot DNS lookups; A/AAAA/MX/TXT in one line
- [iw](../../tool-notes/iw.md) — modern wireless CLI; link/scan/event/regulatory/monitor mode (replaces `iwconfig`)
- [traceroute](../../tool-notes/traceroute.md) — single-snapshot path discovery; TCP/UDP/ICMP modes, PMTU
- [ngrep](../../tool-notes/ngrep.md) — grep on packet payloads; HTTP/DNS content matching with pcap filters
- [iftop](../../tool-notes/iftop.md) — top by network flow (host pairs)
- [nethogs](../../tool-notes/nethogs.md) — top by process bandwidth
- [whois](../../tool-notes/whois.md) — domain + IP + AS lookups; Team Cymru bulk-whois recipe
