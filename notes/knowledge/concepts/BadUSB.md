# BadUSB

## What it is
Imagine a wolf wearing a sheep costume so convincing it fools even the farmer's DNA test — that's BadUSB. It's an attack where a USB device's firmware is reprogrammed to masquerade as a trusted device type (like a keyboard or network adapter), causing the host OS to execute malicious commands without any files ever touching the disk.

## Why it matters
In 2014, researchers Karsten Nohl and Jakob Lell demonstrated that a standard USB thumb drive could be reflashed to impersonate a USB keyboard and silently type attack commands the moment it was plugged in. Because the attack lives in firmware — not in files — traditional antivirus and endpoint detection tools are essentially blind to it, making it a favorite technique for physical red team engagements and nation-state actors targeting air-gapped systems.

## Key facts
- BadUSB exploits the fact that USB controllers contain reprogrammable microcontrollers; the OS trusts whatever device class the firmware declares
- A malicious USB can simultaneously appear as multiple device types (e.g., both a storage drive AND a HID keyboard)
- Because no malicious file is written to disk initially, signature-based AV cannot detect the attack vector
- Defenses include USB device whitelisting (allowing only pre-approved device IDs), disabling USB ports via Group Policy, and using USB condoms (data-blocking adapters)
- The attack requires physical access, making it relevant to physical security controls — a domain tested on Security+ (Domain 2: Architecture and Design / physical security)

## Related concepts
[[HID Spoofing]] [[Rubber Ducky]] [[Supply Chain Attack]] [[Physical Security Controls]] [[Endpoint Hardening]]