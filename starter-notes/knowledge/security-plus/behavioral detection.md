---
domain: "cybersecurity"
tags: [detection, threat-intelligence, endpoint-security, malware-analysis, siem, heuristics]
---
# behavioral detection

**Behavioral detection** is a security methodology that identifies threats by analyzing the *actions and patterns* of processes, users, and systems rather than relying on static [[signature-based detection]] of known malware. It is a cornerstone of modern [[endpoint detection and response]] (EDR) platforms, [[SIEM]] correlation engines, and [[next-generation antivirus]] (NGAV) solutions. By observing *what software does* rather than what it looks like, behavioral detection can surface zero-day exploits, fileless malware, and living-off-the-land attacks that signature scanners miss entirely.

---

## Overview

The fundamental limitation of signature-based detection is that it requires prior knowledge of a threat — a sample must be captured, analyzed, and catalogued before defenders can recognize it. Attackers exploit this window by continuously morphing their malware, packing executables, or simply using legitimate system tools like PowerShell, WMI, and certutil to carry out attacks. Behavioral detection was developed to close this gap by shifting the question from "have I seen this file before?" to "is this process doing something a normal process would never do?"

Behavioral engines operate by establishing baselines — models of normal activity for a system, user, or application. These baselines are derived from continuous telemetry collection: system calls, network connections, registry modifications, file I/O operations, parent-child process relationships, and authentication events. Once a baseline is established, the detection engine evaluates new events against statistical and rule-based models to flag anomalies. A word processor spawning a command shell, or a browser process reading the Windows credential store, represents a behavioral anomaly that triggers an alert regardless of whether the underlying code has ever been seen before.

Behavioral detection is not a single technology but a spectrum of techniques. At the low end, it includes simple heuristic rules — for example, flagging any process that attempts to hollow another process's memory. At the high end, it includes machine learning models trained on billions of telemetry events that can detect subtle deviations from normal behavior, such as a user suddenly accessing file shares they have never touched, a precursor pattern associated with ransomware lateral movement. Modern platforms like Microsoft Defender for Endpoint, CrowdStrike Falcon, and SentinelOne combine both approaches.

The concept extends beyond endpoint detection into network security. [[Network Traffic Analysis]] (NTA) tools such as Darktrace and Vectra AI apply behavioral modeling to network flows, flagging hosts that begin communicating with unusual external IP ranges, generating anomalous volumes of DNS queries, or conducting internal port scans — classic indicators of compromise that are invisible to perimeter firewalls blocking known-bad IP lists. This network-layer behavioral detection complements endpoint telemetry to provide defense-in-depth.

---

## How It Works

### 1. Telemetry Collection

The behavioral engine's first requirement is visibility. An EDR agent deployed on an endpoint hooks into the operating system at a kernel or user-space level to intercept and log events in real time. On Windows, this is typically done via:

- **ETW (Event Tracing for Windows)** — kernel-level event subscription
- **Kernel callbacks** — `PsSetCreateProcessNotifyRoutine`, `PsSetLoadImageNotifyRoutine`
- **Minifilter drivers** — for filesystem I/O interception
- **AMSI (Antimalware Scan Interface)** — for script content inspection

On Linux, similar visibility comes from **eBPF probes**, **auditd**, and **fanotify** for filesystem events.

The agent ships this telemetry to a cloud or on-premise backend. A typical event record looks like:

```json
{
  "timestamp": "2024-11-15T03:42:17Z",
  "event_type": "ProcessCreate",
  "parent_process": "winword.exe",
  "parent_pid": 4832,
  "child_process": "cmd.exe",
  "child_pid": 9104,
  "command_line": "cmd.exe /c powershell -nop -w hidden -enc SQBFAFgA...",
  "user": "CORP\\jsmith",
  "integrity_level": "High"
}
```

This single event — Microsoft Word spawning a hidden, encoded PowerShell command — is a textbook behavioral indicator of a malicious macro.

### 2. Baseline Establishment

Before anomalies can be detected, the engine must know what "normal" looks like. Baselines can be:

- **Static rule-derived**: Industry-wide rules about what processes should never do (e.g., `lsass.exe` should never read from the internet)
- **Environment-specific statistical baselines**: Learned over days or weeks from the specific organization's telemetry
- **User entity baselines**: Per-user behavioral profiles (used in [[UEBA]] — User and Entity Behavior Analytics)

### 3. Detection Logic

Detection logic falls into several categories:

**Rule-based heuristics (deterministic):**
```
IF parent_process == "winword.exe"
AND child_process IN ["cmd.exe", "powershell.exe", "wscript.exe", "mshta.exe"]
THEN alert(severity=HIGH, tactic="Initial Access", technique="T1566.001")
```

**Statistical anomaly detection:**
The engine calculates a deviation score. For example, if a user account `jsmith` has never before accessed `\\FILESERVER\Finance$` and suddenly reads 10,000 files at 3 AM, the anomaly score exceeds threshold.

