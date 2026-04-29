---
domain: "offensive-security"
tags: [zero-day, vulnerability, exploit, attack, threat-intelligence, patch-management]
---
# Zero Day

A **zero-day** (written as **0-day**) refers to a [[vulnerability]] in software, hardware, or firmware that is unknown to the vendor or developer and therefore has no available patch or mitigation at the time of discovery. The term originates from the idea that defenders have had "zero days" to prepare a fix once the flaw becomes actively exploited. Zero days are among the most dangerous threats in cybersecurity because they render traditional signature-based [[Intrusion Detection System|IDS]] and patch-management defenses ineffective by definition.

---

## Overview

Zero-day vulnerabilities exist because software development is inherently imperfect. Modern applications contain millions of lines of code, and even rigorous [[Secure Development Lifecycle|SDL]] practices cannot guarantee the absence of flaws. Memory mismanagement, logic errors, improper input validation, race conditions, and insecure default configurations all create attack surfaces that may go unnoticed for months or years. The moment a researcher, criminal group, or nation-state discovers such a flaw before the vendor does, it becomes a zero-day.

The lifecycle of a zero-day has several distinct phases. First is **discovery**, where the flaw is identified by a researcher, attacker, or automated fuzzing tool. Second is **weaponization**, where a reliable exploit is developed to leverage the flaw. Third is **deployment**, where the exploit is used in attacks, sold on underground markets, or disclosed responsibly to the vendor. Finally, once the vendor learns of the flaw (through disclosure, incident response, or independent discovery), the clock starts on patch development and the vulnerability transitions from "zero-day" to a **known vulnerability** with a [[CVE]] identifier.

The market for zero-day exploits is enormous and stratified. Legitimate bug bounty programs operated by vendors like Microsoft, Google, and Apple pay researchers tens of thousands to hundreds of thousands of dollars for high-severity discoveries. Simultaneously, gray-market brokers like Zerodium publicly advertise prices exceeding $2.5 million USD for a full iOS chain exploit. Nation-state intelligence agencies (NSA, FSB, Unit 8200) maintain stockpiles of zero-days for offensive cyber operations, as revealed in the [[Shadow Brokers]] leak of 2017, which exposed NSA exploits including [[EternalBlue]].

Zero-days are not solely the domain of sophisticated actors. Underground forums on the dark web regularly list exploit kits and previously-undisclosed vulnerabilities for sale. **Exploit kits** such as the retired Angler and Neutrino frameworks packaged zero-day browser exploits for mass deployment against unsuspecting users visiting compromised websites, a technique called a [[drive-by download]]. This democratization of zero-day exploitation means that even moderately-funded criminal organizations can leverage previously-elite capabilities.

