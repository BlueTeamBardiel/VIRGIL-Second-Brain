# IP — Internet Protocol

## What it is

In **Call of Duty: Modern Warfare's** Warzone, before you ever drop onto Verdansk, the lobby is doing one thing: assigning everyone a routable address so the server knows where to send shots, footsteps, and kill-cam packets. Without that address, you don't exist on the map. The moment your address is known, every other player in the lobby can — in theory — be told where to send rounds at you. **That's exactly what an IP address is — a routable identifier that puts a host on the map, which means it can talk, and it also means it can be shot at.**

Plain English: **IP** is the addressing and delivery layer of the internet. Every device that wants to send or receive data over a TCP/IP network has an IP address. Routers use that address to forward packets toward the destination. Without IP, the entire stack above it — TCP, UDP, HTTP, DNS, TLS — has nowhere to go.

Technical: **IP (Internet Protocol)** operates at Layer 3 (Network) of the OSI model and is the foundational protocol of the TCP/IP suite. It provides connectionless, best-effort delivery of packets between hosts identified by 32-bit (IPv4) or 128-bit (IPv6) addresses. IP itself does not guarantee delivery, ordering, or integrity — those are jobs for TCP or application-layer protocols above it.

For CySA+ Objective 2.2, you don't get tested on IP packet headers. You get tested on **how vulnerability tools use IP** — scanning ranges, mapping live hosts, fingerprinting services, and turning a CIDR block into a list of things to defend or attack.

## Why it matters

Every vulnerability assessment tool in the CompTIA tool list starts the same way: *give me an IP or a range, and I'll tell you what's there.* Nmap, Nessus, OpenVAS, Angry IP Scanner, Nikto, Burp, Metasploit — they all consume IP addresses or hostnames as input. If you can't reason about IP ranges, subnetting, and what's reachable from where, you can't run a scan that produces useful output, and you can't read scan output and know what it means.

Exam relevance is **CS0-003 Objective 2.2** — analyzing output from vulnerability assessment tools. The IP context is the spine of that objective. CompTIA will hand you scan output and ask which tool produced it, what the next step is, and what the IP scope tells you about the engagement.

Career relevance: an L1 analyst who confuses *internal RFC1918 traffic* with *internet-facing traffic* will waste hours chasing fake severity. An IP showing up in your SIEM as `10.50.200.14` is a very different conversation than `198.51.100.14`. Knowing which is which is the first triage move on every alert that involves a network indicator.

## Key facts

### IP addressing fundamentals

| Concept | IPv4 | IPv6 |
|---|---|---|
| Address size | 32-bit | 128-bit |
| Notation | Dotted decimal `192.168.1.10` | Hex colon `2001:db8::1` |
| Private ranges (RFC1918) | `10.0.0.0/8`, `172.16.0.0/12`, `192.168.0.0/16` | `fc00::/7` (ULA) |
| Loopback | `127.0.0.0/8` | `::1/128` |
| Link-local | `169.254.0.0/16` | `fe80::/10` |
| Documentation | `192.0.2.0/24`, `198.51.100.0/24`, `203.0.113.0/24` | `2001:db8::/32` |

**[[CIDR notation]]** — `/24` means the first 24 bits are network, the rest is host. `192.168.1.0/24` = 256 addresses, 254 usable. Scan scope is almost always expressed in CIDR.

### Tools that consume IP ranges (CompTIA list)

CompTIA Objective 2.2 names a specific tool inventory. Group them by what they actually do — that's how scenario questions are written.

**Network scanning and mapping** — turn IP ranges into asset inventories.

| Tool | Purpose | Notes |
|---|---|---|
| **[[Nmap]]** | Port scan, service/version detection, OS fingerprint, NSE scripts | The reference scanner. `-sS` SYN scan, `-sV` version, `-O` OS, `-A` aggressive |
| **Angry IP Scanner** | Lightweight ping sweep + port check | GUI, fast, lower fidelity than Nmap. Good for quick host discovery |
| **[[Maltego]]** | OSINT graph linking IPs, domains, people, orgs | Recon, not direct scanning. Visual link analysis |
| **Recon-ng** | Framework for passive OSINT modules | Web-based recon, API-driven |

