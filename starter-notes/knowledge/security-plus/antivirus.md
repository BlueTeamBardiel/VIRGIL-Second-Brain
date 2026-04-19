---
domain: "endpoint-security"
tags: [antivirus, malware-detection, endpoint-protection, defense-evasion, signature-detection, heuristics]
---
# Antivirus

**Antivirus (AV)** software is a class of endpoint security tools designed to detect, quarantine, and remove **malicious software (malware)** from computing systems by comparing files and processes against known threat signatures, behavioral patterns, and heuristic rules. Modern antivirus solutions have evolved far beyond simple **signature-based detection** into comprehensive **Endpoint Protection Platforms (EPP)** and **Endpoint Detection and Response (EDR)** tools. Understanding how AV works is critical both for defenders building layered security and for understanding [[Defense Evasion]] techniques used by attackers.

---

## Overview

Antivirus software originated in the late 1980s in direct response to the proliferation of early PC viruses such as the Brain virus (1986) and the Morris Worm (1988). Early tools like McAfee VirusScan (1987) and Norton AntiVirus (1990) relied entirely on **signature databases** — collections of known byte sequences unique to specific malware samples. When a file matched a signature, it was flagged as malicious. This model worked adequately when the malware ecosystem was small and slow-moving, but attackers quickly adapted.

The explosion of polymorphic and metamorphic malware in the 1990s and 2000s forced AV vendors to develop **heuristic analysis** — rules-based inspection of code structure and behavior rather than exact byte matching. A file that attempts to modify the Master Boot Record, inject code into running processes, or disable Windows Defender might be flagged as suspicious even without a matching signature. This was a necessary evolution but introduced **false positives**, where legitimate software is incorrectly identified as malicious.

The modern threat landscape has pushed AV further into **behavioral analysis**, **sandboxing**, **machine learning (ML)-based classification**, and cloud-assisted threat intelligence. Products like Microsoft Defender for Endpoint, CrowdStrike Falcon, SentinelOne, and Carbon Black perform continuous runtime monitoring, intercepting system calls and correlating events across the network to detect **indicators of compromise (IOC)** and **tactics, techniques, and procedures (TTPs)** associated with known threat actors. This convergence of AV and EDR capabilities is a defining characteristic of modern enterprise endpoint security.

From an attacker's perspective, antivirus represents a primary obstacle that must be understood and circumvented. **AV evasion** is an entire discipline within offensive security, encompassing techniques such as obfuscation, encoding, process injection, living-off-the-land (LOLBins), and the abuse of legitimate signed binaries. Security professionals must understand both sides of this equation — how AV detects threats and how attackers bypass those detections — to build effective defensive postures.

---

## How It Works

### 1. File Scanning (On-Access and On-Demand)

When a file is written to disk, opened, or executed, the AV **kernel driver** (operating as a minifilter driver on Windows via the Filter Manager) intercepts the I/O operation before it completes. The file content is passed to the scanning engine.

**On-Access Scanning** — triggered automatically on file open/write/execute:
```
File I/O Request → Kernel Minifilter Driver (e.g., MpFilter.sys for Defender)
                → AV Scanning Engine
                → Decision: Allow / Quarantine / Delete
                → I/O Request Completes or is Blocked
```

**On-Demand Scanning** — manually or scheduled initiated:
```powershell
# Windows Defender manual scan
Start-MpScan -ScanType FullScan
Start-MpScan -ScanType QuickScan
Start-MpScan -ScanType CustomScan -ScanPath "C:\Users\Public\Downloads"

# Update definitions before scanning
Update-MpSignature

# Check current definition versions
Get-MpComputerStatus | Select-Object AntivirusSignatureLastUpdated, AntivirusSignatureVersion
```

### 2. Signature-Based Detection

The AV engine extracts a **hash** (MD5, SHA-1, SHA-256) of the file and compares it against a local signature database. If there's no hash match, the engine extracts **byte sequences** (patterns) from specific file offsets and compares against signature patterns.

```bash
# Checking a file hash against VirusTotal via CLI (using vt-cli)
vt file <sha256_hash>

# Manually compute hashes on Linux
sha256sum suspicious_file.exe
md5sum suspicious_file.exe

# On Windows PowerShell
Get-FileHash .\suspicious_file.exe -Algorithm SHA256
```

Signatures are stored in **VDF (Virus Definition Files)** or equivalent vendor-specific databases, typically updated multiple times per day. Microsoft Defender's definitions are stored at:
```
C:\ProgramData\Microsoft\Windows Defender\Definition Updates\
```

### 3. Heuristic Analysis

The engine disassembles or parses the file without executing it (**static analysis**) and looks for suspicious characteristics:
- Entry point anomalies (code in unexpected sections)
- Known packer signatures (UPX, MPRESS, Themida)
- Suspicious import table entries (`VirtualAlloc`, `WriteProcessMemory`, `CreateRemoteThread`)
- Encrypted or high-entropy sections indicating packed/obfuscated code

