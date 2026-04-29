# Installation

## What it is
Like a contractor who breaks into a building and then props open a back window for easy return visits, Installation is the phase where an attacker deploys a persistent mechanism after initial access. In the Cyber Kill Chain (Lockheed Martin), it's Phase 5: the adversary installs a backdoor, web shell, RAT, or rootkit to maintain long-term presence on the compromised system.

## Why it matters
In the 2020 SolarWinds attack, adversaries installed a trojanized DLL (SUNBURST) into the Orion software update, giving them persistent access to thousands of networks for months before detection. Detecting malicious installations early — before Command and Control is established — is the last practical opportunity to evict an attacker before the breach becomes catastrophic.

## Key facts
- Common installation artifacts include: scheduled tasks, registry Run keys (`HKCU\Software\Microsoft\Windows\CurrentVersion\Run`), services, and startup folder entries
- Web shells (e.g., China Chopper) are a common installation method on compromised web servers — they require no outbound connection to activate
- Rootkits installed at the kernel level can hide processes, files, and network connections from the OS itself, making detection extremely difficult without memory forensics
- MITRE ATT&CK maps this phase across tactics like **Persistence** (TA0003) and **Defense Evasion** — Installation is not a single technique but a goal achieved through dozens of sub-techniques
- File integrity monitoring (FIM) tools like Tripwire are specifically designed to detect unauthorized file installations by hashing critical system files

## Related concepts
[[Persistence]] [[Cyber Kill Chain]] [[Rootkits]] [[Web Shells]] [[Defense Evasion]]