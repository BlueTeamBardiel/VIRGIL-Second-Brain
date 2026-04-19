---
domain: "malware"
tags: [malware, virus, attack, endpoint-security, threat-analysis, antivirus]
---
# Virus

A **computer virus** is a type of [[malware]] that **self-replicates by inserting copies of itself into other executable files, documents, or boot sectors**, requiring a host file and human interaction to propagate. Unlike [[worm|worms]], viruses cannot spread autonomously across networks without a carrier; they depend on actions such as opening an infected file, running a program, or booting from infected media. Viruses represent one of the oldest and most studied categories of malicious software, dating back to experimental self-replicating programs in the 1970s and weaponized examples such as the [[Elk Cloner]] virus of 1982.

---

## Overview

The defining characteristic of a virus is **self-replication through host infection**. A virus attaches its code to a legitimate host — an executable binary, a macro-enabled document, a script, or a boot record — and causes that host to carry and execute the viral payload whenever the host is used. This distinguishes viruses from [[Trojan horse|trojans]], which disguise themselves as legitimate software but do not self-replicate, and from [[worm|worms]], which replicate independently without needing a host file.

Viruses exist because they are an effective mechanism for **persistence, propagation, and payload delivery**. By piggybacking on legitimate, trusted files, they exploit user behavior and trust relationships rather than relying solely on software vulnerabilities. Early viruses like **Brain (1986)** targeted floppy disk boot sectors; later generations evolved to infect Windows PE executables (e.g., the **CIH/Chernobyl virus, 1998**), Office macros (the **Melissa virus, 1999**), and interpreted scripts. Modern viruses are often components of larger [[APT (Advanced Persistent Threat)|advanced persistent threats]] or ransomware delivery chains.

The virus lifecycle generally includes four phases: **dormancy**, during which the virus lies inactive inside the host; **propagation**, during which it spreads to additional files or systems; **triggering**, when a condition (date, event, user action) activates the payload; and **execution**, when the malicious payload runs. Not all viruses include a destructive payload — some exist solely to replicate — but even non-destructive viruses cause damage through corrupted files, resource consumption, and loss of system integrity.

Historically, virus propagation relied on **physical media exchange** — infected floppy disks, CD-ROMs, and USB drives. With the proliferation of networked systems, viruses evolved to spread via email attachments, downloaded files, and shared network drives. The **ILOVEYOU worm-virus hybrid (2000)** spread via email and caused an estimated $10 billion in damage by overwriting files and emailing copies of itself to every contact in the victim's address book. Modern antivirus engines now incorporate behavioral analysis, heuristics, and cloud-based reputation scoring to detect viruses that evade traditional signature matching.

---

## How It Works

### Infection Mechanism

A virus must accomplish three core tasks: **find a suitable host, inject its code, and ensure its code executes when the host is used**. The specific mechanism depends on the virus type.

#### 1. File Infector Viruses (PE Infectors)

The most common modern form targets **Windows Portable Executable (PE) files** (.exe, .dll, .sys). The virus modifies the PE header to redirect the entry point to its own code.

```
Original PE Entry Point: 0x00401000 → legitimate_main()
Infected PE Entry Point: 0x00401000 → virus_payload() → legitimate_main()
```

The virus appends, prepends, or inserts its code into the file. A **prepending virus** adds code before the original entry point. An **appending virus** adds code at the end and modifies the entry point to jump to the tail. A **cavity virus** (or spacefiller) inserts code into unused sections (cave regions) in the binary without increasing file size, making it harder to detect by size change.

Tools like **PEview**, **pestudio**, or **CFF Explorer** can reveal the modified entry point in a forensic analysis:

```bash
# Using rabin2 (radare2 suite) to inspect entry point
rabin2 -e suspect_binary.exe

# Using objdump on Linux ELF infectors
objdump -f infected_elf | grep "start address"
```

#### 2. Boot Sector Viruses

**Master Boot Record (MBR)** and **Volume Boot Record (VBR)** viruses overwrite the boot sector, executing before the OS loads. The BIOS/UEFI reads sector 0 of the storage device first; if infected, the viral code runs with no OS defenses active.

```
Disk Sector 0 (MBR):
[Bootstrap Code 446 bytes] ← virus overwrites this
[Partition Table 64 bytes]
[Boot Signature 0x55AA 2 bytes]
```

Modern equivalents are **bootkits** — rootkit-level MBR infectors such as **Mebroot/Sinowal** and **TDL4** that survive OS reinstallation because they persist below the OS layer.

#### 3. Macro Viruses

Macro viruses embed malicious code in **document macros** (VBA scripts in Microsoft Office files). When the document is opened and macros are enabled, the virus executes, typically copying itself to the default template (`Normal.dot` in Word) so it infects every subsequently opened document.

