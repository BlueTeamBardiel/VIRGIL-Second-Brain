# Removable Media

## What it is
Like a Trojan horse wheeled through the city gates, a USB drive bypasses perimeter defenses by exploiting the most trusted entry point — a human being. Removable media refers to portable storage devices (USB drives, SD cards, optical discs, external hard drives) that can be physically connected to a system to transfer data outside normal network channels.

## Why it matters
In 2010, Stuxnet — arguably the most sophisticated cyberweapon ever deployed — was delivered into Iran's air-gapped nuclear facility via infected USB drives handed to unsuspecting contractors. This demonstrates that removable media attacks specifically target environments where network-based intrusion is impossible, making physical security controls as critical as technical ones.

## Key facts
- **Baiting attacks** involve intentionally dropping malicious USB drives in parking lots or lobbies, exploiting human curiosity — studies show 45–98% of dropped drives get plugged in
- **Data exfiltration** via removable media bypasses DLP (Data Loss Prevention) tools that only monitor network traffic, requiring endpoint agents to detect it
- **USB Rubber Ducky** and similar HID (Human Interface Device) attack tools emulate keyboards, executing pre-programmed keystrokes within seconds of insertion — no malware install needed
- **Group Policy** in Windows environments can disable AutoRun/AutoPlay and block removable media access entirely; endpoint controls like Windows Defender Device Control enforce this at scale
- **Chain of custody** policies require logging and tracking all removable media in classified or regulated environments (PCI-DSS, HIPAA) to satisfy audit requirements

## Related concepts
[[Social Engineering]] [[Data Loss Prevention]] [[Air-Gapped Networks]] [[Endpoint Security]] [[Supply Chain Attacks]]