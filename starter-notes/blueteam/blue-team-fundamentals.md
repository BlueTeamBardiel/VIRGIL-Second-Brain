---
domain: "Blue Team / Defensive Security"
section: "fundamentals"
tags: [blue-team, soc, incident-response, threat-hunting, dfir, wireshark, snort]
---

# Blue Team Fundamentals

The **blue team** defends. While red teams simulate attackers, blue teams detect, respond to, and recover from attacks — and more importantly, build the systems that make detection possible in the first place. If pentesting is learning how to pick locks, blue team work is learning how to build better locks, install cameras, and know exactly when someone tried to get in.

For beginners, blue team work is often more accessible than offensive security — you don't need a target to practice. You need logs, packet captures, and the ability to ask the right questions of data.

---

## Overview

Blue team operations center on three functions: **detect**, **respond**, and **recover**. Detection without response is noise. Response without detection is luck. Recovery without either is chaos.

Modern blue team work happens across several roles: **SOC Analyst** (tier 1-3, alert triage and escalation), **Incident Responder** (active investigation and containment), **Threat Hunter** (proactive search for undetected compromise), **Digital Forensics Analyst** (evidence collection and analysis), and **Detection Engineer** (builds the rules and logic that generate alerts).

Most entry-level blue team roles start at SOC Tier 1 — monitoring a SIEM dashboard, triaging alerts, determining what's a real incident versus a false positive. It is repetitive. It is also where you build the pattern recognition that makes everything else possible.

---

## The SOC Workflow

**Alert → Triage → Investigate → Escalate/Close**

**Triage questions:**
- Is this alert a true positive or false positive?
- What is the affected asset and its business criticality?
- Is this an isolated event or part of a pattern?
- Is there evidence of lateral movement or data exfiltration?
- Does this match a known threat actor TTP?

**Tools at each stage:**
- **SIEM** ([[Splunk]], [[Wazuh]], [[ELK Stack]]) — aggregate logs, correlate events, generate alerts
- **EDR** ([[Microsoft Defender for Endpoint]], CrowdStrike) — endpoint telemetry, process trees, file activity
- **Packet capture** ([[Wireshark]], [[tcpdump]]) — network-level evidence
- **Threat intel** ([[MITRE ATT&CK]], VirusTotal, AbuseIPDB) — context on IOCs

---

## Wireshark

[[Wireshark]] is the standard tool for network packet analysis. A packet capture (.pcap file) is a recording of network traffic — Wireshark lets you read it, filter it, and understand exactly what happened on the wire.

### Essential Filter Syntax

```
# Filter by IP
ip.addr == 192.168.1.100
ip.src == 10.0.0.1
ip.dst == 8.8.8.8

# Filter by protocol
tcp
udp
http
dns
icmp
ftp
smtp

# Filter by port
tcp.port == 80
tcp.port == 443
udp.port == 53

# Filter by content
http.request.method == "POST"
http contains "password"
dns.qry.name contains "malware"

# Combine filters
ip.src == 192.168.1.100 && tcp.port == 80
http.request || http.response
not arp && not icmp

# Find large transfers (potential exfiltration)
tcp.len > 1000

# Follow a TCP stream
# Right-click a packet → Follow → TCP Stream
```

### Blue Team Use Cases

**Detecting C2 beaconing:**
- Regular, periodic connections to external IPs
- Filter: `ip.dst == <suspicious IP>` then check timing regularity
- Beacons often have consistent packet sizes

**Detecting DNS tunneling:**
- Unusually long DNS queries
- High volume of DNS requests to single domain
- Filter: `dns.qry.name` — look for base64-encoded subdomains

**Detecting credential theft:**
- HTTP POST to login pages (cleartext passwords if not HTTPS)
- Filter: `http.request.method == "POST"` then follow stream

**Analyzing malware traffic:**
- Export HTTP objects (File → Export Objects → HTTP) to extract downloaded files
- Look for User-Agent strings that don't match browsers
- Filter: `http.user_agent` — malware often uses generic or missing UAs

**CTF pcap challenges:**
- Start with Statistics → Protocol Hierarchy to see what's in the file
- Statistics → Conversations to find the busiest hosts
- Filter for credentials in cleartext protocols (FTP, HTTP, Telnet)
- Export files from HTTP, SMB, FTP streams

