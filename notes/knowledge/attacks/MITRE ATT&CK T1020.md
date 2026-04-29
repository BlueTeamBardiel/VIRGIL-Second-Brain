# MITRE ATT&CK T1020

## What it is
Like a spy who mails stolen documents out of a building piece by piece in ordinary-looking envelopes, automated exfiltration refers to adversaries using scripts or malware to automatically collect and transfer data to attacker-controlled infrastructure — without manual intervention after initial setup. It is classified under the Exfiltration tactic and describes the use of automated mechanisms to move data out of a compromised environment.

## Why it matters
During the SolarWinds SUNBURST campaign, malware automatically exfiltrated collected network reconnaissance data to attacker C2 infrastructure using scheduled, throttled transfers — designed to blend into normal traffic patterns. Defenders who monitor only for large, sudden data transfers miss this technique entirely; behavioral baselines and DLP rules must account for low-and-slow automated exfiltration patterns.

## Key facts
- T1020 specifically covers **automated** transfer mechanisms — distinguishing it from manual exfiltration performed interactively by an operator
- Attackers commonly use **scheduled tasks, cron jobs, or built-in malware timers** to trigger exfiltration at low-traffic periods (e.g., 2–4 AM)
- Data is frequently **staged first** (T1074) before automated exfiltration begins, reducing dwell-time exposure during the actual transfer
- Detection relies heavily on **network flow analysis** — watching for consistent, periodic outbound connections to unusual external IPs
- Automated exfiltration often uses **legitimate protocols** (HTTP/S, DNS, SMTP) to evade port-based firewall rules

## Related concepts
[[Data Staged T1074]] [[Exfiltration Over C2 Channel T1041]] [[Scheduled Task T1053]]