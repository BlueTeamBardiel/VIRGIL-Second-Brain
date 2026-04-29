# Impair Defenses

## What it is
Like a burglar cutting the phone line and spray-painting security cameras before breaking in, attackers systematically disable or degrade the tools meant to catch them. Impair Defenses (MITRE ATT&CK T1562) refers to adversary techniques that weaken or disable security controls — including antivirus, firewalls, logging, and EDR solutions — to reduce detection probability and extend dwell time.

## Why it matters
During the 2020 SolarWinds breach, attackers disabled Windows Defender on compromised hosts and tampered with audit log settings to prevent forensic reconstruction of their activity. This gave them months of undetected access across thousands of networks — illustrating that the most dangerous threat isn't the one that bypasses your defenses, it's the one that *turns them off*.

## Key facts
- **Sub-techniques include:** disabling Windows Event Logging (T1562.002), tampering with host-based firewalls (T1562.004), disabling or modifying cloud logging (T1562.008), and killing security software processes (T1562.001)
- **Common attacker move:** using `net stop` or `sc stop` commands to terminate AV/EDR services, or modifying registry keys like `HKLM\SOFTWARE\Policies\Microsoft\Windows Defender`
- **Detection signal:** sudden gaps in log data, EventID 7045 (new service installed) or EventID 4719 (audit policy changed) are red flags indicating tampering
- **Defense:** use tamper-protected EDR solutions, monitor for Event Log service stops, and apply least privilege so standard users cannot modify security tooling
- **Exam relevance:** CySA+ expects you to recognize log gaps and disabled services as indicators of active compromise, not just misconfigurations

## Related concepts
[[Defense Evasion]] [[Log Tampering]] [[Endpoint Detection and Response]] [[Privilege Escalation]] [[Indicator Removal]]