**Vulnerability scanners** — go from "host exists" to "host has CVE-2024-X."

| Tool | Notes |
|---|---|
| **[[Nessus]]** | Tenable's commercial scanner. Most common in enterprise. Plugin-based |
| **[[OpenVAS]]** | Open-source fork lineage from Nessus. Now Greenbone |
| **Nikto** | Web server scanner — checks for outdated software, dangerous files, misconfigs |

**Web application scanners** — speak HTTP, not just IP.

| Tool | Notes |
|---|---|
| **[[Burp Suite]]** | The web app proxy. Intercept, repeat, intruder, scanner |
| **[[OWASP ZAP]]** (Zed Attack Proxy) | Open-source Burp equivalent |
| **Arachni** | Ruby-based web app scanner, less common in modern shops |

**Multipurpose / exploit frameworks.**

| Tool | Notes |
|---|---|
| **[[Metasploit Framework]]** (MSF) | Exploit modules, payloads, post-exploitation. The pentester's swiss army knife |

**Debuggers** — reverse engineering and exploit dev, not scanning.

| Tool | Notes |
|---|---|
| **Immunity Debugger** | Windows debugger, Python scriptable, exploit dev favorite |
| **GDB** (GNU Debugger) | Linux/Unix debugger, also reverse engineering |

**Cloud infrastructure assessment** — IP is fuzzier here; assets are API-identified.

| Tool | Cloud | Notes |
|---|---|---|
| **Scout Suite** | Multi-cloud (AWS, Azure, GCP) | Config auditing |
| **Prowler** | AWS-focused | CIS benchmarks, compliance |
| **Pacu** | AWS | Offensive — post-exploitation framework |

### Scan types and what they tell you

| Scan type | What it does | Trade-off |
|---|---|---|
| **Ping sweep** | ICMP echo to range | Fast, but ICMP is often blocked |
| **TCP SYN (half-open)** | Send SYN, see SYN/ACK, don't complete | Quiet-ish, default for Nmap `-sS` |
| **TCP connect** | Full three-way handshake | Logged on target, noisy |
| **UDP scan** | Send UDP packets, infer from ICMP unreachable | Slow, unreliable, but DNS/SNMP/NTP need it |
| **Credentialed scan** | Authenticate to host, enumerate from inside | Deeper, fewer false positives, requires creds |
| **Uncredentialed scan** | External view only | What an attacker sees, but shallow |
| **Active** | Sends packets to target | Detectable, can crash fragile services |
| **Passive** | Sniff traffic, no packets sent | Stealthy, slow, limited coverage |
| **Agent-based** | Software on host reports up | Works for mobile/remote assets |
| **Agentless** | Network-side scanning | No host install, but needs network reach |

### Reading scan output — what an analyst actually does

Sample Nmap output:

```
Nmap scan report for 10.50.12.44
Host is up (0.0021s latency).
PORT     STATE  SERVICE  VERSION
22/tcp   open   ssh      OpenSSH 7.4 (protocol 2.0)
80/tcp   open   http     Apache httpd 2.4.6 ((CentOS))
443/tcp  open   ssl/http Apache httpd 2.4.6
3389/tcp open   ms-wbt-server Microsoft Terminal Services
```

What this tells you in 10 seconds:
- Internal IP (RFC1918) — not internet-facing from this output
- **OpenSSH 7.4** — old, multiple CVEs since 2017. Investigate
- **Apache 2.4.6 on CentOS** — CentOS 7 default. CentOS 7 hit EOL 2024-06-30. **Unsupported. This is the headline finding.**
- **RDP (3389) open alongside SSH** — mixed-OS host or RDP exposure on Linux that shouldn't be there. Validate.

### CompTIA exam traps