From a regulatory and ethical standpoint, zero-day research sits in a complex legal gray area. The [[Computer Fraud and Abuse Act (CFAA)]] in the United States and the Computer Misuse Act in the UK can technically criminalize zero-day research even when conducted responsibly. **Coordinated vulnerability disclosure (CVD)**, formerly called responsible disclosure, has emerged as the industry norm: researchers notify vendors privately, allow a reasonable remediation window (typically 90 days per Google Project Zero's policy), and then publish findings publicly to drive patching urgency.

---

## How It Works

Understanding zero-day exploitation requires examining the full technical attack chain from vulnerability discovery through successful code execution.

### 1. Vulnerability Discovery

Attackers and researchers use several methods to find flaws:

- **Manual Code Auditing**: Reverse engineering compiled binaries with tools like [[Ghidra]] or IDA Pro to identify dangerous function calls, unvalidated inputs, or logic flaws.
- **Fuzzing**: Automated feeding of malformed, random, or boundary-violating input to a target application to trigger crashes. Tools include AFL (American Fuzzy Lop), libFuzzer, and Boofuzz.
- **Symbolic Execution**: Tools like angr or KLEE exhaustively explore program execution paths to identify reachable vulnerable states.

```bash
# Example: Basic AFL fuzzing against a target binary
afl-fuzz -i input_corpus/ -o findings/ -- ./target_binary @@

# Example: Boofuzz network protocol fuzzer skeleton
from boofuzz import Session, Target, SocketConnection
session = Session(target=Target(connection=SocketConnection("192.168.1.100", 80)))
```

### 2. Vulnerability Classification

Common zero-day vulnerability classes include:

| Class | Description | Common Impact |
|---|---|---|
| Buffer Overflow | Write beyond allocated memory bounds | RCE, privilege escalation |
| Use-After-Free (UAF) | Access memory after it has been freed | RCE, info disclosure |
| Type Confusion | Object treated as wrong type | RCE |
| Integer Overflow | Arithmetic wraps produce unexpected values | Heap corruption |
| SQL Injection | Unsanitized database queries | Data exfiltration |
| Race Condition | TOCTOU flaws in concurrent code | Privilege escalation |

### 3. Exploit Development

Once a crash-producing input is found, exploit developers work to achieve reliable code execution:

```python
# Conceptual stack buffer overflow exploit structure (educational)
import struct

# Target: vulnerable service on port 9999
# Offset to EIP determined via pattern_create/pattern_offset (Metasploit)

offset = 524  # bytes to reach return address
eip = struct.pack("<I", 0x625011AF)  # JMP ESP gadget from a loaded DLL

# NOP sled + shellcode (e.g., msfvenom reverse shell payload)
nop_sled = b"\x90" * 16
shellcode = b"\xdb\xc0..."  # msfvenom generated payload

payload = b"A" * offset + eip + nop_sled + shellcode

import socket
s = socket.socket()
s.connect(("192.168.1.100", 9999))
s.send(payload)
s.close()
```

Modern exploits must bypass memory protections:
- **[[ASLR]] (Address Space Layout Randomization)**: Randomizes memory addresses; bypassed via information disclosure leaks.
- **[[DEP]]/NX (Data Execution Prevention)**: Marks memory non-executable; bypassed via Return-Oriented Programming ([[ROP]]).
- **Stack Canaries**: Sentinel values that detect overwrites; bypassed via overwrite of specific targets or info leaks.

### 4. Weaponization and Delivery

The polished exploit is wrapped in a delivery mechanism:

- **Spear-phishing** with a malicious document exploiting a zero-day in Microsoft Office or Adobe Reader (e.g., CVE-2021-40444 MSHTML)
- **Watering hole attacks** injecting exploit code into websites frequented by targets
- **Malicious browser extensions** or drive-by downloads via JavaScript engine zero-days
- **Supply chain compromise** inserting backdoors during software build processes

### 5. Post-Exploitation

After gaining initial access, attackers typically:

```bash
# Privilege escalation using local zero-day kernel exploit
./cve-2021-4034  # PwnKit - Polkit pkexec vulnerability

# Establish persistence
schtasks /create /tn "SystemUpdate" /tr "C:\backdoor.exe" /sc onlogon /ru SYSTEM

# Lateral movement using EternalBlue (MS17-010) against unpatched SMB
use exploit/windows/smb/ms17_010_eternalblue
set RHOSTS 10.10.10.0/24
run
```

---

## Key Concepts

- **Zero-Day Vulnerability**: A **previously unknown software flaw** for which no vendor patch exists; attackers exploiting it have a built-in advantage over defenders who cannot patch what they don't know is broken.
- **Zero-Day Exploit**: The **actual weaponized code or technique** that leverages a zero-day vulnerability to achieve a malicious objective such as remote code execution, privilege escalation, or data exfiltration.
- **Exploit Kit**: A **pre-packaged commercial exploit framework** sold or rented on underground markets that bundles multiple exploits (sometimes zero-days) for automated deployment against web visitors; examples include Angler, Neutrino, and RIG.
- **CVD (Coordinated Vulnerability Disclosure)**: The **responsible disclosure process** where a researcher privately notifies a vendor of a flaw, grants a remediation window (typically 90 days), and then publishes details publicly — balancing researcher recognition with user protection.
- **N-Day Vulnerability**: A vulnerability that **already has a known CVE and available patch** but remains exploitable against unpatched systems; dangerous because exploit code is often publicly available within days of patch release.
- **Threat Intelligence Feed**: **Curated, real-time data streams** containing indicators of compromise (IoCs), TTPs, and vulnerability intelligence that help organizations detect zero-day exploitation campaigns in progress.
- **Patch Window**: The **critical time between vulnerability disclosure and patch deployment** across an organization's systems; during this window, an organization is effectively facing an n-day attack even if detection is possible.
- **Bug Bounty Program**: A **formal vendor-sponsored reward program** that incentivizes responsible disclosure by paying researchers for valid vulnerability reports, reducing the financial motivation to sell to malicious brokers.

---

## Exam Relevance

The Security+ SY0-701 exam tests zero-day concepts in the context of threat actors, vulnerability management, and attack classification. Key exam-focused points:

**Likely question patterns:**
- "Which type of vulnerability has no available patch?" → **Zero-day**
- "A threat actor exploits a flaw before the vendor is aware. What type of attack is this?" → **Zero-day exploit**
- "What is the BEST defense against zero-day attacks when patching is impossible?" → **Defense in depth / network segmentation / behavioral detection / application whitelisting**
- Questions distinguishing zero-day from **known unpatched vulnerabilities** (n-days) — know the difference

**Domain mapping (SY0-701):**
- Domain 1.0 (General Security Concepts): Vulnerability types
- Domain 2.0 (Threats, Vulnerabilities, Mitigations): Threat actor types and capabilities, attack surface
- Domain 4.0 (Security Operations): Patch management, threat intelligence

**Common gotchas:**
- A zero-day does NOT mean there is no mitigation — compensating controls (WAF rules, EDR behavioral rules, network segmentation) may exist even without a patch.
- The exam may conflate zero-day with "unpatched vulnerability." Be precise: zero-day = **vendor unaware or no patch available yet**; an unpatched known vulnerability is an **n-day**.
- [[Intrusion Prevention System|IPS]] signatures **cannot** detect truly novel zero-day exploits — this is a classic distractor. Behavioral analytics and anomaly detection are the correct answers for zero-day detection.
- Nation-state actors (APTs) are most commonly associated with zero-day usage on the exam, classified as **advanced persistent threats** with **high capability and high sophistication**.

---

## Security Implications

### Real-World Zero-Day Incidents

**Stuxnet (2010)** — Perhaps the most sophisticated zero-day attack ever documented, Stuxnet exploited **four simultaneous Windows zero-days** (CVE-2010-2568, CVE-2010-2772, CVE-2010-2729, CVE-2010-2568) alongside two stolen digital certificates to sabotage Iranian nuclear centrifuges. It demonstrated that zero-days could be weaponized for physical infrastructure destruction.

**EternalBlue (MS17-010)** — Developed by the NSA and leaked by the [[Shadow Brokers]] in April 2017. This SMBv1 vulnerability in Windows allowed unauthenticated remote code execution over port 445. It was used in both [[WannaCry]] and [[NotPetya]] ransomware attacks in May–June 2017, causing an estimated $10 billion in damages globally.

**Log4Shell (CVE-2021-44228)** — While technically disclosed before widespread exploitation began, the attack window created a de-facto zero-day scenario for many organizations. The [[Log4j]] JNDI injection vulnerability affected millions of Java applications worldwide and required immediate emergency patching.

**CVE-2021-40444 (MSHTML)** — A zero-day in the Internet Explorer MSHTML rendering engine allowed remote code execution through malicious Office documents without macros. Exploited in the wild by multiple APT groups before patch availability.

**CVE-2023-4966 (Citrix Bleed)** — A session token disclosure zero-day in Citrix NetScaler appliances was exploited by ransomware groups including LockBit months before public disclosure, enabling authentication bypass at scale.

### Attack Vectors

- **Client-side attacks**: Browser, PDF reader, Office suite zero-days delivered via phishing
- **Server-side attacks**: Web application, VPN appliance, and network device zero-days exploited remotely
- **Supply chain**: Compromising trusted software update mechanisms (SolarWinds, 3CX)
- **Privilege escalation**: Local kernel or OS component zero-days used post-initial-access

### Detection Challenges

Because zero-days have no known signatures, detection relies on behavioral anomalies:
- Unexpected child process spawning (e.g., `winword.exe` spawning `cmd.exe`)
- Unusual network connections from non-browser processes
- Memory anomalies: shellcode in non-executable regions (detected by [[EDR]] tools)
- Lateral movement patterns inconsistent with normal user behavior

---

## Defensive Measures

Defending against zero-days requires a layered, defense-in-depth strategy since patching is, by definition, not immediately possible.

### 1. Attack Surface Reduction
```bash
# Disable legacy protocols that are common zero-day targets
# Disable SMBv1 on Windows
Set-SmbServerConfiguration -EnableSMB1Protocol $false

# Disable unnecessary services
systemctl disable --now telnet.socket rsh.socket rexec.socket

# Restrict PowerShell execution
Set-ExecutionPolicy -ExecutionPolicy Constrained -Scope LocalMachine
```

### 2. Application Whitelisting
Use [[AppLocker]] or Windows Defender Application Control (WDAC) to restrict execution to known-good binaries. Even if an exploit fires, it cannot launch arbitrary payloads.

```powershell
# Basic AppLocker rule via PowerShell
New-AppLockerPolicy -RuleType Publisher, Hash, Path `
  -User Everyone -Optimize | Set-AppLockerPolicy -Merge
```

### 3. Behavioral EDR Deployment
Deploy endpoint detection tools that detect exploit techniques rather than signatures:
- **CrowdStrike Falcon**, **SentinelOne**, **Microsoft Defender for Endpoint**
- These tools detect ROP chains, process injection, LSASS dumping, and shellcode execution patterns that are common across many exploits regardless of the underlying vulnerability.

### 4. Network Segmentation and Micro-Segmentation
Even if a host is exploited via a zero-day, limit blast radius:
```
# Firewall rule example: restrict lateral SMB movement
iptables -A FORWARD -p tcp --dport 445 -s 10.10.1.0/24 -d 10.10.2.0/24 -j DROP

# Zero-trust model: deny by default, allow by exception
```

### 5. Threat Intelligence Integration
Subscribe to threat intelligence feeds (MISP, VirusTotal Enterprise, Recorded Future) and configure SIEM rules to alert on IoCs associated with known zero-day exploitation campaigns even before patches exist.

### 6. Virtual Patching via WAF/IPS
Web Application Firewalls and Next-Gen IPS can apply **virtual patches** — rules that block specific malicious request patterns associated with a vulnerability — before the vendor releases an official patch.

```
# ModSecurity WAF rule example (virtual patch concept)
SecRule REQUEST_URI "@contains /vulnerable/endpoint" \
  "id:9001,phase:1,deny,status:403,msg:'Zero-Day Virtual Patch Active'"
```

### 7. Rapid Patch Deployment Capability
Reduce the window of exposure for n-days by building mature patch deployment infrastructure:
- Maintain a tested patch deployment pipeline using **WSUS**, **SCCM**, or **Ansible**
- Target **24-hour patching** for critical/actively exploited CVEs
- Maintain accurate asset inventory so no system is missed

### 8. Principle of Least Privilege
Limiting user and service account privileges ensures that even a successful exploit achieves limited initial