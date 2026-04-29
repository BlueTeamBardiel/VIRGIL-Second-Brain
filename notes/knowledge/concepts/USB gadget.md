# USB gadget

## What it is
Think of a USB gadget like an actor who can play any role — the same physical device can present itself to a host computer as a keyboard, network card, storage drive, or serial port, switching costumes entirely in software. In Linux, the USB gadget framework is a kernel subsystem that allows a device (like a Raspberry Pi or microcontroller) to *act as* a USB peripheral rather than a USB host, fully controlling what it advertises to the connected machine.

## Why it matters
The BadUSB attack exploits this principle directly: a compromised USB flash drive reprograms its controller firmware to also enumerate as a USB keyboard, then silently types malicious commands the moment it's plugged in. Because the operating system trusts Human Interface Devices implicitly — no driver prompt, no permission dialog — the attack bypasses endpoint detection that watches for file-based threats. Defenders counter this with USB device whitelisting policies (e.g., Windows Defender Device Control) that restrict devices by class, vendor ID, and product ID.

## Key facts
- USB gadget devices use **Device Descriptor fields** (Vendor ID, Product ID, Device Class) to announce their identity — all of which can be spoofed in firmware
- The **USB Device Class 0x03 (HID)** is the most abused class in attacks because keyboards/mice are trusted automatically by all major OSes
- Tools like **Rubber Ducky** (Hak5) and **Facedancer** weaponize the gadget framework for penetration testing and fuzzing
- Linux gadget framework lives in `/sys/kernel/config/usb_gadget/` and can be reconfigured at runtime without reflashing hardware
- **USBGuard** is a Linux daemon that enforces USB device authorization policies based on device attributes, blocking unauthorized gadget impersonation

## Related concepts
[[BadUSB]] [[HID Attack]] [[USB Device Whitelisting]] [[Rubber Ducky]] [[Endpoint Protection]]