---

## Snort / Suricata

[[Snort]] and [[Suricata]] are **intrusion detection/prevention systems (IDS/IPS)**. They analyze network traffic against a ruleset and generate alerts (IDS) or block traffic (IPS). Suricata is the modern standard — multithreaded, actively maintained, compatible with Snort rules.

### Rule Structure

```
action protocol src_ip src_port direction dst_ip dst_port (options)

# Example: detect Nmap SYN scan
alert tcp any any -> $HOME_NET any (msg:"Possible Nmap SYN Scan"; flags:S; threshold:type threshold, track by_src, count 20, seconds 1; sid:1000001; rev:1;)

# Detect HTTP with suspicious User-Agent
alert http any any -> any any (msg:"Suspicious User-Agent"; http.user_agent; content:"sqlmap"; nocase; sid:1000002; rev:1;)

# Detect DNS query for known malicious domain
alert dns any any -> any any (msg:"Known C2 Domain"; dns.query; content:"evil-c2.com"; nocase; sid:1000003; rev:1;)

# Detect FTP login attempt
alert tcp any any -> $HOME_NET 21 (msg:"FTP Login Attempt"; content:"USER"; nocase; sid:1000004; rev:1;)
```

### Rule Options Reference

| Option | Purpose | Example |
|--------|---------|---------|
| `msg` | Alert message | `msg:"Suspicious activity"` |
| `content` | Match payload string | `content:"password"` |
| `nocase` | Case-insensitive match | `content:"GET"; nocase` |
| `pcre` | Regex match | `pcre:"/malware\d+/i"` |
| `flags` | TCP flags | `flags:S` (SYN), `flags:SF` (SYN-FIN) |
| `threshold` | Rate limiting | `threshold:type both, track by_src, count 5, seconds 60` |
| `sid` | Rule ID | `sid:1000001` |
| `rev` | Rule revision | `rev:1` |
| `classtype` | Alert classification | `classtype:attempted-recon` |

### Running Suricata in COCYTUS

```bash
# Install
sudo apt install suricata -y

# Test a rule file
suricata -T -c /etc/suricata/suricata.yaml

# Run against a pcap
suricata -r capture.pcap -l /var/log/suricata/

# Run live on interface
suricata -i eth0

# Check alerts
tail -f /var/log/suricata/fast.log
cat /var/log/suricata/eve.json | jq '.alert'
```

---

## Incident Response

[[Incident Response]] follows a defined process. The most common framework is NIST SP 800-61:

**1. Preparation** — IR plan written, team trained, tools deployed, logging enabled
**2. Detection and Analysis** — identify that an incident occurred, determine scope
**3. Containment** — stop the bleeding; short-term (isolate system) and long-term (patch, rebuild)
**4. Eradication** — remove the threat; malware, backdoors, compromised accounts
**5. Recovery** — restore systems to normal operation, verify clean
**6. Post-Incident Activity** — lessons learned, update defenses, document timeline

### Triage Checklist for a Compromised Host

```bash
# Who is logged in?
who
w
last

# What processes are running?
ps aux
ps auxf  # tree view

# What network connections exist?
ss -tulnp
netstat -tulnp

# What listening ports?
ss -tlnp

# Recent file modifications
find / -mtime -1 -type f 2>/dev/null | head -50

# Check for suspicious cron jobs
crontab -l
cat /etc/crontab
ls /etc/cron.*

# Check startup items
systemctl list-units --type=service --state=running
ls /etc/init.d/

# Check for SUID binaries (privesc vector)
find / -perm -4000 2>/dev/null

# Check bash history
cat ~/.bash_history
cat /root/.bash_history

# Check /tmp and /dev/shm (common malware staging areas)
ls -la /tmp /dev/shm

# Check for hidden files
find / -name ".*" -type f 2>/dev/null | grep -v proc
```

### Evidence Collection — Chain of Custody

Before touching anything on a compromised system, document:
- Date and time (UTC)
- Who collected the evidence
- What was collected and from where
- Hash of every file collected (`sha256sum`)
- System state at time of collection