```python
# Example: Using pefile to check for suspicious imports (blue team analysis)
import pefile
import math

pe = pefile.PE("suspicious.exe")

suspicious_imports = ["VirtualAlloc", "WriteProcessMemory", "CreateRemoteThread",
                      "NtUnmapViewOfSection", "SetWindowsHookEx"]

for entry in pe.DIRECTORY_ENTRY_IMPORT:
    for imp in entry.imports:
        if imp.name and imp.name.decode() in suspicious_imports:
            print(f"[!] Suspicious import: {imp.name.decode()} from {entry.dll.decode()}")
```

### 4. Behavioral / Dynamic Analysis

Modern AV hooks **Windows API calls** at runtime using user-mode hooks (patching `ntdll.dll` functions) or kernel callbacks. When a process calls `CreateRemoteThread` or attempts to encrypt files in rapid succession, the engine can terminate the process.

```
Process Execution → API Hook Intercept (e.g., NtCreateThreadEx)
                 → Behavior Rules Engine
                 → Correlated Event Log
                 → Threshold Exceeded → Kill Process / Alert
```

### 5. Cloud Lookup / Reputation

Files with unknown hashes are submitted (or their metadata is submitted) to vendor cloud infrastructure for reputation scoring. This provides near-zero-day detection for newly discovered malware before local signatures are updated.

```
New File Hash → Local DB Miss → Cloud Reputation Query (HTTPS/443)
             → Vendor Cloud (e.g., Microsoft Active Protection Service - MAPS)
             → Response: Malicious / Clean / Unknown
             → Cache result locally
```

### 6. Quarantine and Remediation

Detected files are moved to an isolated quarantine store where they cannot execute, but can be reviewed or restored by an administrator:
```powershell
# List quarantined items in Windows Defender
Get-MpThreat

# Restore a quarantined item (use with caution)
Restore-MpThreatItem -ThreatItemID <ID>

# Remove all quarantined items
Remove-MpThreat
```

---

## Key Concepts

- **Signature-Based Detection**: The oldest and most reliable method for known malware; compares file hashes and byte patterns against a database of known malicious code. Fast and low resource overhead but completely blind to novel, zero-day, or obfuscated threats.

- **Heuristic Analysis**: Static code analysis that flags files exhibiting characteristics common to malware (suspicious API imports, abnormal PE structure, high entropy sections) without requiring an exact signature match. Trades accuracy for coverage but introduces false positive risk.

- **Behavioral Analysis (Dynamic Analysis)**: Runtime monitoring of process activity — API calls, network connections, file system changes, registry modifications — that compares observed behavior against known malicious TTP profiles. Can detect previously unknown malware by what it *does* rather than what it *is*.

- **Sandboxing**: Controlled execution of suspicious files in an isolated virtual environment to observe behavior safely before allowing execution on the real system. Used heavily in email gateways and advanced AV products like CrowdStrike Falcon Sandbox (formerly Hybrid Analysis).

- **Polymorphic Malware**: Malware that mutates its own code (typically by re-encrypting its payload with a different key each time it replicates) while preserving its core functionality, specifically designed to defeat signature-based detection. Each variant produces a different hash and byte sequence.

- **Metamorphic Malware**: A more advanced form of self-modifying malware that rewrites its entire code body (reordering instructions, substituting equivalent operations, inserting junk code) so that no recognizable byte patterns persist between generations. Extremely difficult to detect with signatures alone.

- **False Positive / False Negative**: A **false positive** is when benign software is incorrectly identified as malicious (causes operational disruption); a **false negative** is when actual malware is not detected (a security failure). Tuning AV involves balancing these two outcomes.

- **Endpoint Detection and Response (EDR)**: The modern evolution of AV; provides continuous recording of endpoint telemetry, threat hunting capabilities, automated response actions, and integration with SIEM/SOAR platforms. Examples: CrowdStrike Falcon, Microsoft Defender for Endpoint, SentinelOne.

- **AMSI (Antimalware Scan Interface)**: A Windows API that allows applications (PowerShell, VBScript, Office macros) to pass script content to registered AV engines for scanning at runtime before execution, closing the "fileless malware" gap in traditional file-based scanning.

---

## Exam Relevance

**SY0-701 Exam Tips:**

- **AV fits within the "Endpoint Security" domain** (Domain 4: Security Operations) and is frequently tested as a component of a layered defense-in-depth strategy, not as a standalone solution.

- **Know the detection types by name**: Signature-based, heuristic, behavioral, and anomaly-based. The exam will present scenarios asking which detection method would catch a specific type of threat. *Zero-day malware* → heuristic/behavioral; *known ransomware* → signature-based.

- **Understand AV limitations**: The exam tests whether candidates know that AV alone is insufficient. Questions often present scenarios involving fileless malware, LOLBin abuse, or encrypted payloads and ask what *additional* control is needed (EDR, application whitelisting, network segmentation).