> **CompTIA exam trap:** *Nmap vs Nessus vs Nikto.* Nmap maps the network — ports, services, versions. Nessus runs vulnerability checks against discovered hosts — CVE matching, config audit. Nikto is web-server-specific. A question that asks "which tool identified CVE-2021-44228 on the Apache server" wants Nessus or OpenVAS, **not** Nmap. Nmap finds the port; the vuln scanner names the CVE.

> **CompTIA exam trap:** *Burp Suite vs ZAP vs Nikto.* Burp and ZAP are interactive web proxies — intercept and manipulate HTTP requests. Nikto is non-interactive — fires known web-server checks and prints findings. If the scenario describes a tester modifying request parameters mid-flight, it's Burp or ZAP, never Nikto.

> **CompTIA exam trap:** *Credentialed vs uncredentialed scans.* CompTIA loves "the scan missed the vulnerability — why?" The answer is almost always *the scan was uncredentialed, so it couldn't enumerate installed packages, registry keys, or local config.* Credentialed scans see the inside of the host. Run them when possible.

> **CompTIA exam trap:** *Scout Suite vs Prowler vs Pacu.* Scout Suite is multi-cloud config auditing. Prowler is AWS-focused defensive auditing (CIS benchmarks). Pacu is **offensive** AWS post-exploitation. A question about "auditing AWS for misconfigured S3 buckets" wants Scout Suite or Prowler. "After compromising an IAM key, the tester pivoted using ___" wants Pacu.

> **CompTIA exam trap:** *Immunity Debugger and GDB are debuggers, not scanners.* If a question lists them in a vuln-management context, they're for **exploit development or malware reverse engineering** — not for finding vulnerabilities on a network. Don't pick them for "the analyst scanned the network and found..."

### Active vs passive in IP context

- **Active scanning** sends packets to the target. Detectable by IDS, can be blocked by firewall, can crash legacy ICS/SCADA gear. Run change windows, get approval.
- **Passive scanning** sniffs traffic already on the wire. Tools like **[[Zeek]]** or NetFlow collection identify hosts by observation. No risk to target, but you only see hosts that talk.

CompTIA loves passive scanning for **OT/ICS environments** — the classic answer to "the scan crashed the PLC, what should we have done?" is *use passive scanning in OT environments.*

## SOC reality

- The first thing an L1 does with an IP indicator is **classify it**: internal (RFC1918), public, or known-bad (threat intel hit). That decision routes the ticket. An internal-to-internal SSH alert is workstation-to-jumphost noise 90% of the time. An external IP from a known C2 panel hitting your DMZ is wake-the-IR-lead.
- When the CISO asks "what's our exposure?", what they actually want is *the list of internet-routable IPs we own, what's listening on each, and which of those services has a critical CVE.* That's an Nmap-plus-Nessus output, filtered to public IPs, sorted by CVSS. Have that report ready before they ask.
- Never run an active Nmap scan against production without a change ticket. *Scanning a printer with `-A` and bricking it during quarter-end close is a career-defining moment, and not the good kind.*
- Scan output is a snapshot, not truth. The Nessus report from Tuesday is already stale Wednesday morning. New hosts spin up, services restart on different ports, ephemeral containers come and go. Tie scans to **[[asset inventory]]** and re-scan continuously.
- The handoff from vuln management to IR is the IP. Vuln team says *10.50.12.44 has CVE-2024-X*. IR team says *10.50.12.44 just beaconed to 198.51.100.77 on port 443.* The IP is the join key between "could be exploited" and "is being exploited." *That correlation is the entire job.*

## Related concepts

[[Nmap]] · [[Nessus]] · [[OpenVAS]] · [[Burp Suite]] · [[OWASP ZAP]] · [[Metasploit Framework]] · [[Maltego]] · [[CIDR notation]] · [[CVSS]] · [[Asset inventory]] · [[Credentialed scan]] · [[Passive scanning]] · [[Zeek]] · [[Vulnerability management lifecycle]] · [[Threat intelligence]] · [[OSINT]]

*Source: VIRGIL knowledge base — 2026-05-11*