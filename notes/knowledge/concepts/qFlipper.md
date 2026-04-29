# qFlipper

## What it is
Think of it as iTunes for a Swiss Army knife that speaks every wireless protocol — it's the official desktop companion app for the Flipper Zero device. qFlipper manages firmware updates, file transfers, and device configuration for the Flipper Zero multi-tool, providing a GUI and CLI interface across Windows, macOS, and Linux.

## Why it matters
In penetration testing and red team engagements, operators use qFlipper to push custom firmware (like Unleashed or RogueMaster) onto a Flipper Zero, unlocking transmission capabilities that stock firmware restricts — such as extended Sub-GHz frequency ranges used to clone garage door openers or TPMS sensors. Defenders and forensic analysts may encounter qFlipper artifacts (logs, device backups, `.fap` plugin files) on suspect machines, linking a user to hardware-based wireless attacks.

## Key facts
- qFlipper is open-source, maintained by Flipper Devices Inc., and available on GitHub — meaning its codebase can be audited but also studied by adversaries
- It communicates with Flipper Zero over USB using a serial protocol, allowing full file system access to the device's SD card
- Custom firmware installation via qFlipper can bypass regional RF transmission limits, making it relevant to FCC violation scenarios and unauthorized signal transmission under 47 U.S.C. § 333
- The `.qflipper` backup format packages device settings, saved signals, and scripts — a forensic goldmine if recovered during incident response
- qFlipper supports scripting via CLI (`qFlipper -c`), enabling automated deployment in red team toolchains

## Related concepts
[[Flipper Zero]] [[Sub-GHz Radio Attacks]] [[Firmware Modification]] [[RF Signal Replay Attack]] [[Hardware Hacking]]