# DuckyScript

## What it is
Think of it as a stage director's script for a puppet actor — except the puppet is a USB device pretending to be a keyboard, and every line it "speaks" is a keystroke injected into your computer. DuckyScript is the scripting language used to program USB Rubber Ducky devices (by Hak5), enabling automated keystroke injection attacks through a simple, human-readable syntax. Commands like `DELAY`, `STRING`, and `ENTER` define precisely what keystrokes the device fires and when.

## Why it matters
An attacker can walk into an office, plug a Rubber Ducky into an unlocked workstation, and within 15 seconds have it execute a PowerShell reverse shell payload — all before walking away casually. Because the OS sees a trusted HID (Human Interface Device), application whitelisting and most endpoint defenses never flag the input. This makes physical access scenarios — tailgating, insider threats, evil maid attacks — significantly more dangerous.

## Key facts
- DuckyScript payloads execute at ~1000 keystrokes per second, far faster than human typing, making manual interruption nearly impossible
- Rubber Ducky devices are recognized as standard keyboards (USB HID class), so they bypass USB device restrictions that block storage drives
- Common payload patterns include opening `cmd.exe` or PowerShell, downloading a remote script via `certutil` or `curl`, and executing it
- `DELAY` commands (in milliseconds) are critical — too fast and the OS doesn't register keystrokes; too slow and a user may notice
- Defenses include disabling USB ports via Group Policy, USB port blockers, and endpoint solutions that detect abnormal keystroke velocity

## Related concepts
[[USB HID Attack]] [[Keystroke Injection]] [[Physical Security Controls]] [[Rubber Ducky]] [[PowerShell Execution Policy]]