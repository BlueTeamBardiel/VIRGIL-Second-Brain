# HIPS

## What it is
Like a bouncer who doesn't just check a guest list but watches *how* people behave on the dance floor and ejects anyone throwing punches — regardless of whether they're on a known troublemakers list. A Host-based Intrusion Prevention System (HIPS) monitors activity directly on an endpoint, analyzing process behavior, system calls, and file access in real time, then actively *blocks* malicious activity rather than merely alerting on it.

## Why it matters
During a fileless malware attack — where an adversary uses PowerShell to inject shellcode directly into memory — there's no malicious file for antivirus to scan. A properly configured HIPS detects the anomalous behavior of a legitimate process (like `powershell.exe`) making suspicious API calls or spawning unexpected child processes, and terminates it before the payload executes. This is precisely how endpoint detection and response (EDR) tools stopped many Living-off-the-Land (LotL) attacks in the 2020 SolarWinds campaign aftermath.

## Key facts
- HIPS uses both **signature-based** and **behavioral/anomaly-based** detection; behavioral detection is what catches zero-days
- Unlike HIDS (Host-based Intrusion *Detection* System), HIPS takes **active blocking action** — it can terminate processes, quarantine files, or block network connections
- HIPS operates at the **kernel level**, hooking system calls to intercept malicious activity before it completes
- False positives are a major operational challenge — aggressive HIPS policies can block legitimate software and cause outages
- HIPS is typically integrated into modern **EDR platforms** (e.g., CrowdStrike Falcon, Microsoft Defender for Endpoint) rather than existing as standalone products
- On Security+/CySA+: HIPS = prevention (blocks); HIDS = detection only (alerts)

## Related concepts
[[HIDS]] [[EDR]] [[Behavioral Analysis]] [[Anomaly-Based Detection]] [[Fileless Malware]]