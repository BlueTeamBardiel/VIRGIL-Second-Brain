# Nmap Reference Manual

## What Is It? (Feynman Version)

Imagine a locksmith walking through a house, tapping on every door to hear if someone inside says "open," "closed," or "locked," and then asking each person what they are doing.  
Nmap does the same thing for computer networks: it sends raw IP packets to hosts, listens to the replies, and tells you which ports (doors) are accepting connections (open), which are not (closed), which are hidden behind firewalls (filtered), and what services (people inside) are running on those open ports.

## Why Does It Exist?

Before Nmap, discovering a network’s layout was like blindfolded exploration—you could guess where devices were, but you had no reliable map.  
Organizations needed a quick way to inventory their own infrastructure, verify that firewalls were correctly blocking unwanted traffic, and find vulnerable services before attackers did.  
Nmap solved this by automating the probing process, turning a labor‑intensive manual task into a single command that can scan millions of ports in minutes.

## How It Works (Under the Hood)

1. **Target Specification** – The user gives Nmap an IP, hostname, or range.  
2. **Host Discovery** – Nmap sends low‑rate ICMP echo, TCP SYN to port 443, or ARP requests (depending on options) to see if a host responds.  
3. **Port Scanning**  
   * **SYN Scan (`-sS`)** – Sends a SYN, waits for SYN‑ACK (open) or RST (closed). If no response, the port is filtered.  
   * **TCP Connect Scan (`-sT`)** – Completes the three‑way handshake; if it succeeds, the port is open.  
   * **UDP Scan (`-sU`)** – Sends a UDP packet; a response or ICMP port‑unreachable indicates closed, no response is usually filtered.  
4. **Version Detection (`-sV`)** – Once a port is marked open, Nmap sends protocol‑specific probes (e.g., HTTP GET /, SMTP EHLO) and compares the banner text against a database to guess the service and version.  
5. **OS Detection (`-O`)** – Nmap probes a series of TCP/IP stack quirks (IP TTL, window size, TCP options) and matches the pattern to a set of known operating‑system fingerprints.  
6. **Scripting Engine (`-sC` or `--script`)** – Loads Lua scripts to perform deeper checks (e.g., vulnerability discovery, configuration checks).  
7. **Timing Templates (`-T0`–`-T5`)** – Controls scan speed and stealth; higher values send packets faster but are more detectable.  
8. **Output Generation** – Results are assembled into human‑readable tables, XML, or grepable formats for further analysis.

## What Breaks When It Goes Wrong?

- **False Negatives** – If a firewall silently drops packets, Nmap may report a host as down, masking a misconfigured security device.  
- **False Positives** – A port may appear open due to a honeypot; a misinterpretation can lead to unnecessary patching or resource allocation.  
- **Scanning Impact** – Aggressive scans (`-T5`, `-A`) generate high packet rates that can overwhelm routers or trigger IDS alerts, causing legitimate traffic to be dropped.  
- **Regulatory Consequences** – In some jurisdictions, unauthorized port scanning can be interpreted as a probing attack, potentially violating cyber‑crime statutes and leading to legal action.  
- **Human Cost** – A mis‑identified open service might be patched unnecessarily, incurring development effort, or left vulnerable, resulting in a data breach, loss of customer trust, and financial penalties.

The first people to notice a problem are usually network operations or security teams when alerts spike, services fail unexpectedly, or compliance reports flag anomalies.

---

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