**ML model scoring:**
The process tree, network graph, and event sequence are encoded as feature vectors and scored by a trained classifier. CrowdStrike's Threat Graph, for instance, maps billions of event relationships across millions of endpoints to contextualize whether a given sequence is malicious.

### 4. MITRE ATT&CK Mapping

Modern behavioral engines map detections to the [[MITRE ATT&CK]] framework. A process injection detection would map to:

- **Tactic**: Defense Evasion / Privilege Escalation
- **Technique**: T1055 – Process Injection
- **Sub-technique**: T1055.001 – Dynamic-link Library Injection

This mapping gives analysts immediate context for triage and enables threat hunting by technique.

### 5. Response Actions

When a behavioral alert fires, the engine can take automated response actions:

```bash
# CrowdStrike RTR (Real Time Response) — isolate a host
crowdstrike-cli host isolate --aid <agent_id>

# Carbon Black — kill a process via API
curl -X DELETE https://cbserver/api/v1/process/<pid> -H "X-Auth-Token: <token>"
```

On-sensor response can include: process termination, network isolation, memory dump capture, and rollback of file changes.

---

## Key Concepts

- **Baseline / Normal Profile**: A statistical or rule-derived model of expected behavior for a system, user, or application; deviations from this baseline trigger alerts and are the foundation of anomaly-based detection.
- **Heuristic Rules**: Predefined logical conditions that flag inherently suspicious behaviors (e.g., a browser writing an executable to `%TEMP%` and then executing it) without requiring a known malware signature.
- **UEBA (User and Entity Behavior Analytics)**: An extension of behavioral detection that builds individual behavioral profiles for users and devices, enabling detection of insider threats, compromised credentials, and account takeover based on deviations from personal norms.
- **Process Hollowing / Injection Detection**: Behavioral indicators caught by monitoring calls to `VirtualAllocEx`, `WriteProcessMemory`, `CreateRemoteThread`, and `NtUnmapViewOfSection` — the Win32 API sequence used by many process injection techniques.
- **Living-off-the-Land (LotL) Detection**: Behavioral detection is the primary defense against LotL attacks where adversaries use legitimate tools like `powershell.exe`, `certutil.exe`, `regsvr32.exe`, and `mshta.exe` to execute malicious payloads, since no malicious binary is ever written to disk.
- **False Positive Rate**: The percentage of alerts that turn out to be benign activity; behavioral detection inherently produces more false positives than signature detection, requiring tuning, allowlisting, and analyst triage workflows.
- **Telemetry Pipeline**: The collection, transport, enrichment, and storage infrastructure that carries raw endpoint and network events from sensors to the detection engine — latency and completeness of this pipeline directly affect detection fidelity.

---

## Exam Relevance

The Security+ SY0-701 exam tests behavioral detection primarily within the context of **threat detection and response** and **security tools**. Key areas to know:

**Domain mapping**: Behavioral detection appears in Domain 4 (Security Operations) and Domain 2 (Threats, Vulnerabilities, and Mitigations).

**Common question patterns**:
- *"A security analyst notices that a legitimate admin tool is being used to exfiltrate data. Which detection method would have caught this?"* → Answer: **behavioral/anomaly-based detection** (signature detection would miss it because the tool is legitimate)
- *"Which type of detection is best suited for zero-day malware?"* → **Behavioral/heuristic** detection, not signature-based
- *"A user logs in at 3 AM from a foreign country for the first time. Which system would flag this?"* → **UEBA** or behavioral analytics

**Gotchas**:
- Do not confuse **behavioral detection** (what a program *does*) with **heuristic detection** (what a program *looks like statically*). The exam sometimes uses these loosely, but they are distinct: heuristics can be either static (PE header analysis) or behavioral (runtime action monitoring).
- **Anomaly-based** detection = behavioral detection in most exam contexts. Remember it generates more false positives than signature-based but catches more zero-days.
- Know that behavioral detection is a feature of **EDR**, **NGAV**, **SIEM**, and **UEBA** platforms — not traditional antivirus.
- The exam may describe a scenario and ask you to choose between: signature-based, behavioral, heuristic, and reputation-based detection. Know the differentiators cold.

---

## Security Implications

### Evasion Techniques Against Behavioral Detection

Sophisticated adversaries specifically design their tools and techniques to evade behavioral engines:

- **Sleep and timing evasion**: Malware sleeps for extended periods (hours or days) before executing, attempting to outlast sandbox analysis windows and confuse behavioral baselines.
- **API unhooking**: Malware patches EDR hooks out of memory by reloading clean copies of `ntdll.dll` directly from disk, bypassing userspace telemetry collection.
- **Indirect syscalls**: Bypassing Win32 API hooks entirely by calling kernel syscalls directly using assembly stubs, defeating userspace behavioral monitors.
- **LOLBAS abuse with low velocity**: Using legitimate binaries very slowly and infrequently to stay under statistical detection thresholds.
- **Process parent spoofing**: Manipulating the recorded parent PID to make malicious process trees appear legitimate, defeating parent-child relationship rules.

### Real-World Incidents

