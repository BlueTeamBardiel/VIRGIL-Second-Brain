# HID

## What it is
Like a universal translator that lets any input device speak the same language to any operating system, HID (Human Interface Device) is a USB protocol class that standardizes how keyboards, mice, and similar peripherals communicate with computers — no custom drivers required. Any device that announces itself as HID gets trusted and loaded automatically by the OS.

## Why it matters
That automatic trust is exactly what attackers exploit with "BadUSB" attacks: a malicious USB stick reprograms its firmware to impersonate a HID keyboard, and when plugged in, the OS obediently accepts it as a trusted input device. Within seconds it can silently type out PowerShell commands to download and execute a reverse shell — no user interaction beyond the physical plug-in required.

## Key facts
- HID devices are recognized and loaded **without user approval or driver installation**, making them inherently trusted by Windows, macOS, and Linux
- The **BadUSB attack** exploits HID by reprogramming USB firmware (e.g., microcontrollers like the ATmega32U4 in a Rubber Ducky) to emulate a keyboard
- Tools like **Hak5 USB Rubber Ducky** and **O.MG Cable** use HID spoofing to deliver automated keystroke payloads in physical penetration testing
- Defending against HID attacks includes **USB port disabling**, **endpoint DLP solutions**, and **Group Policy restrictions** on unauthorized HID device enrollment
- HID attacks bypass most **antivirus and network-based defenses** because the payload is delivered as simulated keystrokes — identical to legitimate user input at the OS level

## Related concepts
[[BadUSB]] [[Physical Security]] [[USB Drop Attack]] [[Rubber Ducky]] [[Endpoint Hardening]]