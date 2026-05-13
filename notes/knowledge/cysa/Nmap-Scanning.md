# Nmap & Scanning

## What it is

In **Valorant**, a Cypher player drops a Spycam in mid, watches a Sova arrow paint enemy positions on Bind A-site, and pulls Trip Wires across the connector before contact. Before the round runs hot, he already knows what's on the map, where it's standing, and which doors will scream when something walks through. That's reconnaissance — and that's exactly what **Nmap** does to a network. Before any exploit, before any vuln scanner authenticates, before any IR call gets made, somebody runs a scan to find out which hosts are alive, which ports answer, and which services are listening on them.

In plain English: Nmap is the tool that knocks on every door of every house on the block and writes down who answered, how they answered, and what version of doorbell they're running.

Technically: **Nmap (Network Mapper)** is an open-source [[network scanning]] and host discovery tool that performs [[port scanning]], [[service detection|service and version detection]], OS fingerprinting, and scripted vulnerability checks via the Nmap Scripting Engine (NSE). It's the foundational tool for the discovery phase of [[vulnerability management]] and the first thing in every pentester's and analyst's kit.

## Why it matters

You cannot defend what you cannot see. The first step in [[vulnerability management]] is asset discovery — knowing which hosts exist and what they expose. Every vuln scanner ([[Nessus]], [[OpenVAS]], Qualys) starts the same way: a discovery sweep that's essentially Nmap wearing a corporate logo.

On CS0-003 Objective 2.2, you're expected to read scan output, identify what was scanned vs what was missed, and pick the right flags for a given scenario. CompTIA *loves* asking about Nmap defaults, scan types, and stealth flags because those are the questions that punish people who memorized "nmap is a port scanner" and stopped there.

Real-world stakes: an attacker's first move against your perimeter is a scan. If your detection stack doesn't catch a slow `-T0 -sS` sweep, you're going to learn what your external attack surface looks like the same way the attacker did — from the wrong side.

## Key facts

### What Nmap actually does

| Capability | Flag | What it does |
|---|---|---|
| Host discovery | `-sn` | Ping sweep only, no port scan |
| Skip host discovery | `-Pn` or `-P0` | Assume host is up, scan anyway |
| TCP SYN scan | `-sS` | Half-open; never completes 3-way handshake (default for root) |
| TCP connect scan | `-sT` | Full handshake; loud, logged everywhere (default for non-root) |
| UDP scan | `-sU` | Slow, unreliable, but the only way to find UDP services |
| Service version detection | `-sV` | Banner-grab + probe to identify service and version |
| OS detection | `-O` | TCP/IP stack fingerprinting |
| Aggressive | `-A` | OS + version + scripts + traceroute, all at once |
| NSE scripts | `--script=<name>` | Run scripted checks (e.g. `vuln`, `smb-enum`) |
| Output to file | `-oN`, `-oX`, `-oG`, `-oA` | Normal, XML, grepable, or all formats |

### Port specification — the trap CompTIA loves

**Default Nmap behavior is to scan the top 1,000 most common TCP ports.** Not all 65,535. Not the first 1,000 sequentially — the top 1,000 *by frequency* from Nmap's services file.

| Flag | Scans |
|---|---|
| (no `-p`) | Top 1,000 TCP ports |
| `-p 1-1024` | Ports 1 through 1024 |
| `-p-` | All 65,535 TCP ports |
| `-p 1-65535` | Same as `-p-` |
| `-p 80,443,3389` | Specific ports only |
| `-p T:80,U:53` | Mix TCP and UDP |
| `-F` | Fast scan — top 100 ports |

If a default Nmap scan returns nothing, you have **not** confirmed the host has no services. You've confirmed it has nothing listening on the top 1,000 TCP ports. A C2 implant beaconing out on TCP/4444 will not show up. A misconfigured Redis on TCP/16379 will not show up.

> **CompTIA exam trap:** "Nmap returns no results. What do you know about the host?" The right answer is *"no TCP services reachable on Nmap's default 1,000 ports."* The wrong answer is *"no services running"* or *"all 65,535 ports closed."* CompTIA will absolutely put both wrong options in the choices to bait people who forgot the default.

### Scan types — and what they sound like on the wire

- **`-sS` SYN scan (half-open):** sends SYN, gets SYN/ACK or RST, sends RST. Never completes the handshake. The connection never reaches the application layer, so most service-level logs miss it. Firewalls and IDS still see it.
- **`-sT` TCP connect scan:** full 3-way handshake. The OS handles it via the connect() syscall, which means **every service logs the connection**. This is the loudest scan type in the kit.
- **`-sU` UDP scan:** sends UDP packet, infers state from ICMP unreachable replies. Slow because rate-limited by the target's ICMP responses. Often missed in pentest engagements because people forget UDP services exist — DNS (53), SNMP (161), NTP (123), and a pile of OT/ICS protocols all live here.
- **`-sA` ACK scan:** doesn't find open ports — finds firewall rules. Useful for mapping which ports are filtered vs unfiltered.
- **`-sN` `-sF` `-sX` Null/FIN/Xmas scans:** weird flag combinations that exploit RFC 793 ambiguity to slip past stateless firewalls. Don't work on Windows. Stealth flavor; rarely useful in modern engagements.

### Timing templates — the stealth dial

