# Fastboot

## What it is
Think of it like a hospital emergency override key that lets technicians access critical systems by bypassing normal staff login procedures — Fastboot is a diagnostic protocol built into Android devices that allows direct communication with the bootloader before the operating system loads. It enables low-level operations such as flashing firmware, unlocking the bootloader, and modifying system partitions directly from a connected computer via USB.

## Why it matters
An attacker with brief physical access to an Android device can boot into Fastboot mode (often just by holding Volume Down + Power), and if the bootloader is unlocked, flash a malicious custom ROM that bypasses full-disk encryption and screen lock entirely — effectively owning the device without knowing the PIN. This is why bootloader lock status is a critical mobile device management (MDM) compliance check in enterprise environments.

## Key facts
- Fastboot mode runs **before the OS loads**, meaning normal Android security controls (lockscreen, SELinux, encryption) are not yet active
- The command `fastboot oem unlock` permanently unlocks the bootloader on most devices, **triggering a factory reset** as a built-in data protection measure
- An **unlocked bootloader** is a high-severity MDM compliance violation because it allows unsigned firmware to be flashed
- Fastboot is distinct from Recovery Mode — Fastboot communicates with the bootloader directly, while Recovery Mode runs a minimal environment for system repairs
- Physical access is the primary attack prerequisite; **USB Restricted Mode** and **disabling OEM unlocking** in Developer Options are key mitigations

## Related concepts
[[Android Security Model]] [[Mobile Device Management]] [[Full Disk Encryption]] [[ADB (Android Debug Bridge)]] [[Bootloader Security]]