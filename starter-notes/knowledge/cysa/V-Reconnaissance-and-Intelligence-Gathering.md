---
tags: [knowledge, cysa, security-analyst]
created: 2026-04-30
cert: CySA+
source: rewritten
---

# V. Reconnaissance and Intelligence Gathering
**The art of asking the right questions before the attack begins—and how defenders do it first.**

---

## Overview

Think of reconnaissance as the detective work that happens *before* anything gets broken. Both attackers and defenders systematically gather intel about networks, systems, and organizations to understand what's actually out there. For a security analyst, this is your foundation—you can't protect what you don't know exists, and you can't detect intrusions if you don't know your baseline.

---

## Key Concepts

### Active vs. Passive Reconnaissance

**Analogy**: Active reconnaissance is like knocking on every door and asking "Who's home?" Passive reconnaissance is like watching who comes and goes without ever announcing yourself.

**Definition**: [[Active reconnaissance]] directly probes target systems (port scans, service enumeration, OS fingerprinting)—it's loud and leaves traces. [[Passive reconnaissance]] observes existing data streams (log analysis, packet capture review, DNS lookups)—it's silent and invisible to the targets.

| Approach | Detection Risk | Examples | SOC Use Case |
|----------|---|---|---|
| **Active** | High—triggers alerts | Port scans, banner grabbing, version probes | Post-breach validation, authorized network assessments |
| **Passive** | None—no direct interaction | Netflow review, syslog analysis, WHOIS queries | Daily threat hunting, baseline establishment, incident response |

---

### Network Mapping and Discovery

**Analogy**: If your network were a city, mapping is like creating a street directory—knowing where every building is, what's inside, and how to get there.

**Definition**: [[Network mapping]] is the process of identifying hosts, open ports, running services, and device relationships to create an asset inventory and understand your attack surface. Tools like [[Nmap]] are the industry standard for this work.

**Key capabilities**:
- Port state identification (open, closed, filtered)
- [[Service version detection]] to spot vulnerable software
- [[OS fingerprinting]] to infer device type and configuration
- [[Firewall inference]] to understand network segmentation

---

### Passive Intelligence Collection Tools

**Analogy**: These tools are like reading public records—newspapers, property registries, business filings—to understand an organization without ever contacting them.

#### [[theHarvester]]
**Definition**: A command-line tool that scrapes public search engines and data sources to harvest email addresses, subdomains, hostnames, employee names, and IP ranges. It's your first swing for quick OSINT.

#### [[Shodan]]
**Definition**: A search engine specifically for internet-connected devices. It indexes banners, services, and known vulnerabilities on exposed systems. Unlike Google, Shodan finds the stuff that's accidentally facing the internet.

#### [[Maltego]]
**Definition**: A graphical tool that maps relationships between people, domains, IP addresses, and organizations. It visualizes the invisible connections—who works where, what domains they own, what infrastructure supports them.

---

### Active Scanning Tools

#### [[Nmap]] (Network Mapper)

**Analogy**: If reconnaissance were an investigation, Nmap is your primary detective. It methodically checks every door, peers through windows, and catalogs what's inside each room.

**Definition**: The industry-standard host discovery and port scanning tool. Nmap reveals what systems exist, which ports are listening, what services run them, which OS they're running, and how network firewalls are configured.

**Critical scan types for the exam**:
- **TCP SYN scan** (`-sS`): Stealthy, half-open connections—preferred for most situations
- **TCP Connect scan** (`-sT`): Full three-way handshake—generates more logs
- **UDP scan** (`-sU`): Finds services like DNS, SNMP, DHCP
- **ACK scan** (`-sA`): Maps firewall rules, not host discovery

**Common flags you'll see**:
- `-sV`: Service version detection (critical for vulnerability correlation)
- `-O`: OS fingerprinting (identify device type)
- `-p-`: Scan all 65,535 ports (slow but thorough)

#### [[Angry IP Scanner]]

**Definition**: A lightweight, GUI-based scanner for quick network sweeps. It identifies active hosts and open ports fast, but lacks the depth of service enumeration and OS detection that [[Nmap]] provides. Think of it as the "quick check" tool.

---

### Reconnaissance Frameworks

#### [[Metasploit]] Framework

**Analogy**: Metasploit is like a reconnaissance toolkit in a utility belt—scanners, probes, and discovery modules all pre-built and integrated.

**Definition**: A penetration testing platform with built-in auxiliary modules for network discovery, service enumeration, and vulnerability scanning. For the [[CySA+]], focus on its *discovery capabilities*, not exploitation.

**Common modules**:
- Port scanners and service probers
- SMB and SNMP enumeration
- SSL certificate discovery

#### [[Recon-ng]]

**Definition**: A modular, command-line OSINT framework for structured reconnaissance. It integrates multiple data sources (DNS, IP lookups, web searches) and produces repeatable, documented results—ideal for formal threat intelligence gathering.

---

### Packet Capture for Intelligence

**Analogy**: Packet capture is like recording all conversations happening on a street corner—you can hear who's talking, what they're saying, and infer a lot about the people and their habits.

**Definition**: [[Packet sniffing]] (using tools like tcpdump or Wireshark) passively captures network traffic to reveal active hosts, protocols in use, OS clues (TTL values, TCP window sizes), and communication patterns. It requires network access but leaves no footprint on target systems.

**Strategic placement**:
- SPAN ports (port mirroring) on switches capture broad network activity
- Endpoint capture shows what *that specific host* is doing
- During scanning, capture validates whether [[Nmap]] traffic received responses

---

### Domain and Host Intelligence

**Analogy**: Domain history is like checking the title history on a house—prior owners, liens, and renovations tell you a lot about what's really going on.