```vba
' Example structure of a macro virus infection vector (conceptual)
Sub AutoOpen()
    Dim oWord As Object
    Set oWord = Application.NormalTemplate.VBProject.VBComponents
    ' Copies itself to Normal template
    ' Executes payload (e.g., drops additional malware)
End Sub
```

The **Melissa (1999)** and **Concept (1995)** viruses used this mechanism. Modern variants use **maldocs** delivered via phishing emails, often combined with PowerShell dropper stages.

#### 4. Polymorphic and Metamorphic Viruses

- **Polymorphic viruses** encrypt their payload with a variable key and include a mutation engine that changes the decryptor routine with each infection, producing a different signature each time while preserving functionality.
- **Metamorphic viruses** rewrite their entire code on each propagation — substituting instructions, reordering code blocks, inserting junk instructions — without encryption, making static signature detection nearly impossible.

```
Polymorphic cycle:
  [Mutation Engine] → generates new decryptor
  [Encrypted Payload] → re-encrypted with new key
  Result: unique binary fingerprint each infection
```

Examples: **Storm Worm** (polymorphic), **Simile/MetaPHOR** (metamorphic).

#### 5. Propagation Trigger

The virus monitors for conditions to spread: file system access (infecting files when they are opened/executed), removable media insertion events, or network share enumeration. On Windows, this can be achieved by hooking file system APIs or monitoring the `%TEMP%` directory for new executables.

---

## Key Concepts

- **Self-replication**: The defining feature of a virus; it copies itself into other host files or storage locations, distinguishing it from non-replicating [[malware]] like trojans or spyware.
- **Host dependency**: Unlike [[worm|worms]], viruses require a carrier (executable, document, boot sector) and typically require human action (double-clicking a file, booting from media) to propagate — making user education a primary defensive layer.
- **Payload**: The malicious action the virus performs beyond replication; payloads range from benign (displaying a message) to destructive (overwriting files, corrupting the MBR, encrypting data) or covert (installing a [[backdoor]] or keylogger).
- **Polymorphism**: A technique in which a virus mutates its code signature on each infection cycle to evade signature-based [[antivirus]] detection while preserving its functional behavior; requires heuristic or behavioral detection to catch.
- **Trigger condition**: A logical condition or event that causes the virus to activate its payload; examples include a specific date (CIH activated on April 26, the Chernobyl disaster anniversary), a counter reaching a threshold, or detection of a specific file or registry key.
- **Stealth techniques**: Methods viruses use to hide their presence, including rootkit-level hooks that intercept OS calls to return clean file sizes and contents, timestamp manipulation, and process injection into legitimate system processes such as `svchost.exe` or `explorer.exe`.
- **Infection marker / immunization**: Many viruses mark already-infected files with a specific byte sequence or metadata to avoid reinfecting the same host (which would corrupt it and expose the infection); this marker can be used defensively to immunize files.

---

## Exam Relevance

**Security+ SY0-701 Objective mapping:** 2.4 — Analyze indicators of malicious activity; 2.5 — Explain the purpose of mitigation techniques used to secure the enterprise.

**Key distinctions tested:**

| Malware Type | Self-Replicates | Needs Host | User Action Required | Network Propagation |
|---|---|---|---|---|
| **Virus** | Yes | Yes | Typically yes | No (without help) |
| **Worm** | Yes | No | No | Yes (autonomous) |
| **Trojan** | No | No | Yes | No |
| **Ransomware** | Sometimes | No | Yes | Sometimes |

**Common question patterns:**
1. *"A user opens an email attachment and their system becomes infected; the virus spreads to every `.exe` on the machine but does NOT propagate across the network on its own. What type of malware is this?"* → **Virus** (needs user action, infects local files, not self-propagating across network = not a worm).
2. *"Which virus type changes its decryption routine with each infection cycle?"* → **Polymorphic virus**.
3. *"Which virus type completely rewrites its own code without encryption?"* → **Metamorphic virus**.
4. *"What is the primary difference between a virus and a worm?"* → Worms self-propagate across networks without a host file or user interaction.

**Gotchas:**
- The exam distinguishes between **viruses** and **worms** heavily. ILOVEYOU is technically a **worm-virus hybrid** — know how to categorize it by its primary behavior (network self-propagation = worm characteristics).
- **Macro viruses** are associated with **documents**, not executables — be ready to identify them from scenario descriptions involving Office files.
- **Boot sector viruses** survive OS reinstallation and require low-level tools (e.g., `bootrec /fixmbr`, UEFI Secure Boot) to remediate — this is a unique characteristic not shared by file infectors.
- Virus infection can be an indicator for **further compromise** — the virus may be a dropper for [[ransomware]], a [[RAT (Remote Access Trojan)|RAT]], or a [[keylogger]].

---

## Security Implications

### Attack Vectors