- **AMSI is testable**: Know that AMSI extends AV scanning to scripts and memory-resident code. PowerShell Empire, Cobalt Strike, and similar tools explicitly include AMSI bypass modules — the exam may reference this in the context of defense evasion.

- **EPP vs. EDR distinction**: Endpoint Protection Platforms (EPP) prevent threats proactively; EDR detects and responds to threats that have already executed. The exam may ask candidates to distinguish between them or recommend one for a specific scenario.

- **Common gotcha**: Antivirus does NOT protect against all malware. It is explicitly tested that AV cannot reliably detect: advanced persistent threats (APTs), zero-days, fileless malware, or living-off-the-land attacks without behavioral analysis components.

- **Quarantine vs. Deletion**: AV quarantines files rather than deleting them immediately to allow administrator review and prevent false-positive data loss. Know this distinction.

---

## Security Implications

### AV as an Attack Surface

Antivirus software itself has historically been a high-value target for attackers due to its privileged execution context (kernel-level drivers, SYSTEM process) and broad code parsing attack surface:

- **CVE-2016-2208 (Symantec Endpoint Protection)**: A buffer overflow in the Symantec decomposer engine allowed remote code execution via a malformed RAR archive — no user interaction required, triggered by simply receiving a malicious email that the AV scanned.
- **CVE-2021-28550 (Acrobat/AV interaction)**: AV parsing of PDF files has been repeatedly implicated in remote code execution chains.
- **CVE-2022-37969 (Windows Common Log File System / Defender interaction)**: Privilege escalation vulnerabilities in Windows components used by Defender have been exploited in the wild.
- **Tavis Ormandy (Project Zero) research**: Google Project Zero researcher Tavis Ormandy has repeatedly demonstrated that major AV products (Symantec, Sophos, Trend Micro, ESET, Comodo) contain critical vulnerabilities in their file parsing engines, arguing that complex parsing code running at high privilege creates more attack surface than it eliminates.

### AV Evasion Techniques

From an offensive security perspective, these techniques are well-documented and testable:

- **Packing/Obfuscation**: Tools like UPX, Themida, or custom packers compress and encrypt executables. The AV sees only the packer stub, not the payload. Counter: AV vendors build packer detection into heuristics.
- **Encoding/Encryption**: Payload encoded in Base64, XOR, or custom schemes; only decoded in memory at runtime. Targets the gap in file-based scanning.
- **Process Injection**: Injecting shellcode into legitimate processes (e.g., `explorer.exe`) using `VirtualAllocEx` + `WriteProcessMemory` + `CreateRemoteThread`. The malicious code runs under a trusted process identity.
- **Living off the Land (LOLBins)**: Abusing trusted Windows binaries (`mshta.exe`, `regsvr32.exe`, `certutil.exe`, `wmic.exe`) to download and execute payloads. No malicious file is written to disk.
- **AMSI Bypass**: Patching the `AmsiScanBuffer` function in memory (within the PowerShell process) to always return a "clean" result, neutering script-based AV detection. This is a well-known technique used by commodity malware and nation-state actors alike.

```powershell
# Classic AMSI bypass (educational/research purposes - extremely well-known)
# This technique patches the AMSI DLL in memory
# Included here to demonstrate why AMSI alone is insufficient
[Ref].Assembly.GetType('System.Management.Automation.AmsiUtils').GetField('amsiInitFailed','NonPublic,Static').SetValue($null,$true)
# Note: Modern EDR products detect this specific technique via behavioral rules
```

- **Fileless Malware**: Payloads that exist only in memory (e.g., loaded via reflective DLL injection or PowerShell), leaving no artifacts on disk for file-based AV scanners to detect.

---

## Defensive Measures

### 1. Layered Defense — Never Rely Solely on AV
Deploy AV as one layer in a defense-in-depth stack:
```
[Network Firewall] → [IDS/IPS] → [Email Gateway with Sandboxing] 
→ [Web Proxy with SSL Inspection] → [Endpoint AV/EDR] 
→[Application Whitelisting] → [Privileged Access Management]
```

### 2. Keep Definitions Current
Configure automatic signature updates at the shortest feasible interval (multiple times daily):
```powershell
# Force Windows Defender definition update via GPO or script
Update-MpSignature -UpdateSource MicrosoftUpdateServer
# Or via WSUS/SCCM for enterprise environments

# Check update status
Get-MpComputerStatus | Select-Object -Property AntivirusSignatureAge, AntivirusSignatureLastUpdated
```

### 3. Enable Cloud-Delivered Protection and Automatic Sample Submission
```powershell
# Enable Microsoft Defender cloud features via PowerShell
Set-MpPreference -MAPSReporting Advanced
Set-MpPreference -SubmitSamplesConsent SendAllSamples
Set-MpPreference -CloudBlockLevel High
Set-MpPreference -CloudExtendedTimeout 50
```

### 4. Enable AMSI and Script Block Logging
```powershell
# Enable PowerShell Script Block Logging via GPO or registry
# HKLM\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging" /v EnableScriptBlockLogging /t REG_