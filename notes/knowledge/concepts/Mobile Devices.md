# Mobile Devices

## What it is
Like carrying a fully equipped office in your pocket that also moonlights as a GPS tracker, camera, and microphone — mobile devices are portable computing platforms (smartphones, tablets) that combine cellular, Wi-Fi, Bluetooth, and NFC radios with persistent storage, app ecosystems, and sensor arrays, creating an attack surface far larger than their physical size suggests.

## Why it matters
In 2019, attackers exploited a WhatsApp zero-day (CVE-2019-3568) to silently install NSO Group's Pegasus spyware by simply placing a missed call — no user interaction required. This demonstrates that mobile devices face the same sophisticated threat landscape as enterprise servers, yet users treat them as trusted personal tools and rarely apply security hardening.

## Key facts
- **MDM (Mobile Device Management)** enforces policies remotely: requiring PINs, encrypting storage, pushing patches, and enabling remote wipe if a device is lost or stolen
- **Sideloading** — installing apps outside official stores — bypasses vetting controls and is a primary delivery vector for mobile malware on Android
- **Containerization/Sandboxing** separates personal and corporate data on BYOD devices (e.g., Samsung Knox, Apple managed apps), preventing data leakage between environments
- **Jailbreaking (iOS) / Rooting (Android)** removes OS security controls, eliminates app sandboxing, and voids MDM enforcement — a critical red flag in enterprise environments
- **Bluetooth attacks** include Bluejacking (unsolicited messages), Bluesnarfing (unauthorized data access), and Bluebugging (full device control) — all exploiting improperly paired or discoverable devices

## Related concepts
[[Mobile Device Management]] [[BYOD Policy]] [[Application Sandboxing]] [[Bluetooth Security]] [[Zero-Day Exploits]]