**SolarWinds SUNBURST (2020)**: SUNBURST specifically delayed execution for up to two weeks after installation and checked for the presence of security tools before activating. It blended its C2 traffic with legitimate SolarWinds Orion API calls. Behavioral detection platforms that analyzed DNS request patterns eventually identified the unique DGA (Domain Generation Algorithm) subdomain scheme used by SUNBURST — catching what signature scanners had missed for months.

**Emotet**: Emotet's operators continuously changed the malware's packing, encoding, and delivery mechanisms to defeat signatures. Behavioral detection of its macro-based delivery (Office document → cmd.exe → PowerShell download cradle) became the primary defensive layer, captured by rules monitoring `winword.exe` spawning command interpreters.

**Log4Shell (CVE-2021-44228)**: Behavioral detection engines were able to identify exploitation attempts by monitoring for Java processes spawning unexpected child processes (e.g., `java.exe` spawning `bash` or `cmd.exe`) — a clear behavioral anomaly regardless of the specific JNDI payload used.

---

## Defensive Measures

### EDR Platform Deployment

Deploy an EDR with behavioral detection capabilities on all endpoints. Recommended platforms:

- **Microsoft Defender for Endpoint** — integrates natively with Windows; enable Attack Surface Reduction (ASR) rules
- **CrowdStrike Falcon** — cloud-native; Threat Graph correlation
- **SentinelOne** — strong autonomous response (Storyline technology)
- **Elastic Endpoint** — open-source option suitable for homelabs

### Enable and Tune ASR Rules (Windows)

Attack Surface Reduction rules are Microsoft's built-in behavioral detection layer:

```powershell
# Enable ASR rule: Block Office apps from creating child processes
Set-MpPreference -AttackSurfaceReductionRules_Ids D4F940AB-401B-4EFC-AADC-AD5F3C50688A `
                 -AttackSurfaceReductionRules_Actions Enabled

# Enable: Block credential stealing from Windows local security authority
Set-MpPreference -AttackSurfaceReductionRules_Ids 9E6C4E1F-7D60-472F-BA1A-A39EF669E4B0 `
                 -AttackSurfaceReductionRules_Actions Enabled

# Audit mode first (value=2) before enforcing (value=1)
Set-MpPreference -AttackSurfaceReductionRules_Actions 2
```

### SIEM Behavioral Rules

Build SIEM correlation rules targeting behavioral patterns using [[Sigma]] rule format:

```yaml
title: Suspicious Office Child Process
status: stable
description: Detects Office applications spawning suspicious child processes
logsource:
    category: process_creation
    product: windows
detection:
    selection:
        ParentImage|endswith:
            - '\winword.exe'
            - '\excel.exe'
            - '\powerpnt.exe'
        Image|endswith:
            - '\cmd.exe'
            - '\powershell.exe'
            - '\wscript.exe'
            - '\mshta.exe'
            - '\certutil.exe'
    condition: selection
level: high
tags:
    - attack.initial_access
    - attack.t1566.001
```

### Audit Policy Configuration

Ensure Windows audit policies capture the events behavioral engines need:

```powershell
# Enable process creation auditing with command line
auditpol /set /subcategory:"Process Creation" /success:enable /failure:enable

# Enable via Group Policy (requires Windows Event Log ID 4688 + 4689)
# Computer Configuration > Windows Settings > Security Settings > 
# Advanced Audit Policy Configuration > Detailed Tracking
```

### Reduce Attack Surface

- Disable or restrict PowerShell v2 (lacks AMSI): `Disable-WindowsOptionalFeature -Online -FeatureName MicrosoftWindowsPowerShellV2Root`
- Enable PowerShell Constrained Language Mode for non-admin users
- Block macro execution in Office documents from the internet via GPO
- Implement application allowlisting via [[AppLocker]] or Windows Defender Application Control (WDAC)

---

## Lab / Hands-On

### Lab 1: Generate and Observe Behavioral Telemetry

Set up a Windows VM with Sysmon (System Monitor) to capture rich behavioral telemetry:

```powershell
# Download Sysmon
Invoke-WebRequest -Uri https://download.sysinternals.com/files/Sysmon.zip -OutFile Sysmon.zip
Expand-Archive Sysmon.zip

# Deploy with SwiftOnSecurity config (comprehensive behavioral rules)
Invoke-WebRequest -Uri https://raw.githubusercontent.com/SwiftOnSecurity/sysmon-config/master/sysmonconfig-export.xml -OutFile sysmon.xml
.\Sysmon64.exe -accepteula -i sysmon.xml

# View events in real time
Get-WinEvent -LogName "Microsoft-Windows-Sysmon/Operational" -MaxEvents 50 | 
    Where-Object {$_.Id -eq 1} |  # Event ID 1 = ProcessCreate
    Format-List TimeCreated, Message
```

### Lab 2: Trigger Behavioral Alerts with Atomic Red Team

[[Atomic Red Team]] provides safe, reproducible test cases mapped to ATT&CK techniques:

```powershell
# Install Atomic Red