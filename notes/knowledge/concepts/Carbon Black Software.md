# Carbon Black Software

## What it is
Think of it like a flight data recorder for every process on your endpoint — not just logging crashes, but capturing every takeoff, maneuver, and landing in real time. Carbon Black (now VMware Carbon Black) is an Endpoint Detection and Response (EDR) platform that continuously records process activity, file modifications, network connections, and registry changes across endpoints to enable threat hunting and incident response.

## Why it matters
During a ransomware investigation, a security analyst using Carbon Black can replay the exact execution chain — identifying that a malicious macro in a Word document spawned PowerShell, which downloaded a payload, which then began encrypting files. Without this continuous telemetry, forensic investigators are left guessing from incomplete logs and memory snapshots, dramatically slowing response time and root cause analysis.

## Key facts
- Carbon Black uses a **streaming prevention model**, analyzing behavioral patterns in real time rather than relying solely on signature-based detection — critical for catching zero-day threats
- It maintains a **process tree** that maps parent-child relationships between processes, making lateral movement and fileless malware attacks visible
- Carbon Black CB Response (now Enterprise EDR) stores telemetry data centrally, enabling **retrospective detection** — finding threats using new IOCs against historical data
- The platform integrates with **SIEM tools** (like Splunk) and threat intelligence feeds via open APIs, supporting Security Operations Center (SOC) workflows
- Carbon Black is commonly tested in **CySA+** scenarios involving behavioral analysis, threat hunting methodology, and EDR tool capabilities

## Related concepts
[[Endpoint Detection and Response]] [[Threat Hunting]] [[Behavioral Analysis]] [[SIEM]] [[Indicators of Compromise]]