**Definition**: Historical WHOIS records and domain registration data reveal prior registrants, old contact info, and legacy infrastructure. This matters because forgotten domains often mean forgotten security controls.

**Key sources**:
- Current WHOIS (shows present registrant)
- DomainTools WHOIS History (reveals all prior owners and contact changes)
- MX record enumeration (identifies email infrastructure and redundancy)
- DNS zone transfer attempts (if misconfigured, exposes entire subdomain structure)

---

### Log Analysis for Reconnaissance

**Analogy**: Logs are the diary of your network—who showed up, what they did, when they left, and what they looked at.

**Definition**: [[Log analysis]] uses firewall, network device, server, and endpoint logs to understand baseline behavior, identify active systems, detect intrusion attempts, and map communication patterns. Logs are your best friend for *passive* discovery.

**Key log sources**:
- [[Syslog]] aggregation (standard for network devices)
- Firewall deny/allow logs (shows what traffic is blocked vs. permitted)
- DNS logs (reveals which hosts are actively resolving domains)
- NetFlow data (summarizes traffic flows without capturing payloads)

---

## Analyst Relevance

**Real scenario**: It's Monday morning in your SOC. You've just received a phishing alert for a user, and you need to determine what systems they may have accessed or installed malware on. You start with:

1. **Passive recon first**: Pull their NetFlow logs, DNS queries, and firewall connections from the past 48 hours to see what systems they contacted.
2. **Active validation (if authorized)**: Run [[Nmap]] scans on the subnets they connect to, identifying any new hosts or unexpected services that appeared.
3. **Historical context**: Check domain registration changes and old WHOIS records to see if any old infrastructure was suddenly reactivated.
4. **Visualization**: Load findings into [[Maltego]] to see relationships—which other users share the same systems, which domains are involved, what external IPs appeared.

This reconnaissance *directly enables* your incident response, containment, and threat hunting.

---

## Exam Tips

### Question Type 1: Tool Selection
- *"A security analyst needs to quickly identify all open ports on a range of 50 hosts and determine what services are running. Which tool is most appropriate?"* → **[[Nmap]] with `-sV` flag**
- **Trick**: Don't confuse [[Angry IP Scanner]] (just finds active hosts) with [[Nmap]] (finds services and versions). The exam tests whether you know the *depth* each tool provides.

### Question Type 2: Active vs. Passive Distinction
- *"Which reconnaissance method would generate the LEAST suspicious network traffic?"* → **Passive (log analysis, packet review, WHOIS lookups)**
- **Trick**: Candidates often think "passive" means "less useful"—it's actually *more* useful for defenders because it's stealthy AND you own the logs.

### Question Type 3: Scan Type Interpretation
- *"A port scan shows port 443 as 'filtered' instead of 'closed'. What does this indicate?"* → **A firewall is dropping packets; the port may or may not be open behind it.**
- **Trick**: Students confuse "filtered" (firewall blocking) with "closed" (host actively rejecting). Filtered = firewall, not the host.

### Question Type 4: Log-Based Discovery
- *"Which log type would BEST show you all DNS names resolved by a compromised host?"* → **DNS server logs or endpoint DNS query logs**
- **Trick**: Some students think firewall logs show DNS—they don't (firewall doesn't resolve). You need DNS logs or endpoint visibility.

---

## Common Mistakes

### Mistake 1: Assuming Active = Always Better
**Wrong**: "I'll just run aggressive [[Nmap]] scans on everything—more data is always better."
**Right**: Use passive first (logs, NetFlow, WHOIS) to establish baselines without noise, then active scans *only* when authorized and necessary.
**Impact on Exam**: You'll get questions asking when to use passive vs. active—the "correct" answer depends on *context* (authorized? detecting or discovering? stealth required?).

### Mistake 2: Confusing Tool Capabilities
**Wrong**: "I used [[Angry IP Scanner]] and it gave me the OS version of every host."
**Right**: [[Angry IP Scanner]] finds hosts and ports; [[Nmap]] with `-O` does OS fingerprinting. Different tools, different depth.
**Impact on Exam**: Scenario questions test whether you know what each tool actually does. Using the wrong tool = wrong answer.

### Mistake 3: Forgetting About Historical Data
**Wrong**: "The WHOIS lookup shows the current registrant; that's all we need to know."
**Right**: Historical WHOIS often reveals *prior* infrastructure or dormant domains still under the organization's old contact info—those are security blind spots.
**Impact on Exam**: Watch for questions about "legacy infrastructure" or "forgotten domains"—the answer involves historical WHOIS.

### Mistake 4: Misinterpreting Nmap Output States
**Wrong**: "Port 53 is 'filtered', so DNS isn't running."
**Right**: Filtered means a firewall is blocking visibility—DNS could absolutely be running behind it.
**Impact on Exam**: Nmap interpretation questions hinge on understanding the difference between "open," "closed," and "filtered." Study this hard.

### Mistake 5: Treating All Logs Equally
**Wrong**: "Just enable maximum logging everywhere and analyze everything."
**Right**: Different logs answer different questions—firewall logs show *allowed/denied*, DNS logs show *what names were queried*, syslog shows *device behavior*. Choose your source based on your question.
**Impact on Exam**: Questions asking "what log would you check?" test whether you know which source answers which question.

---

## Related Topics

- [[Asset Discovery]]
- [[Network Segmentation]]
- [[Vulnerability Assessment]]
- [[Threat Intelligence]]
- [[Incident Response (Containment Phase)]]
- [[Intrusion Detection Concepts]]
- [[Firewall Rules and Policies]]
- [[DNS and WHOIS]]
- [[Nmap Advanced Scanning]]
- [[Log Aggregation and Correlation]]

---

*Source: CySA+ CS0-003 Study Notes | [[CySA+]] | [[Reconnaissance]] | [[OSINT]]*