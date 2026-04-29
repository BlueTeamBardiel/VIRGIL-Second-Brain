# Bash Bunny

## What it is
Think of it as a Swiss Army knife disguised as a USB thumb drive — it looks like innocent flash storage but is actually a programmable multi-attack platform. Precisely, the Bash Bunny is a Hak5 hardware attack tool that emulates multiple USB device types (keyboard, Ethernet adapter, serial device, storage) simultaneously, executing scripted payloads the moment it's plugged in. Its payloads are written in a simple scripting language and can chain attacks in seconds.

## Why it matters
An attacker with brief physical access — say, during a tailgating incident or an unlocked workstation left unattended at a conference — can plug in a Bash Bunny and exfiltrate credentials, install a reverse shell, or bypass network controls in under 30 seconds. Because the OS recognizes it as a trusted HID (Human Interface Device) keyboard, traditional endpoint security tools often fail to flag the input as malicious.

## Key facts
- **Multi-mode emulation:** Can simultaneously present as a USB keyboard (HID), mass storage device, RNDIS/CDC Ethernet adapter, and serial console — making it far more versatile than a simple Rubber Ducky.
- **Attack speed:** Pre-loaded payloads execute automatically on plug-in; credential harvesting attacks against Windows can complete in under 60 seconds.
- **Physical access threat:** Classified as a physical/insider threat vector — relevant to CySA+ scenarios involving endpoint and physical security controls.
- **Defense:** USB port locking (via Group Policy or endpoint DLP tools), physical port blockers, and disabling AutoRun/AutoPlay mitigate Bash Bunny attacks.
- **Payload language:** Uses a Bash-based scripting syntax with switches (ATTACKMODE) to toggle between device emulation modes mid-execution.

## Related concepts
[[Rubber Ducky]] [[HID Spoofing]] [[Physical Security Controls]] [[USB Drop Attack]] [[Endpoint Detection and Response]]