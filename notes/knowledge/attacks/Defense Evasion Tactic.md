# Defense Evasion Tactic

## What it is
Like a burglar who wipes fingerprints, disables security cameras, and wears a uniform matching the building's maintenance staff — defense evasion is an attacker's deliberate effort to avoid detection while operating inside a target environment. Formally, it is MITRE ATT&CK Tactic TA0005, encompassing techniques attackers use to bypass security controls, hide malicious activity, and remain undetected throughout the attack lifecycle.

## Why it matters
During the 2020 SolarWinds supply chain attack, threat actors injected a backdoor into signed software updates, making malicious traffic blend with legitimate Orion product communications — a textbook defense evasion move that kept the intrusion hidden for nearly nine months. Defenders who understand this tactic know to monitor for anomalies like process injection, unusual parent-child process relationships, and log tampering even when no traditional malware signatures trigger.

## Key facts
- **Common techniques include:** disabling security tools, obfuscating code, masquerading (renaming malware as legitimate processes), timestomping, and log deletion
- **Indicator of Compromise (IoC) suppression** is a primary goal — attackers delete Event Logs (e.g., `wevtutil cl System`) to erase forensic trails
- **Living off the Land (LotL)** attacks use built-in tools like PowerShell, WMI, and certutil to evade signature-based AV detection
- **Rootkits** operate at ring-0 (kernel level) specifically to hide processes, files, and network connections from the OS and security tools
- On the **MITRE ATT&CK framework**, TA0005 contains the largest number of sub-techniques of any tactic, reflecting how critical evasion is to attackers

## Related concepts
[[MITRE ATT&CK Framework]] [[Indicator of Compromise]] [[Living off the Land Attack]] [[Rootkit]] [[Log Management and SIEM]]