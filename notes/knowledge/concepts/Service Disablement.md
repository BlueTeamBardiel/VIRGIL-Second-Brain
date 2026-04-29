# Service Disablement

## What it is
Like a thief cutting the phone lines before robbing a house so the alarm can't call for help, service disablement is an attacker's technique of stopping critical security or system services to weaken defenses before or during an attack. Precisely, it refers to the deliberate termination or disabling of running processes, daemons, or services — particularly security tools like antivirus, logging agents, or firewalls — to reduce detection and response capability.

## Why it matters
Ransomware families like REvil and Conti routinely disable Windows Volume Shadow Copy Service (VSS) and Windows Defender before encrypting files, eliminating both the victim's recovery mechanism and their real-time protection. Without VSS, backups stored locally are destroyed; without Defender, the encryption payload runs uncontested. This two-step pattern (disable, then detonate) is now standard ransomware tradecraft.

## Key facts
- **Common commands used:** `sc stop`, `net stop`, `taskkill /F`, and PowerShell's `Stop-Service` are frequently observed in malware scripts targeting Windows services
- **MITRE ATT&CK mapping:** Categorized under **T1489 – Service Stop**, a sub-technique within the "Impact" tactic category
- **High-value targets:** Antivirus engines, backup agents, event logging services (Windows Event Log), and EDR sensors are the most frequently disabled services in real intrusions
- **Detection signal:** Sudden termination of security services — especially in bulk or via scripted sequences — is a high-fidelity indicator of compromise (IoC)
- **Defense control:** Protecting services with tamper protection (e.g., Microsoft Defender Tamper Protection) or requiring privileged tokens to stop them raises the attacker's cost significantly

## Related concepts
[[Indicator of Compromise]] [[Defense Evasion]] [[Ransomware]] [[Log Tampering]] [[Endpoint Detection and Response]]