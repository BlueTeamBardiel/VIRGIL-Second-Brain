# Security Tools

## What it is

In Halo, the Master Chief's HUD doesn't just show his shields — it tags hostiles, paints waypoints, scans terrain through the visor, and tells him exactly which Covenant patrol is about to ruin his afternoon. **Security tools** are the analyst's HUD: software that scans, sniffs, scopes, and surfaces the threats lurking on the network before they punch through your shields.

**Security tools** are the categorized utilities used to assess vulnerabilities, capture and analyze traffic, enumerate hosts, and validate security posture, as enumerated in SY0-701 Objective 4.4.

## Why it matters

Without these tools, a defender is fighting Elites with a flashlight. CompTIA expects you to know not just that a tool exists, but **what category it belongs to and what specific output it produces**. Objective 4.4 explicitly lists packet captures, log data, vulnerability scanners, and reconnaissance utilities — and the exam loves to swap them. The classic trap: confusing **Nmap** (port/service discovery) with **Nessus** (vulnerability scanning), or **Wireshark** (passive capture) with **tcpreplay** (replays captured traffic). Pick the wrong tool on the exam, and you've also picked the wrong tool on the job — which is how breaches happen and how auditors write very long reports.

## Key facts

### Reconnaissance and discovery

| Tool | Function | Notes |
|---|---|---|
| **[[Nmap]]** | Port scanner, service/version detection, OS fingerprinting | `-sS` SYN scan, `-sV` version, `-O` OS detect |
| **[[Netcat]]** (`nc`) | Banner grabbing, raw TCP/UDP connections, simple bind/reverse shells | "TCP/IP Swiss Army knife" |
| **[[theHarvester]]** | OSINT email/subdomain enumeration | Pulls from search engines, certificate transparency |
| **[[Shodan]]** | Internet-of-things and exposed-service search engine | Finds devices indexed by banner |
| **[[Maltego]]** | Link analysis / OSINT graphing | Relationship mapping |
| **[[Recon-ng]]** | Modular OSINT framework | Metasploit-style interface |
| **[[curl]]** / **[[Wget]]** | HTTP request crafting and retrieval | Useful for header inspection |

### Vulnerability scanners

| Tool | Type |
|---|---|
| **[[Nessus]]** | Authenticated/unauthenticated network vulnerability scanner |
| **[[OpenVAS]]** | Open-source vuln scanner (Greenbone) |
| **[[Qualys]]** | Cloud-based vulnerability management |
| **[[Nikto]]** | Web server scanner — outdated software, misconfigs |
| **[[Burp Suite]]** | Web application proxy/scanner |
| **[[OWASP ZAP]]** | Open-source web app scanner |
| **[[sqlmap]]** | Automated SQL injection detection/exploitation |

### Packet capture and protocol analysis

- **[[Wireshark]]** — GUI packet analyzer; reads/writes `.pcap` and `.pcapng`. Display filters (`http.request.method == "POST"`) ≠ capture filters (`tcp port 80`).
- **[[tcpdump]]** — CLI packet capture; `-i eth0 -w capture.pcap`. The Linux default.
- **[[tshark]]** — CLI Wireshark.
- **[[NetFlow]]** / **[[sFlow]]** / **[[IPFIX]]** — Flow data (metadata, not payload). NetFlow = Cisco; IPFIX = standardized version.

### Password and credential tools

| Tool | Use |
|---|---|
| **[[John the Ripper]]** | Offline hash cracking, multiple modes |
| **[[Hashcat]]** | GPU-accelerated hash cracking |
| **[[Hydra]]** | Online (network) brute force — SSH, FTP, HTTP |
| **[[Cain & Abel]]** | Legacy Windows password recovery |

### Exploitation and post-exploitation

- **[[Metasploit Framework]]** — Modular exploit/payload/listener platform. `msfconsole`, `meterpreter`.
- **[[Cobalt Strike]]** — Commercial red team C2 (heavily abused by threat actors).
- **[[BloodHound]]** — Active Directory attack-path graphing.
- **[[Mimikatz]]** — Credential extraction from LSASS (pass-the-hash, golden tickets).

### Wireless tools

- **[[Aircrack-ng]]** suite — `airodump-ng` (capture), `aireplay-ng` (inject), `aircrack-ng` (crack WEP/WPA handshakes).
- **[[Kismet]]** — Wireless detection, sniffing, IDS for 802.11.

### Forensic and file analysis

| Tool | Function |
|---|---|
| **[[Autopsy]]** / **[[Sleuth Kit]]** | Disk forensics |
| **[[FTK Imager]]** | Forensic imaging |
| **[[dd]]** | Bit-level disk imaging |
| **[[Volatility]]** | Memory forensics |
| **[[strings]]** | Extract printable text from binaries |
| **[[hexdump]]** / **[[xxd]]** | Raw byte inspection |

### Logs and SIEM data sources (Obj 4.4)

- **Firewall logs**, **application logs**, **endpoint logs**, **OS-specific logs** (Windows Event Viewer, `/var/log/`), **IPS/IDS logs**, **network logs**, **metadata**.
- **[[Vulnerability scans]]** output — feeds remediation tickets.
- **[[Dashboards]]** — visualize SIEM correlation results.
- **[[Automated reports]]** — compliance evidence.
- **[[Packet captures]]** — ground truth when logs lie.

### CompTIA's favorite traps

1. **Nmap ≠ Nessus.** Nmap finds open ports and services; Nessus identifies known CVEs against those services.
2. **Wireshark captures, it does not exploit.** It's passive.
3. **Hydra is online, John/Hashcat are offline.** Online = against a live service; offline = against a stolen hash file.
4. **Netcat is not a vulnerability scanner.** It's a connection tool. People use it for banner grabbing, which is reconnaissance, not vulnerability assessment.
5. **`dd` is for imaging, not analysis.** Pair it with Autopsy or Volatility.

## Related concepts

[[Vulnerability Management]] · [[Penetration Testing]] · [[SIEM]] · [[Log Analysis]] · [[Incident Response]] · [[Digital Forensics]] · [[Reconnaissance]] · [[OSINT]] · [[Threat Hunting]]

---
*Source: VIRGIL knowledge base — 2026-05-08*