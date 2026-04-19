---
domain: "endpoint-security"
tags: [antivirus, endpoint, malware, evasion, detection, edr]
---
# Anti-Virus

**Anti-Virus** (AV) software detects, prevents, and removes **malicious code** from endpoints using a combination of **signature matching**, **heuristic analysis**, and **behavioral monitoring**. Once the cornerstone of endpoint security, modern AV has largely converged with [[Endpoint Detection and Response]] (EDR) and [[Extended Detection and Response]] (XDR) platforms. From an attacker's perspective, AV is the first technical hurdle on a compromised host — an obstacle that [[Malware]] authors have been circumventing since the late 1980s.

---

## Overview

The term *antivirus* emerged in the 1980s after Fred Cohen formally defined the computer virus in his 1983 doctoral work. Early commercial products — G DATA AntiVirusKit (1987), John McAfee's VirusScan (1987), and Peter Norton's offering (acquired by Symantec in 1990) — responded to self-replicating DOS-era threats such as *Brain*, *Jerusalem*, and *Cascade*. These first-generation engines were purely **signature-based**: they searched files for known byte patterns taken from captured malware samples.

Through the 1990s and 2000s, the threat landscape exploded. Macro viruses (Concept, Melissa), mass-mailing worms (ILOVEYOU, SoBig, MyDoom), and network worms (Code Red, Nimda, SQL Slammer, Blaster, Conficker) forced vendors to add **heuristic engines**, **on-access scanners** hooked into the file system, and later **behavioral analytics** that observed runtime actions. The 2000s also saw the rise of rootkits and bootkits (Sony BMG, TDL/Alureon), prompting AVs to gain kernel-mode drivers capable of inspecting activity well below the OS surface.

From roughly 2010 onward, the industry pivoted again. **Cloud reputation** services (Microsoft MAPS, Kaspersky Security Network, Symantec Insight) reduced local signature size by offloading hash lookups. **Machine learning** models trained on billions of samples replaced brittle heuristics. Sandboxing technologies (Cuckoo, FireEye MVX) enabled pre-detonation analysis of unknown files before execution. Most recently, vendors folded AV capabilities into [[EDR]] suites that stream telemetry to a [[SIEM]] and support remote response actions like process kill, host isolation, and forensic acquisition.

The commercial landscape today is dominated by **Microsoft Defender for Endpoint** (bundled with Windows, enterprise via Defender XDR), **CrowdStrike Falcon**, **SentinelOne Singularity**, **ESET**, **Sophos Intercept X**, **Kaspersky**, **Bitdefender**, and the open-source **ClamAV**. MITRE's annual ATT&CK Evaluations and independent labs (AV-Comparatives, AV-TEST, SE Labs) benchmark detection efficacy across these vendors.

Despite its evolution, AV is not a silver bullet. Verizon's annual *Data Breach Investigations Report* consistently shows that phishing, stolen credentials, and unpatched vulnerabilities outpace malware as initial access vectors — meaning defenders cannot rely on AV alone. AV remains a mandatory control under PCI DSS, HIPAA, and most cyber-insurance policies, but it must be layered with patching, MFA, network segmentation, and centralized logging.

---

## How It Works

A modern AV agent is a hybrid system combining a **kernel-mode driver**, a **user-mode scanning service**, and **cloud-connected components**. On Windows, Microsoft Defender ships with the following components:

- `MsMpEng.exe` — the user-mode Antimalware Service Executable, running as a **Protected Process Light (PPL)** to resist termination.
- `MpEngine.dll` — the core scanning engine library loaded into `MsMpEng.exe`.
- `WdFilter.sys` — a file-system **minifilter driver** that intercepts all file I/O at the kernel level.
- `WdBoot.sys` / `WdNisDrv.sys` — Early Launch Anti-Malware (ELAM) for boot integrity and network inspection respectively.

### On-Access Scan Pipeline

When any process attempts to open or execute a file, the following happens:

1. The process calls `CreateFile` / `NtCreateFile` on an executable, script, or document.
2. The Filter Manager delivers the I/O Request Packet (IRP) to `WdFilter.sys` **before** the file handle is returned to the caller.
3. The minifilter hashes the file and checks the local signature cache (`.vdm` definition files — `mpam-fe.exe`, `mpas-fe.exe`).
4. If the hash is known-clean, the request passes. If known-malicious, it is blocked. If unknown, the file is memory-mapped into `MsMpEng.exe` for emulation and heuristic evaluation.
5. Script content — PowerShell, VBScript, JScript, Office macros, and .NET assemblies loaded via `Assembly.Load` — is submitted through [[AMSI]] (Anti-Malware Scan Interface) via the `AmsiScanBuffer` API call **after** deobfuscation, giving AV visibility into what the script actually does.
6. Unknown binaries are hashed (SHA-256) and queried against **Microsoft Active Protection Service (MAPS)** cloud. High-risk or brand-new samples may be uploaded for live detonation (Block-at-First-Sight).
7. A verdict is returned. If malicious: the file is blocked, moved to quarantine, and a Defender alert is written to the `Microsoft-Windows-Windows Defender/Operational` event log (Event ID **1116** = threat detected, **1117** = threat action taken).

