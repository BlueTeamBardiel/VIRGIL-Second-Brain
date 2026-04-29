# EDR Detection

## What it is
Like a security camera with a built-in detective — not just recording footage but automatically flagging suspicious behavior in real time — Endpoint Detection and Response (EDR) is a security solution that continuously monitors endpoint activity, correlates behavioral telemetry, and enables rapid investigation and response to threats. Unlike traditional antivirus, EDR focuses on *what processes are doing* rather than just matching known malicious signatures.

## Why it matters
During the 2020 SolarWinds attack, attackers used fileless malware and legitimate system tools (living-off-the-land techniques) specifically to evade signature-based antivirus. Organizations with mature EDR solutions were able to detect anomalous SUNBURST behavior — such as unusual parent-child process relationships and suspicious outbound DNS calls — because EDR monitors behavioral patterns, not just file hashes.

## Key facts
- EDR collects telemetry across four core areas: **process execution, file modifications, network connections, and registry changes**
- Detects **living-off-the-land (LotL) attacks** by flagging abuse of legitimate tools like PowerShell, WMI, and certutil
- Uses **behavioral baselining** — deviations from normal user/process behavior trigger alerts, enabling detection of zero-days
- Most EDR platforms (CrowdStrike Falcon, Microsoft Defender for Endpoint, SentinelOne) store telemetry for **threat hunting** — retrospective investigation of past events
- EDR is a core component of **NIST 800-61** incident response: it supports the *Detection & Analysis* and *Containment* phases by providing forensic-quality event timelines

## Related concepts
[[Threat Hunting]] [[SIEM]] [[Living Off the Land]] [[Behavioral Analysis]] [[Incident Response]]