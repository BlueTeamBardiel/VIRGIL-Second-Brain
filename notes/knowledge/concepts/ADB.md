# ADB

## What it is
Think of ADB as a remote control for your Android phone that works over a cable or network—it lets a developer (or attacker) issue commands directly to the device's operating system. Android Debug Bridge is a command-line tool that communicates with an Android device or emulator, enabling shell access, file transfers, app installation, and system-level operations when debugging is enabled.

## Why it matters
An attacker who gains access to an unlocked ADB port can install malware, exfiltrate data, or modify system settings without the owner's knowledge. Real-world scenario: a compromised USB cable at an airport charges your phone while simultaneously running `adb install malicious.apk` in the background. This is why USB Restricted Mode and disabling USB debugging by default exist as defenses.

## Key facts
- ADB requires explicit "USB debugging" enablement on the device, but this setting persists across reboots unless reset
- Default ADB listens on TCP port 5037 on the host machine; network ADB (`adb tcpip 5555`) moves this to the device itself
- Successful `adb connect` doesn't always require authentication if the device has previously authorized the connection fingerprint
- `adb shell` grants shell access with permissions of the `shell` user (usually a privileged, non-root account)
- Physical access + enabled debugging = full device compromise; logical attacks require prior authorization or USB Restricted Mode bypass

## Related concepts
[[USB Restricted Mode]] [[Android bootloader unlock]] [[Fastboot]] [[Mobile threat modeling]] [[Physical access attacks]]