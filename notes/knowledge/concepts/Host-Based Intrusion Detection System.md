# Host-Based Intrusion Detection System

## What it is
Like a smoke detector bolted to the ceiling of a single room — it only knows what's happening in *that* room, but it knows it intimately. A Host-Based Intrusion Detection System (HIDS) is software installed directly on an endpoint that monitors system calls, log files, file integrity, and running processes to detect malicious activity on that specific machine.

## Why it matters
In the 2020 SolarWinds attack, compromised hosts were executing malicious DLL code that network-based sensors missed entirely because the traffic was legitimately encrypted. A properly tuned HIDS monitoring process creation events and DLL loads could have flagged the anomalous `SolarWinds.Orion.Core.BusinessLayer.dll` behavior before lateral movement occurred — demonstrating why endpoint-level visibility is irreplaceable.

## Key facts
- HIDS detects attacks that encrypted traffic hides from network-based tools (NIDS), making it essential for insider threats and post-exploitation activity
- Common HIDS functions include **file integrity monitoring (FIM)**, log analysis, registry monitoring (Windows), and rootkit detection
- OSSEC and Tripwire are classic exam-referenced HIDS tools; modern EDR platforms extend HIDS capabilities with response functions
- HIDS generates alerts but does **not block traffic** — detection only, unlike a Host-Based Intrusion *Prevention* System (HIPS)
- A major weakness: if an attacker gains root/SYSTEM privileges, they may disable or tamper with the HIDS agent itself — requiring agent tamper-protection and centralized log forwarding

## Related concepts
[[Network-Based Intrusion Detection System]] [[File Integrity Monitoring]] [[Endpoint Detection and Response]] [[Security Information and Event Management]]