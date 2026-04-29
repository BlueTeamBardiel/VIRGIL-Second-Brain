# Revenge RAT

## What it is
Think of it as a Swiss Army knife handed to a burglar — except the burglar operates entirely from their couch. Revenge RAT (Remote Access Trojan) is a freely available, open-source malware tool written in C# that grants attackers full remote control over a victim's Windows machine, including webcam access, keylogging, file management, and command execution. Its low barrier to entry makes it a favorite among low-sophistication threat actors.

## Why it matters
In 2019, Revenge RAT was deployed in targeted spear-phishing campaigns against organizations in the aviation, aerospace, and government sectors, delivered via malicious email attachments disguised as legitimate documents. Defenders identified it through anomalous outbound C2 traffic on non-standard ports and suspicious registry persistence keys. The case illustrated how commodity malware can be weaponized in targeted attacks — blurring the line between script kiddies and nation-state TTPs.

## Key facts
- Distributed for free on hacking forums since ~2016, making attribution difficult due to wide adoption across threat actor skill levels
- Achieves persistence via **Windows Registry Run keys** (`HKCU\Software\Microsoft\Windows\CurrentVersion\Run`) — a classic indicator to hunt for during forensic triage
- Uses **custom C2 communication** over configurable ports (commonly 4444, 5555), often blending into noisy traffic to evade firewall rules
- Capabilities include: keylogging, screenshot capture, webcam/microphone hijacking, reverse shell, password harvesting, and cryptocurrency clipboard hijacking
- Commonly delivered via **spear-phishing with malicious VBS or PowerShell droppers** embedded in Office documents using macro execution

## Related concepts
[[Remote Access Trojan]] [[Command and Control (C2)]] [[Spear Phishing]] [[Persistence Mechanisms]] [[Indicators of Compromise (IOCs)]]