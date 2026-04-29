# persistence mechanisms

## What it is
Like a burglar who copies your house key before leaving so they can return whenever they want, persistence mechanisms are techniques attackers use to maintain access to a compromised system across reboots, credential changes, and other interruptions. Precisely defined, persistence is any method that allows malicious code or actor access to survive system state changes without requiring re-exploitation of the initial vulnerability.

## Why it matters
During the 2020 SolarWinds supply chain attack, threat actors used scheduled tasks and modified Windows registry run keys to maintain persistent backdoor access across thousands of enterprise networks for months before detection. Defenders use tools like Autoruns (Sysinternals) and endpoint detection platforms specifically to audit persistence locations, because dwell time — the gap between compromise and detection — directly determines the blast radius of a breach.

## Key facts
- **Registry Run Keys** (`HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run`) are among the most commonly abused Windows persistence locations and are a staple of Security+ exam questions
- **Scheduled Tasks** (Windows) and **cron jobs** (Linux) allow attackers to re-execute malware at defined intervals, surviving reboots entirely
- **Boot/Pre-OS persistence** (bootkits, UEFI implants) is the most dangerous form — it survives full OS reinstalls
- **Web shells** provide server-side persistence on compromised web servers independent of the OS login mechanism
- MITRE ATT&CK catalogs persistence as Tactic **TA0003**, with over 60 documented sub-techniques including account manipulation and hijacking startup folders

## Related concepts
[[registry manipulation]] [[scheduled tasks]] [[MITRE ATT&CK framework]] [[rootkits]] [[privilege escalation]]