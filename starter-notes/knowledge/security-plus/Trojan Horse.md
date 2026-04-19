---
domain: "cybersecurity/attack-techniques"
tags: [malware, trojan, social-engineering, attack, persistence, threat]
---
# Trojan Horse

A **Trojan horse** (commonly shortened to **Trojan**) is a category of [[Malware]] that disguises itself as legitimate or benign software to trick users into executing it, after which it performs malicious actions without the user's knowledge or consent. Unlike [[Virus|viruses]] or [[Worm|worms]], Trojans do not self-replicate; they rely entirely on [[Social Engineering]] and user deception to propagate. The name derives from the classical myth in which Greek soldiers concealed themselves inside a hollow wooden horse gifted to the city of Troy, a perfect metaphor for software that hides hostile intent inside an apparently useful package.

---

## Overview

Trojans represent one of the oldest and most persistent categories of malicious software, first documented in the early 1970s in academic discussions about computer security and later seen in the wild throughout the 1980s and 1990s with infamous examples like the AIDS Trojan (PC Cyborg, 1989), which is also considered the first known [[Ransomware]]. Their longevity as an attack technique stems from a fundamental truth of security: the human element is often the weakest link. No matter how hardened a system's technical defenses may be, a user who is convinced to willingly run a malicious executable can bypass nearly all of them.

The defining characteristic of a Trojan is the deception — the malicious payload is wrapped inside something that appears valuable or necessary. Common delivery vehicles include cracked or pirated software, fake system utilities, browser extensions, email attachments disguised as invoices or resumes, game cheats, and codec packs. Modern Trojans are often polymorphic or packed with commercial-grade obfuscators (such as Themida or VMProtect) to evade [[Antivirus]] signature detection, making them far harder to detect than their early counterparts.

Trojans serve as an extraordinarily flexible foundation for cybercriminal and nation-state operations alike. Once a Trojan gains execution on a target system, it can deploy virtually any secondary capability: establishing a [[Remote Access Trojan (RAT)|remote access backdoor]], downloading and running additional malware (a **dropper** or **downloader** Trojan), exfiltrating credentials (a **banker Trojan** or **infostealer**), encrypting files for ransom, or conscripting the machine into a [[Botnet]]. The separation of the delivery mechanism (the Trojan itself) from the ultimate payload gives threat actors significant operational flexibility.

High-profile real-world examples illustrate their impact at scale. **Zeus** (Zbot), first observed in 2007, was a banking Trojan that stole banking credentials via form-grabbing and keylogging, ultimately infecting millions of machines and causing hundreds of millions of dollars in losses. **Emotet**, initially a banking Trojan in 2014, evolved into a sophisticated dropper and botnet infrastructure that distributed [[Ransomware]] like Ryuk and Conti before being disrupted by a multinational law-enforcement operation in 2021. **SUNBURST**, the backdoor embedded in SolarWinds Orion software updates in 2020, is a sophisticated supply-chain variant of a Trojan concept — legitimate software turned into a delivery mechanism for a nation-state implant.

---

## How It Works

The lifecycle of a Trojan infection can be broken down into distinct phases: **delivery**, **execution**, **installation**, **persistence**, and **command-and-control (C2) communication**.

### Phase 1: Delivery

The threat actor must get the Trojan binary onto the victim's system and convince the user to run it. Common delivery vectors include:

- **Phishing email** with a malicious attachment (`.exe` disguised as `.pdf`, `.docx` with macro dropper)
- **Drive-by download** via a compromised or malicious website exploiting a browser vulnerability
- **Trojanized software** distributed through unofficial download sites, torrent trackers, or supply-chain compromise
- **Removable media** (USB drops)
- **Social media / messaging apps** (malicious links disguised as memes, videos, or game hacks)

### Phase 2: Execution

The user runs the apparent legitimate application. The Trojan's outer shell may genuinely install or display the advertised software to reduce suspicion, while simultaneously dropping its malicious component into a writable directory such as:

```
C:\Users\<username>\AppData\Roaming\
C:\ProgramData\
C:\Windows\Temp\
```

On Linux/macOS targets, common staging areas include:
```bash
~/.config/
~/.local/share/
/tmp/
```

### Phase 3: Installation and Payload Drop

The Trojan writes its malicious payload to disk and may inject code into a legitimate running process using techniques like **DLL injection**, **process hollowing**, or **reflective loading** to evade detection. A simple example of process hollowing concept:

```
1. Spawn legitimate process (e.g., svchost.exe) in SUSPENDED state
2. Unmap the process's memory sections (ZwUnmapViewOfSection)
3. Allocate new memory in the process space
4. Write malicious shellcode/PE image into the allocated memory
5. Adjust the process context (EIP/RIP) to point to malicious entry point
6. Resume the thread
```

The injected code now runs under a trusted process name, bypassing naive process-name-based detection.

### Phase 4: Persistence

The Trojan ensures it survives reboots by writing to one or more persistence mechanisms:

**Windows Registry Run Keys:**
```registry
HKCU\Software\Microsoft\Windows\CurrentVersion\Run
HKLM\Software\Microsoft\Windows\CurrentVersion\Run
```

**Scheduled Tasks (cmd):**
```cmd
schtasks /create /tn "WindowsUpdate" /tr "C:\Users\user\AppData\Roaming\payload.exe" /sc onlogon /ru SYSTEM
```

**Linux Cron or Systemd unit:**
```bash
(crontab -l ; echo "@reboot /home/user/.config/.svc/payload") | crontab -
```

### Phase 5: Command-and-Control (C2) Communication

Most modern Trojans establish an outbound connection to a C2 server controlled by the attacker. Outbound connections are preferred because firewalls typically allow outbound traffic. Common C2 channels include:

| Protocol | Port | Notes |
|---|---|---|
| HTTPS | 443 | Blends with normal web traffic; TLS encrypts C2 |
| HTTP | 80 | Legacy; detectable by proxy/content inspection |
| DNS | 53 | **DNS tunneling** encodes data in DNS queries |
| ICMP | N/A | Covert; data embedded in ping packets |
| IRC | 6667 | Classic botnet C2; largely obsolete |

A RAT Trojan operating over HTTPS will typically beacon home at a configurable interval:

```
Victim → HTTPS POST → attacker-controlled domain (often DGA-generated)
C2 Server → HTTPS Response → encoded command (shell cmd, file download, screenshot)
Victim → Executes command, returns output via next beacon
```

**Domain Generation Algorithms (DGAs)** are used by sophisticated Trojans (e.g., Zeus, Conficker) to generate hundreds of potential C2 domain names daily, making blocklisting impractical without knowing the DGA seed.

---

## Key Concepts

- **Dropper**: A Trojan variant whose sole purpose is to deliver and execute a secondary payload (additional malware) onto the target system without itself persisting long-term. Emotet functioned as a dropper delivering Ryuk ransomware.
- **Remote Access Trojan (RAT)**: A Trojan that provides the attacker with full remote control over the victim's system, including file access, webcam/microphone access, keylogging, and shell command execution. Examples include **njRAT**, **DarkComet**, and **QuasarRAT**.
- **Banker Trojan**: A specialized Trojan designed to steal financial credentials, often via **form-grabbing** (intercepting browser form submissions before encryption) or **web injection** (modifying banking websites in the browser to harvest credentials). Zeus and Dridex are canonical examples.
- **Backdoor**: A persistent, hidden communication channel installed by a Trojan that allows the attacker to re-enter the system at will, even after the original Trojan binary may have been removed. The backdoor is often the primary objective.
- **Payload Obfuscation / Packing**: Techniques used to disguise a Trojan's binary from signature-based detection. Commercial packers (UPX, Themida) or custom crypters encrypt or compress the executable, and the Trojan decrypts itself in memory at runtime — a technique called **runtime unpacking**.
- **Living-off-the-Land (LotL)**: A modern Trojan technique that avoids dropping new binaries on disk by leveraging legitimate system tools (PowerShell, WMI, certutil, mshta) to execute malicious actions, evading traditional file-based detection.
- **Infostealer**: A Trojan category focused on harvesting sensitive data — passwords, cookies, browser credentials, cryptocurrency wallets, and clipboard contents — and exfiltrating them to the attacker. **Redline Stealer** and **Raccoon Stealer** are prominent modern examples.

---

## Exam Relevance

**SY0-701 Exam Tips:**

The Security+ exam tests Trojans primarily within the **Threats, Attacks, and Vulnerabilities** domain (Domain 2). Key points to internalize:

- **Trojans ≠ Viruses ≠ Worms**: The exam will test your ability to differentiate. Trojans require user execution and do not self-replicate. Viruses attach to host files and replicate. Worms self-replicate across networks without user action.
- **Trojans are delivered via social engineering**: Questions may describe a scenario where a user downloads a "free game" or "cracked software" — recognize this as the classic Trojan delivery mechanism.
- **RAT is a type of Trojan**: Remote Access Trojans are a subset, not a separate malware family. If a question describes an attacker having persistent remote control after a user clicked an attachment, think RAT/Trojan.
- **Backdoor relationship**: Trojans often *install* backdoors, but a backdoor itself is a separate concept. Trojans are the *delivery mechanism*; the backdoor is the *persistent access mechanism* they leave behind.
- **Know the subtypes**: Droppers, downloaders, banker Trojans, and RATs are all likely to appear in scenario-based questions.
- **Common gotcha**: Students confuse Trojans with rootkits. A rootkit *hides* malware at the OS or firmware level; a Trojan *disguises* itself as legitimate software. They can be used together (a Trojan that installs a rootkit) but are conceptually distinct.
- **Indicators of Compromise (IoCs)**: The exam may ask what artifact indicates Trojan infection — unexpected outbound connections, unknown processes, new registry run keys, and unfamiliar scheduled tasks are all valid IoCs.