```bash
# Create forensic image of memory (if needed)
sudo lime -o /tmp/memory.lime format=lime

# Hash everything you collect
sha256sum suspicious_file.exe > suspicious_file.exe.sha256

# Capture network state before isolating
ss -tulnp > /tmp/ir-network-$(date +%Y%m%d%H%M).txt
ps aux > /tmp/ir-processes-$(date +%Y%m%d%H%M).txt
```

---

## Threat Hunting

Threat hunting is **proactive** — you're looking for compromise that hasn't triggered an alert. It starts with a hypothesis based on threat intelligence.

**Hypothesis examples:**
- "An attacker with T1053 (scheduled tasks) persistence would create new tasks in the last 30 days"
- "A host communicating with known C2 infrastructure would have unusual outbound connections on non-standard ports"
- "A credential dumping attack would show lsass.exe being accessed by unusual processes"

**Hunt process:**
1. Form hypothesis based on threat intel or ATT&CK technique
2. Identify data sources that would show evidence (logs, EDR, pcap)
3. Query for anomalies
4. Investigate hits
5. If confirmed — escalate to IR
6. If not found — document hunt, update detections to catch it next time

**Wazuh query examples:**
```
# Find failed logins followed by success (credential stuffing)
data.win.eventdata.logonType:3 AND rule.id:60122

# Find PowerShell with encoded commands (obfuscation)
data.win.eventdata.commandLine:*-EncodedCommand*

# Find new services installed
rule.id:7030
```

---

## Log Analysis

Logs are the blue team's primary evidence source. Know where they live and what they contain.

**Linux:**
```bash
/var/log/auth.log       # SSH, sudo, authentication
/var/log/syslog         # General system events
/var/log/apache2/       # Web server access and error
/var/log/nginx/         # Nginx access and error
journalctl -u ssh       # SSH service journal
journalctl -f           # Live log stream
```

**Windows:**
```
Event ID 4624  # Successful logon
Event ID 4625  # Failed logon
Event ID 4648  # Logon with explicit credentials
Event ID 4688  # Process creation
Event ID 4698  # Scheduled task created
Event ID 7045  # New service installed
Event ID 4720  # User account created
Event ID 1102  # Audit log cleared (suspicious)
```

**Critical Windows Event IDs to monitor:**
- 4625 in volume = brute force attempt
- 4648 = pass-the-hash or runas activity
- 4688 + `cmd.exe` spawned by `word.exe` = macro execution
- 1102 = attacker covering tracks

---

## MITRE ATT&CK for Blue Teams

[[MITRE ATT&CK]] is a knowledge base of adversary tactics, techniques, and procedures (TTPs). Blue teams use it to:
- Map detections to specific techniques
- Identify gaps in coverage
- Communicate findings in a common language
- Build threat hunt hypotheses

**The 14 tactics (in attack order):**
1. Reconnaissance
2. Resource Development
3. Initial Access
4. Execution
5. Persistence
6. Privilege Escalation
7. Defense Evasion
8. Credential Access
9. Discovery
10. Lateral Movement
11. Collection
12. Command and Control
13. Exfiltration
14. Impact

For every alert you investigate, ask: *which ATT&CK technique does this map to?* That question connects individual events to adversary behavior patterns.

---

## CTF Blue Team Challenges

Blue team CTF challenges typically involve:
- **Pcap analysis** — find the attack in the packet capture
- **Log analysis** — find the breach in the log files
- **Memory forensics** — extract artifacts from a memory dump using Volatility
- **Disk forensics** — analyze a disk image for evidence
- **Malware analysis** — static/dynamic analysis of a malicious binary

**Volatility (memory forensics):**
```bash
# Identify OS profile
volatility -f memory.lime imageinfo

# List processes
volatility -f memory.lime --profile=Linux64 linux_pslist

# Network connections
volatility -f memory.lime --profile=Win10x64 netscan

# Find injected code
volatility -f memory.lime --profile=Win10x64 malfind
```

---

## Related Topics

[[Wireshark]], [[Snort]], [[Suricata]], [[Wazuh]], [[Splunk]], [[SIEM]], [[Incident Response]], [[MITRE ATT&CK]], [[Threat Hunting]], [[Digital Forensics]], [[DFIR]], [[Log Analysis]], [[Nmap]], [[Penetration Testing]], [[Red Team]], [[SOC]], [[EDR]], [[OWASP Juice Shop]], [[CTF Approach]]