| Template | Name | Speed | Use case |
|---|---|---|---|
| `-T0` | Paranoid | ~5 min between probes | IDS evasion |
| `-T1` | Sneaky | ~15 sec between probes | IDS evasion |
| `-T2` | Polite | Slow, low bandwidth | Don't crash fragile targets |
| `-T3` | Normal | Default | General use |
| `-T4` | Aggressive | Fast, assumes good network | Internal scans |
| `-T5` | Insane | Very fast, packet loss likely | Speed > accuracy |

Stealth = `-sS` (don't complete handshake) + `-Pn`/`-P0` (don't ping first) + `-T0` or `-T1` (slow enough to slip under IDS time-window thresholds). Loud = `-sT -T4 -A`.

> **CompTIA exam trap:** "Which scan is stealthiest?" The answer combines all three: SYN scan, no ping, paranoid timing. `-sT -T0` is wrong because `-sT` completes the full handshake regardless of timing — the application layer still logs it. Stealth is about scan type *and* host discovery *and* timing, not just slowing things down.

### NSE — Nmap Scripting Engine

The NSE turns Nmap from a port scanner into a multi-tool. Categories matter:

- `--script=default` or `-sC` — safe, fast checks
- `--script=vuln` — runs vulnerability detection scripts (e.g. `smb-vuln-ms17-010` for EternalBlue)
- `--script=discovery` — enumeration scripts
- `--script=exploit` — actively exploits findings (don't run on prod without authorization)

`nmap -sV --script=vuln <target>` is a quick triage move when you find a host you don't recognize — version detection plus known-vuln checks in one command.

### The flag stack to memorize

For CS0-003, these combinations come up:

- **Full TCP + version detection:** `nmap -p- -sS -sV <target>` (or `-p 1-65535`)
- **Stealth external recon:** `nmap -sS -Pn -T0 <target>`
- **Fast internal sweep:** `nmap -sn 10.0.0.0/24` (ping sweep only)
- **Everything-at-once:** `nmap -A -p- <target>` (slow but thorough)
- **UDP plus TCP top ports:** `nmap -sS -sU --top-ports 100 <target>`

### Where Nmap sits in the tool stack

Nmap is discovery. It's not a vulnerability scanner in the [[Nessus]]/[[OpenVAS]] sense — it tells you what's listening, not whether what's listening is patched. The full Objective 2.2 stack:

- **Discovery / mapping:** Nmap, [[Angry IP Scanner]], [[Maltego]], [[Recon-ng]]
- **Vulnerability scanners:** [[Nessus]], [[OpenVAS]], Qualys
- **Web app scanners:** [[Burp Suite]], [[Zed Attack Proxy|ZAP]], [[Nikto]], [[Arachni]]
- **Cloud assessment:** [[Scout Suite]], [[Prowler]], [[Pacu]]
- **Exploitation framework:** [[Metasploit]] (often imports Nmap XML output directly via `db_import`)
- **Debuggers:** [[GDB]], [[Immunity Debugger]] (for binary/exploit work, not scanning)

Real workflow: Nmap finds the hosts and services → Nessus/OpenVAS scans those hosts for known CVEs → Burp/ZAP attacks the web apps → Metasploit weaponizes the findings.

## SOC reality

- **The alert at 3am:** your perimeter IDS lights up with "TCP SYN scan from external IP, 500 hosts, 1,000 ports each." L1 checks if it's the scheduled internal scan from the security team's scanner subnet. If the source IP isn't on the allowlist, it's an externally-initiated recon attempt — log it, block at the edge, look for follow-on traffic from the same ASN.
- **The slow-burn case:** you don't see the scan. Three weeks later, IR finds a `-T0 -sS` scan in the firewall logs spread across 14 days, from a residential IP the attacker rotated through. The scan was below your IDS threshold because your IDS aggregates over a 5-minute window and the attacker probed every 4 minutes. *That's why CISOs care about the threshold tuning conversation L1 thinks is boring.*
- **The internal-use case:** your team runs Nmap weekly to baseline the network. New host appears in the scan output that wasn't there last week? That's either an unauthorized device, shadow IT, or an attacker's beachhead. Nmap is a defender's tool as much as an attacker's.
- **What the IR lead asks:** "Was the scan credentialed or unauth? Top 1,000 ports or `-p-`? Did we capture the source IP and the user-agent equivalent (TCP options, TTL, window size)? Did anything from that IP make it past the perimeter to an actual service?"
- **Never promise:** "we blocked it at the firewall" until you've checked all firewall rules, NAT rules, and any cloud egress paths. Recon traffic loves to find the path you forgot existed.

## Related concepts

[[Vulnerability management]] · [[Vulnerability scanning]] · [[Nessus]] · [[OpenVAS]] · [[Burp Suite]] · [[Zed Attack Proxy]] · [[Nikto]] · [[Metasploit]] · [[Recon-ng]] · [[Maltego]] · [[Angry IP Scanner]] · [[Network scanning]] · [[Port scanning]] · [[Service detection]] · [[CVSS]] · [[Attack surface]] · [[Reconnaissance]] · [[Cyber Kill Chain]] · [[MITRE ATT&CK]] · [[IDS]] · [[IPS]]

*Source: VIRGIL knowledge base — 2026-05-11*