---

## Security Implications

### Attack Surface and Vectors

Trojans exploit the fundamental trust users place in software they install. The attack surface is essentially the entire software supply chain and every human who interacts with a computer. Notable real-world incidents demonstrate the breadth of impact:

- **Zeus/Zbot (2007–present)**: Estimated to have infected over 3.6 million machines in the US alone. Source code leak in 2011 spawned dozens of variants (GameOver Zeus, Citadel). FBI Operation Tovar disrupted the GameOver Zeus botnet in 2014.
- **Emotet (2014–2021)**: Evolved from banking Trojan to MaaS (Malware-as-a-Service) dropper. Operated via malicious Word document macros sent in phishing campaigns. Europol/Eurojust coordinated takedown in January 2021.
- **SolarWinds SUNBURST (2020)**: Nation-state supply-chain attack (attributed to Russian SVR/Cozy Bear). Malicious code injected into SolarWinds Orion software build pipeline, distributed via legitimate software update to ~18,000 organizations including US federal agencies. CVE-2020-10148 (SolarWinds Orion API authentication bypass) was related to the incident scope.
- **XcodeGhost (2015)**: Trojanized version of Apple's Xcode IDE distributed in China; apps compiled with it embedded malicious code, affecting hundreds of App Store apps including WeChat.

### Relevant CVEs

| CVE | Description |
|---|---|
| CVE-2017-0199 | Microsoft Office OLE2Link — used to deliver Trojans via crafted `.doc` files |
| CVE-2012-0158 | MSCOMCTL.OCX RCE in Office — widely used by banker Trojans in spear-phishing |
| CVE-2021-40444 | MSHTML remote code execution — used for Trojan dropper delivery via Office docs |

### Detection Indicators

- Unexpected outbound connections to unusual IPs or DGA-generated domains
- New, unknown processes spawned by `explorer.exe`, `winword.exe`, or `outlook.exe`
- Registry run keys or scheduled tasks not matching installed software inventory
- Anomalous data exfiltration (large DNS query volumes suggesting DNS tunneling)
- Endpoint EDR alerts on process injection, reflective DLL loading, or hollowing

---

## Defensive Measures

### Technical Controls

1. **Endpoint Detection and Response (EDR)**: Deploy EDR solutions (CrowdStrike Falcon, Microsoft Defender for Endpoint, SentinelOne) that use behavioral analysis to detect process injection, reflective loading, and anomalous outbound connections — techniques that evade signature-based AV.

2. **Application Allowlisting**: Use Windows Defender Application Control (WDAC) or AppLocker to permit only signed, approved executables to run. This directly breaks the Trojan execution phase.
   ```powershell
   # Example: Enable AppLocker Audit Mode via PowerShell
   Set-AppLockerPolicy -XMLPolicy .\policy.xml -Merge
   ```

3. **Email Gateway Filtering**: Configure email security (Proofpoint, Microsoft Defender for Office 365) to strip executable attachments, scan macros, and sandbox unknown documents before delivery.

4. **DNS Filtering / Sinkholing**: Use DNS security services (Cisco Umbrella, Cloudflare Gateway, Pi-hole with threat feeds) to block known malicious domains and detect DGA-based C2 traffic by flagging anomalous query patterns.

5. **Network Egress Filtering**: Implement strict outbound firewall rules. Workstations should not be able to initiate arbitrary outbound connections; restrict to required ports/protocols and proxy all HTTP/HTTPS through an inspecting proxy (Squid, Zscaler).

6. **Disable Office Macros**: Via Group Policy, disable VBA macros in Office documents received from the internet:
   ```
   GPO: User Configuration → Administrative Templates → Microsoft Office → 
   Security Settings → Disable all macros without notification
   ```

7. **Privilege Separation**: Run users as standard (non-admin) accounts. Trojans executing in a standard user context cannot install services, modify HKLM registry keys, or write to system directories, severely limiting persistence options.

### Procedural Controls

- **User Security Awareness Training**: Regular phishing simulation and training (KnowBe4, Proofpoint Security Awareness) is the single most effective control against socially-engineered Trojan delivery.
- **Software Procurement Policy**: Only install software from official, verified sources. Enforce package manager usage (winget, apt, Homebrew) over manual downloads.
- **Patch Management**: Many Trojan delivery exploits target unpatched applications (browsers, Office, PDF readers). Maintain a rigorous patching cadence.
- **Integrity Verification**: Verify SHA-256 checksums and GPG signatures of all downloaded software before execution.

---

## Lab / Hands-On

> ⚠️ **Warning**: All malware analysis and simulation must be performed in an isolated, air-gapped or properly NAT-isolated lab environment. Never execute malware on production systems or networks.

### Exercise 1: Observe Trojan Behavior in a Sandbox

Use **[[Any.run]]** (interactive sandbox) or a local **[[Cuckoo Sandbox]]** deployment to analyze a known-benign Trojan simulator like the EICAR test file variants, or submit samples from **M