- **Email attachments**: Malicious `.doc`, `.xls`, `.pdf`, `.exe`, or `.zip` files delivered via [[phishing]] campaigns. Macro viruses exploit auto-execution features in Office documents.
- **Drive-by downloads**: Infected executables downloaded from compromised or malicious websites, often disguised as software installers, cracks, or media players.
- **Removable media**: USB drives remain a significant vector, especially in air-gapped environments. **Stuxnet (2010)** used a worm-virus hybrid that spread via USB, targeting Siemens industrial control systems; it exploited four separate zero-day vulnerabilities (CVE-2010-2568, CVE-2010-2772, CVE-2010-2729, CVE-2010-2772).
- **Network shares**: File infector viruses can spread to shared network drives if write permissions are improperly configured.
- **Supply chain**: Infected software distributed via legitimate channels (e.g., compromised build servers or update mechanisms).

### Real-World Incidents

- **CIH/Chernobyl (1998)**: Targeted Windows 9x; overwrote the first megabyte of the hard drive and, on some motherboards, overwrote the BIOS chip, rendering systems unable to boot. Caused an estimated $1 billion in damage.
- **Melissa (1999)**: A Word macro virus that also functioned as a mass-mailer worm; overwhelmed mail servers at hundreds of corporations and caused ~$80 million in damage. CVE is not formally assigned but it drove development of modern email gateway filtering.
- **Virut (2007–present)**: A polymorphic file infector that injected itself into `.exe` and `.scr` files and added infected systems to a botnet via IRC C2. Its aggressive infection behavior often corrupted system files beyond repair.
- **Ramnit (2010–present)**: A multi-vector virus infecting PE executables, HTML files, and Office documents; evolved into a banking trojan platform. ENISA and Europol disrupted its C2 infrastructure in 2015.

---

## Defensive Measures

### Endpoint Protection

1. **Antivirus / Endpoint Detection and Response (EDR)**: Deploy a multi-engine AV or EDR solution (e.g., **Microsoft Defender for Endpoint**, **CrowdStrike Falcon**, **SentinelOne**) that incorporates signature-based detection, heuristic analysis, behavioral monitoring, and memory scanning. Ensure real-time protection and scheduled full-disk scans are enabled.

```powershell
# Force Windows Defender full scan via PowerShell
Start-MpScan -ScanType FullScan

# Update definitions before scanning
Update-MpSignature
```

2. **Application whitelisting**: Use **AppLocker** (Windows) or **WDAC (Windows Defender Application Control)** to permit only trusted, signed executables to run, preventing unsigned viral payloads from executing even if they infect a host file.

```powershell
# Create a basic AppLocker policy allowing only signed executables
# Via Group Policy: Computer Config → Windows Settings → Security Settings → Application Control Policies → AppLocker
```

3. **Macro policy enforcement**: Disable Office macros or restrict them to digitally signed macros from trusted publishers via **Group Policy**:
   - `User Configuration → Administrative Templates → Microsoft Office → Security Settings → Disable all macros without notification`

4. **UEFI Secure Boot**: Enable Secure Boot in firmware settings to prevent boot sector / bootkit viruses from executing before the OS loads. Verify the chain of trust from firmware → bootloader → OS kernel.

5. **File integrity monitoring (FIM)**: Deploy **OSSEC**, **Tripwire**, or **Wazuh** to monitor critical system files for unauthorized modifications — a primary indicator of file infector activity.

```bash
# Wazuh syscheck configuration for FIM
# /var/ossec/etc/ossec.conf
<syscheck>
  <frequency>3600</frequency>
  <directories check_all="yes">/usr/bin,/usr/sbin,/bin,/sbin</directories>
  <directories check_all="yes" realtime="yes">/etc</directories>
</syscheck>
```

6. **USB/removable media controls**: Enforce USB device restrictions via **Group Policy** or endpoint DLP tools to block unauthorized removable media from introducing viruses into the environment.

7. **Email gateway filtering**: Configure mail gateways (**Proofpoint**, **Mimecast**, **Microsoft Defender for Office 365**) to block executable attachments, strip macros from documents, and sandbox suspicious attachments before delivery.

8. **Patch management**: Maintain current patches for the OS and all applications, particularly Microsoft Office, Adobe Reader, and web browsers, which are common macro and drive-by download targets.

9. **Principle of least privilege**: Ensure users do not run as local administrators. A virus running in user context has limited ability to infect system files, write to the MBR, or persist across reboots compared to a virus with elevated privileges.

---

## Lab / Hands-On

> ⚠️ **Safety Warning**: All virus analysis must be conducted in an **isolated, air-gapped virtual machine** with no network connectivity and no shared folders with the host. Use snapshots to revert to a clean state after analysis.

### Lab 1: Analyze a Macro Virus Structure (Static Analysis, Safe)

Using the **EICAR test file** and **olevba** (part of the oletools suite) to analyze macro-enabled documents safely:

```bash
# Install oletools
pip install oletools