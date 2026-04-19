# Nmap Reference Manual

Nmap (Network Mapper) is an open-source network exploration and security auditing tool that uses raw IP packets to discover hosts, services, operating systems, and firewall configurations. It's widely used for security audits, network inventory, service management, and host/service monitoring.

## Core Functionality

Nmap rapidly scans large networks or individual hosts to determine:
- Available hosts on the network
- Running services and application versions
- Operating systems and OS versions
- Packet filters and firewall types
- Other network characteristics

## Port States

Nmap classifies scanned ports into the following states:
- **Open**: Application listening for connections on that port
- **Closed**: No application listening; may open at any time
- **Filtered**: Firewall or network obstacle blocking port; cannot determine if open or closed
- **Unfiltered**: Responsive to probes; cannot determine if open or closed
- **Open|filtered**: Cannot determine which state applies
- **Closed|filtered**: Cannot determine which state applies

## Output Information

Nmap provides:
- **Interesting ports table**: Lists port number, protocol, service name, and state
- **Service version details**: When version detection is enabled
- **Additional target information**: Reverse DNS names, OS guesses, device types, MAC addresses
- **IP protocol information**: When IP protocol scan (-sO) is requested

## Common Usage Example

```bash
nmap -A -T4 scanme.nmap.org
```

Flags:
- `-A`: Enable OS and version detection, script scanning, and traceroute
- `-T4`: Faster execution timing template

## Basic Syntax

```
nmap [Scan Type] [Options] {target specification}
```

## Key Topics

- [[Target Specification]]
- [[Host Discovery]]
- [[Port Scanning Basics]]
- [[Port Scanning Techniques]]
- [[Service and Version Detection]]
- [[OS Detection]]
- [[Nmap Scripting Engine (NSE)]]
- [[Timing and Performance]]
- [[Firewall/IDS Evasion and Spoofing]]
- [[Output]]

## Tags

#nmap #network-scanning #security-audit #port-scanning #tool-reference

---
_Ingested: 2026-04-15 20:22 | Source: https://nmap.org/book/man.html_