### Behavioral Detection

Behavioral engines use kernel callbacks registered during driver load:

- `PsSetCreateProcessNotifyRoutineEx` — fires on every process create/exit.
- `PsSetLoadImageNotifyRoutine` — fires on every PE load (EXE, DLL, driver).
- `CmRegisterCallbackEx` — intercepts registry operations.
- `ObRegisterCallbacks` — mediates handle requests to protected processes (LSASS).
- **ETW (Event Tracing for Windows)** — specifically the `Microsoft-Windows-Threat-Intelligence` provider, which captures `ReadProcessMemory`, `VirtualAllocEx`, and other sensitive API calls from kernel space.

Suspicious API sequences (e.g., `VirtualAllocEx` → `WriteProcessMemory` → `CreateRemoteThread`) are scored and mapped to [[MITRE ATT&CK]] technique IDs, generating structured detections.

### Operator Commands

**Windows — PowerShell:**

```powershell
# Health and status
Get-MpComputerStatus
Get-MpPreference
Get-MpThreatDetection

# On-demand scans
Start-MpScan -ScanType QuickScan
Start-MpScan -ScanType FullScan
Start-MpScan -ScanType CustomScan -ScanPath "C:\Users"

# Pull latest definitions
Update-MpSignature

# Add an exclusion (audit these carefully — attackers target them)
Add-MpPreference -ExclusionPath "C:\Builds"
Add-MpPreference -ExclusionProcess "ci-runner.exe"

# Enable an Attack Surface Reduction rule (blocks Office spawning child processes)
Add-MpPreference -AttackSurfaceReductionRules_Ids D4F940AB-401B-4EFC-AADC-AD5F3C50688A `
                 -AttackSurfaceReductionRules_Actions Enabled
