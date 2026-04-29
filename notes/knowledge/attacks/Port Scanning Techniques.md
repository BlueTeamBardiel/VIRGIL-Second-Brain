# Port Scanning Techniques

## What it is
Like a burglar quietly testing every door and window of a building to see which ones open, port scanning probes a target system's TCP/UDP ports to discover which services are listening and potentially accessible. It is a reconnaissance technique used to map the attack surface of a host by sending crafted packets and analyzing responses to determine port state: open, closed, or filtered.

## Why it matters
Before the 2017 Equifax breach, attackers performed reconnaissance to identify exposed services on internet-facing systems — an Apache Struts endpoint went unpatched precisely because organizations often don't know what's running where. Defenders use the same scanning techniques proactively with tools like Nmap to find and close unintended exposures before attackers do.

## Key facts
- **SYN scan (half-open scan):** Sends SYN, receives SYN-ACK but never completes the handshake — stealthier than a full connect scan because it rarely logs in application-layer logs
- **XMAS scan:** Sets FIN, PSH, and URG flags simultaneously; open ports send no response, closed ports reply with RST — works against RFC-compliant stacks but fails on Windows
- **UDP scanning** is inherently slower and less reliable because UDP has no handshake; closed ports return ICMP "port unreachable," open ports often return nothing
- **Idle/zombie scan:** Uses a third-party host with predictable IP ID sequences to scan anonymously — the attacker's IP never touches the target directly
- Port states defined by Nmap: **open**, **closed**, **filtered**, **unfiltered**, **open|filtered**, **closed|filtered** — "filtered" typically indicates a firewall is dropping packets silently

## Related concepts
[[Nmap and Network Mapping]] [[Firewall Evasion Techniques]] [[Network Reconnaissance]] [[TCP Three-Way Handshake]] [[Vulnerability Scanning]]