# Replication Through Removable Media

## What it is
Like a biological virus hitching a ride on a handshake, malware uses USB drives, SD cards, or external hard drives as physical vectors to jump across air gaps and network boundaries. It is the technique (MITRE ATT&CK T1091) where adversaries copy malicious payloads onto removable media so that when the device is plugged into a new host, the malware auto-executes or waits for a user to trigger it.

## Why it matters
Stuxnet — arguably the most sophisticated cyberweapon ever deployed — used this exact technique to breach Iran's air-gapped Natanz nuclear facility. Engineers unknowingly carried infected USB drives inside a security perimeter that had zero internet connectivity, proving that physical media can defeat even the most hardened network defenses.

## Key facts
- **MITRE ATT&CK T1091** specifically covers replication through removable media as both an initial access and lateral movement technique.
- Windows **AutoRun/AutoPlay** was the primary exploitation mechanism historically; Microsoft disabled AutoRun by default starting with Windows 7 SP1 to reduce this attack surface.
- Malware can write itself to removable media silently using APIs like `CreateFile()` and modify the **autorun.inf** file to trigger execution on insertion.
- Defenders should enforce **Group Policy** settings (`NoDriveTypeAutoRun`) and use endpoint controls to block or audit USB device usage (e.g., via Windows Defender Device Control or third-party DLP tools).
- This technique is particularly dangerous in **OT/ICS environments** where air-gapping is assumed to provide security but removable media is still operationally necessary.

## Related concepts
[[Air Gap]] [[Initial Access]] [[Lateral Movement]] [[AutoRun Exploitation]] [[Data Loss Prevention]]