```

**Linux — ClamAV:**

```bash
sudo freshclam                          # Update signatures
clamscan -r --bell -i /home             # Recursive scan, ring bell on infection
clamdscan --fdpass /var/www             # Scan via clamd daemon (faster)
clamonacc -c /etc/clamav/clamd.conf     # On-access scanning via fanotify
```

AV agents communicate with management infrastructure over **TLS/443** for policy push, definition updates, and cloud telemetry. On-premises update distribution points may use **SMB (445)**. Alert forwarding to a SIEM uses **Syslog (UDP/TCP 514)** or **Windows Event Forwarding (WEF)** over WinRM (5985/5986).

---

## Key Concepts

- **Signature-based detection** — Matching files against hashes (MD5, SHA-1, SHA-256), byte strings, or [[YARA]] rules derived from known malware. Extremely fast and precise but completely blind to novel or obfuscated samples.
- **Heuristic analysis** — Static inspection for suspicious structural characteristics: packed sections, high entropy, dangerous import combinations (`VirtualAllocEx` + `WriteProcessMemory` + `CreateRemoteThread`), or suspicious PE header anomalies.
- **Behavioral / dynamic analysis** — Runtime observation of process trees, API call sequences, registry writes, network connections, and file system activity, often scored against rule sets or ML models and mapped to ATT&CK tactics.
- **Cloud lookup and reputation** — The file's SHA-256 is queried against a vendor cloud database; unknown files may be uploaded for sandbox detonation. This collapses time-to-protect from hours to minutes for new campaigns.
- **AMSI (Anti-Malware Scan Interface)** — A Windows COM API (introduced in Windows 10) that allows scripting hosts (PowerShell, WScript, Office VBA) and .NET runtimes to hand in-memory script content to the installed AV engine **after deobfuscation** — defeating simple encoding bypasses.
- **Quarantine** — An encrypted holding area (e.g., `C:\ProgramData\Microsoft\Windows Defender\Quarantine`) where detected files are stored intact, allowing administrators to review, submit, or restore them if false-positive.
- **False Positive / False Negative** — A false positive (FP) incorrectly blocks legitimate software; a false negative (FN) fails to detect real malware. Vendors tune detection thresholds to balance both. High-profile FP events include McAfee's 2010 DAT 5958 update bricking `svchost.exe` and the CrowdStrike 2024 channel file outage.
- **Tamper Protection** — A vendor-enforced mechanism that prevents local administrators — or malware running as SYSTEM — from disabling AV, adding exclusions, stopping services, or rolling back definitions without cloud authentication.
- **PUA / PUP (Potentially Unwanted Application / Program)** — Adware, bundleware, and toolbars flagged at a lower severity than malware; AV handles these separately, typically with a user prompt rather than automatic quarantine.
- **EICAR test file** — A harmless 68-byte ASCII string standardized by the European Institute for Computer Antivirus Research. Every compliant AV engine detects it as `EICAR-Test-File`, enabling safe deployment validation.

---

## Exam Relevance

SY0-701 treats Anti-Virus primarily under **Domain 4: Security Operations** and references it across **Domain 2: Threats, Vulnerabilities, and Mitigations** for malware types and **Domain 3: Security Architecture** for layered defenses.

- **AV vs. EDR vs. XDR vs. HIDS** — A frequent exam distinction. AV = prevention via signatures/heuristics. [[EDR]] = AV + behavioral telemetry + remote response. [[XDR]] = EDR correlated across email, network, identity, and cloud. [[HIDS]] = alerts on host anomalies (file changes, log tampering) without the active prevention component.
- **Detection method questions** — Expect scenarios asking which method catches *known* malware (signature), *variants* (heuristic), *novel zero-days* (behavioral or sandbox). Know that signature alone **cannot** detect zero-days.
- **Defense in depth framing** — AV is one compensating control among many. Correct exam answers will combine AV with patching, MFA, least privilege, and network segmentation.
- **Control type classification** — Antivirus is a **preventive technical control** when it blocks threats. Its event logs are **detective**. The same tool plays multiple control-type roles — read questions carefully.
- **Compensating control** — AV may be the cited compensating control when a vulnerable system cannot be patched immediately. Know when this framing appears.
- **Common gotcha** — SY0-701 uses "endpoint protection platform" and "antimalware" interchangeably with AV in some questions. Treat them as functionally equivalent unless the scenario specifies behavioral/EDR capabilities.
- **Sandboxing** — Expect questions where AV with sandboxing (detonation) is the correct answer for catching previously unknown malware in email attachments before delivery.

---

## Security Implications

AV is simultaneously a defender and a high-value attack surface. Kernel-mode drivers, automatically updating binaries running as SYSTEM or PPL, and privileged inter-process communication make AV engines attractive targets for both exploitation and evasion.

### Notable CVEs and Incidents

| CVE / Event | Vendor | Impact |
|---|---|---|
| **CVE-2021-1647** | Microsoft Defender (`mpengine.dll`) | Remote Code Execution — actively exploited before patch; parsing malformed files triggered heap overflow. |
| **CVE-2020-12271** | Sophos XG Firewall | Pre-auth SQL injection leading to RCE on the AV/UTM appliance. Exploited by Asnarök malware campaign. |
| **CVE-2022-37969** | Windows CLFS (weaponized against EDRs) | Kernel LPE used by tooling such as EDRKillShifter to terminate protected AV processes. |
| **McAfee DAT 5958 (April 21, 2010)** | McAfee VirusScan | Faulty signature update flagged `svchost.exe` on Windows XP SP3 as `W32/Wecorl.a`, rebooting millions of enterprise machines including police dispatch and hospital systems. |
| **CrowdStrike Falcon (July 19, 2024)** | CrowdStrike | Malformed channel file update (`C-00000291-*.sys`) triggered an out-of-bounds read in the Falcon sensor kernel driver, producing a BSOD boot loop on approximately 8.5 million Windows hosts across airlines, hospitals, banks, and broadcasters globally. |

### Common Attacker Techniques

- **Build-time evasion** — Packers (UPX, Themida, MPRESS), crypters, source-level obfuscation, [[Polymorphic Malware|polymorphism]] (changing code on each infection), and metamorphism (rewriting logic while preserving behavior) defeat signature matching.
- **In-memory execution** — Reflective DLL injection, process hollowing, process doppelgänging, and module stomping keep payloads off disk entirely, evading on-access file scanning.
- **Living Off the Land ([[LOLBAS]])** — Abusing signed Microsoft binaries (`rundll32`, `mshta`, `regsvr32`, `InstallUtil`, `certutil`, `wmic`) to execute malicious code using allow-listed processes.
- **AMSI bypass** — Patching `AmsiScanBuffer` or `AmsiInitialize` in-memory to return a clean verdict, hardware-breakpoint hooks, or forcing .NET assembly load before AMSI initialization. Matt Graeber's one-liner using `[Ref].Assembly.GetType(...)` is a canonical example.
- **ETW patching** — Overwriting `EtwEventWrite` in user space to blind telemetry providers relied on by EDR agents.
- **BYOVD (Bring Your Own Vulnerable Driver)** — Loading a legitimately signed but exploitable kernel driver (`mhyprot2.sys`, `RTCore64.sys`, `dbutil_2_3.sys`) to gain kernel execution and terminate PPL-protected AV processes. Used by BlackByte ransomware, LockBit affiliates, Scattered Spider, and the Lazarus Group.
- **Commodity EDR killers** — Ready-made tooling including EDRKillShif