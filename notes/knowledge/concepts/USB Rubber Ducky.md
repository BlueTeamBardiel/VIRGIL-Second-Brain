# USB Rubber Ducky

## What it is
Think of it like a master key disguised as a valet key — it looks like an ordinary USB thumb drive, but instead of storing files, it impersonates a keyboard and fires pre-programmed keystrokes at machine-gun speed. Precisely defined: the USB Rubber Ducky is a commercial keystroke injection tool developed by Hak5 that registers as a Human Interface Device (HID), bypassing USB storage restrictions because computers inherently trust keyboards.

## Why it matters
An attacker with 30 seconds of physical access can plug in a Rubber Ducky that silently opens PowerShell, downloads a reverse shell payload, executes it, and ejects — all before the screen saver kicks off. Defenders counter this by implementing USB port controls via Group Policy or endpoint protection tools like CrowdStrike, and by disabling HID device registration for unauthorized peripherals through device whitelisting.

## Key facts
- Operates as an **HID (Human Interface Device)**, not a storage device, so "disable USB drives" policies offer **zero protection** against it
- Payloads are written in **Ducky Script**, a simple scripting language using commands like `DELAY`, `STRING`, and `ENTER`
- Can execute hundreds of keystrokes **per second** — far faster than any human typist, completing attacks in under 60 seconds
- Represents a **physical access attack vector**, meaning it bypasses network-based controls entirely (firewalls, IDS/IPS are irrelevant)
- Mitigation strategies include **endpoint HID whitelisting**, disabling unused USB ports in BIOS/UEFI, and physical port blockers

## Related concepts
[[HID Spoofing]] [[Physical Security Controls]] [[keystroke injection]] [[BadUSB]] [[Privilege Escalation]]