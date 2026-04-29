# FortiNDR

## What it is
Think of it as a security guard dog that has memorized the normal "scent" of your entire network — the moment traffic smells wrong, it alerts. FortiNDR (Network Detection and Response) is Fortinet's AI-driven platform that continuously monitors network traffic to detect anomalous behavior, lateral movement, and threats that bypass traditional signature-based tools. It combines deep packet inspection, machine learning, and behavioral analysis to identify threats in real time.

## Why it matters
During a ransomware campaign, attackers often spend weeks performing reconnaissance and lateral movement before detonating their payload — traditional firewalls and antivirus miss this "quiet phase." FortiNDR's behavioral models can detect the abnormal SMB traffic patterns and unusual credential usage that signal an attacker moving through the network, enabling defenders to isolate compromised hosts before encryption begins. This is exactly the kind of detection gap that CySA+ exam scenarios test.

## Key facts
- FortiNDR uses **AI/ML-based behavioral baselines** rather than static signatures, making it effective against zero-day and fileless malware
- It performs **full packet capture and flow analysis**, enabling retrospective investigation after an alert triggers
- Integrates natively with the **Fortinet Security Fabric**, correlating NDR findings with FortiGate, FortiSIEM, and FortiSOAR for automated response
- Classified as an **NDR solution** — distinct from EDR (endpoint-focused) and SIEM (log-aggregation focused); NDR lives on the wire
- Detects **command-and-control (C2) beaconing**, encrypted malware traffic, and east-west lateral movement that perimeter tools cannot see

## Related concepts
[[Network Detection and Response (NDR)]] [[Behavioral Analytics]] [[Lateral Movement]] [[Security Information and Event Management (SIEM)]] [[Threat Hunting]]