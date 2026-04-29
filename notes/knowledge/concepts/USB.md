# USB

## What it is
Like a spare key you hand to a stranger hoping they'll only open the front door — USB is a universal hardware interface that grants direct, low-level access to a system the moment something is plugged in. Precisely, USB (Universal Serial Bus) is a standardized plug-and-play communication protocol that allows peripheral devices to enumerate and interact with a host system, often with minimal authentication.

## Why it matters
In 2010, the Stuxnet worm spread to air-gapped Iranian nuclear facilities almost certainly via infected USB drives carried by unwitting insiders — proving that physical isolation means nothing if USB ports are open. Defenders respond by disabling USB ports in BIOS/UEFI, applying Group Policy to block unauthorized storage devices, or using endpoint DLP tools that whitelist specific device hardware IDs.

## Key facts
- **BadUSB** attacks reprogram a USB device's firmware to impersonate a keyboard or network adapter, bypassing signature-based malware detection entirely
- **Rubber Ducky** is a commercial USB attack tool that masquerades as a keyboard and can execute a full keystroke payload in seconds
- USB drop attacks exploit human curiosity — studies show employees plug in found drives at high rates (~50% in parking lot experiments)
- USB devices enumerate with a Vendor ID (VID) and Product ID (PID); whitelisting by these values is a common but spoofable control
- Disabling USB ports via **Group Policy Object (GPO)** (`HKLM\SYSTEM\CurrentControlSet\Services\USBSTOR`) is a testable Windows hardening technique

## Related concepts
[[BadUSB]] [[Physical Security]] [[Endpoint Detection and Response]] [[Air Gap]] [[Data Loss Prevention]]