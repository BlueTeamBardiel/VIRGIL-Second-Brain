# USB host

## What it is
Think of a USB host like a power outlet with a brain — it's the device that controls the conversation, supplies power, and decides who gets to talk. Precisely, a USB host is the controller (typically a computer or charging station) that manages all communication on a USB bus, enumerating connected devices, allocating bandwidth, and providing up to 500mA–900mA of power depending on the USB version.

## Why it matters
BadUSB attacks exploit the host's blind trust in connected devices — a malicious USB stick can reprogram its firmware to impersonate a keyboard, then inject keystrokes that download malware within seconds of being plugged in. Defenders counter this with USB device control policies (e.g., whitelisting by hardware ID via Windows Group Policy or endpoint DLP tools) and physical port blockers in high-security environments. The host's automatic device enumeration is the attack surface — it happens before any user interaction.

## Key facts
- A USB host initiates **all** transactions; peripheral devices cannot transmit without being polled first — this is why rogue devices must masquerade as legitimate device classes (HID, CDC) to get traffic
- USB enumeration assigns a **device address (1–127)** and queries device descriptors — malicious firmware manipulates these descriptors to claim trusted device types
- **USB Armory** and **Rubber Ducky** are real-world tools that abuse host enumeration to emulate keyboards or network adapters
- The host controller operates at the OS driver level — compromising the USB host stack can lead to **kernel-level privilege escalation** (CVE-2019-0542 is a historic example in Hyper-V's USB stack)
- Security+ expects you to know that **disabling unused USB ports** and using **endpoint protection policies** are compensating controls against juice jacking and BadUSB

## Related concepts
[[BadUSB]] [[Device Enumeration]] [[USB Rubber Ducky]] [[Endpoint Security]] [[HID Attack]]