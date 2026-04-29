# TrickBot

## What it is
Think of TrickBot like a master skeleton key that a locksmith designed for one door but then handed to a criminal gang who duplicated it for every lock in the city. Originally a banking trojan derived from the Dyre malware family (2016), TrickBot evolved into a full-featured, modular malware platform capable of credential theft, network reconnaissance, lateral movement, and ransomware delivery.

## Why it matters
In numerous enterprise breaches, TrickBot served as the critical bridge between an initial phishing email and a devastating Ryuk ransomware deployment. Attackers would drop TrickBot via a malicious Word macro, let its modules harvest Active Directory credentials and map the network over days or weeks, then hand off to Ryuk operators for maximum impact — a tactic that paralyzed multiple hospitals during the COVID-19 pandemic in 2020.

## Key facts
- **Modular architecture**: TrickBot uses swappable plugin modules for specific tasks — `systeminfo` for reconnaissance, `pwgrab` for credential harvesting, `networkdll` for lateral movement via SMB, and `shareDll` for worm-like propagation.
- **MaaS model**: Operated as Malware-as-a-Service by the Wizard Spider threat group, rented to other criminal actors including ransomware affiliates.
- **2020 takedown**: A joint effort by Microsoft, ESET, and US Cyber Command disrupted TrickBot's C2 infrastructure in October 2020, though the botnet rebuilt itself within weeks.
- **Credential theft vector**: TrickBot specifically targets browser-stored passwords, RDP credentials, and VNC/PuTTY configurations, making password managers and MFA critical mitigations.
- **MITRE ATT&CK relevance**: Maps to T1055 (Process Injection), T1021.002 (SMB lateral movement), and T1486 (Data Encrypted for Impact via ransomware hand-off).

## Related concepts
[[Emotet]] [[Ryuk Ransomware]] [[Malware-as-a-Service]] [[Lateral Movement]] [[Command and Control (C2)]]