# Exfiltration Over Physical Medium

## What it is
Like a bank employee sneaking customer account numbers out on a Post-it note tucked in their shoe, this technique bypasses all network monitoring by moving stolen data through the physical world. Exfiltration Over Physical Medium (MITRE ATT&CK T1052) refers to adversaries transferring data off a target system using physical carriers — USB drives, external hard drives, phones, or even printed documents — rather than network channels.

## Why it matters
The 2008 breach of classified U.S. military networks (Operation Buckshot Yankee) began when an infected USB drive was plugged into a laptop at a base in the Middle East, and data traversed air-gapped systems physically before anyone detected it. This is why the DoD temporarily banned removable media entirely — DLP tools watching network traffic are completely blind to a USB drive walking out the door.

## Key facts
- **MITRE ATT&CK T1052** covers this technique; sub-techniques include T1052.001 (Exfiltration over USB) specifically
- Air-gapped networks — systems with no internet connection — are the primary target of physical exfiltration because logical exfiltration routes don't exist
- **Data Loss Prevention (DLP)** endpoint agents can block or log USB device usage and are the primary technical countermeasure
- Insider threats are the dominant threat actor for this technique; external attackers require physical access (e.g., evil maid attacks)
- Controls include **device whitelisting** via Group Policy, disabling USB ports in BIOS/UEFI, and port blockers — purely network-based monitoring provides zero visibility here

## Related concepts
[[Data Loss Prevention]] [[Air Gap]] [[Insider Threat]] [[Removable Media Controls]] [[MITRE ATT&CK]]