# TCP port 5555

## What it is
Think of it as leaving a master key under the doormat of an Android device — Android Debug Bridge (ADB) listens on TCP port 5555 when wireless debugging is enabled, giving any connecting client full shell-level control over the device. Precisely, ADB is a developer protocol that allows command execution, file transfer, and app installation on Android devices over USB or TCP/IP.

## Why it matters
In 2018, a cryptomining worm called "ADB.Miner" scanned the internet for exposed port 5555 on Android devices (including smart TVs and set-top boxes), connected without authentication, and installed Monero mining malware — infecting hundreds of thousands of devices within days. Defenders should block port 5555 at network perimeters and audit IoT/Android device configurations to ensure wireless ADB is disabled in production environments.

## Key facts
- ADB over TCP requires **no authentication by default** on many older Android versions — connection equals root-level access
- Port 5555 is also used by **Amazon Fire TV**, Android emulators (like Android Studio's AVD), and various embedded Android IoT devices
- The attack surface expands dramatically in corporate environments deploying Android kiosks, digital signage, or BYOD policies without MDM enforcement
- Shodan regularly indexes thousands of **publicly exposed ADB instances** on port 5555, making it a prime target for automated scanning
- Remediation includes disabling ADB wirelessly via `adb disconnect`, enforcing **Mobile Device Management (MDM)** policies, and applying network segmentation for IoT devices

## Related concepts
[[Android Debug Bridge (ADB)]] [[IoT Security]] [[Mobile Device Management (MDM)]] [[Unauthorized Remote Access]] [[Network Segmentation]]