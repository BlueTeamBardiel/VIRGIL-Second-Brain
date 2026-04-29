# Ettercap

## What it is
Think of Ettercap as a postal worker who secretly opens every letter passing through a neighborhood, reads the contents, optionally rewrites them, then reseals and delivers them — with neither sender nor recipient aware. Precisely, Ettercap is an open-source network interception suite designed for Man-in-the-Middle (MitM) attacks on LAN environments, capable of sniffing, filtering, and injecting traffic in real time. It operates primarily by poisoning ARP tables to redirect traffic through the attacker's machine.

## Why it matters
In a penetration test scenario, a tester on a corporate LAN can launch Ettercap to ARP poison the gateway, causing all workstation traffic to route through their machine — capturing plaintext HTTP credentials, FTP logins, and session cookies within minutes. Defenders use this same knowledge to justify deploying Dynamic ARP Inspection (DAI) on managed switches, which validates ARP packets against a trusted DHCP binding table to block exactly this attack vector.

## Key facts
- Ettercap supports two primary modes: **unified** (sniff on one interface) and **bridged** (sniff between two interfaces, harder to detect)
- Uses **ARP poisoning** as its default MitM technique, sending forged ARP replies to associate the attacker's MAC with the gateway's IP
- Supports **plugins** (e.g., `dns_spoof`) to intercept and forge DNS responses mid-session
- Can perform **SSL stripping** via plugins, downgrading HTTPS connections to HTTP when HSTS is not enforced
- Runs on Linux/Unix and has both a **ncurses TUI** and command-line interface; GUI version (`ettercap-gtk`) also exists

## Related concepts
[[ARP Poisoning]] [[Man-in-the-Middle Attack]] [[Dynamic ARP Inspection]] [[SSL Stripping]] [[Wireshark]]