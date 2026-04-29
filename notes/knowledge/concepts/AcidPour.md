# AcidPour

## What it is
Like a more aggressive cousin of a wrecking ball that also learned to pick locks, AcidPour is a destructive wiper malware variant that not only erases data but actively targets the firmware and storage controllers of embedded Linux devices. It is an evolution of the AcidRain wiper, expanded to attack a broader range of architectures including x86 and UBI (Unsorted Block Image) flash storage — the type found in routers, modems, and industrial control systems.

## Why it matters
In March 2024, AcidPour was discovered targeting Ukrainian telecommunications infrastructure, rendering devices permanently inoperable by wiping flash memory at a level that survives reboots and reinstallation attempts. Unlike ransomware, there is no negotiation — the goal is purely destructive denial of service at a national infrastructure scale, making recovery require physical hardware replacement rather than a decryption key.

## Key facts
- AcidPour targets Linux-based embedded devices, specifically attacking NAND/NOR flash via UBI filesystem destruction — making it uniquely dangerous to IoT and telecom equipment
- It is attributed to Sandworm, a Russian GRU-affiliated APT group known for destructive cyberattacks aligned with military operations
- Unlike ransomware, AcidPour has **no monetization mechanism** — it is a pure wiper, classified as a destructive malware threat
- AcidPour iterates through device paths (e.g., `/dev/dm-*`, `/dev/ubi*`) and overwrites them with null bytes, destroying both data and filesystem structure
- Detection relies heavily on behavioral analysis (unexpected mass write operations to block devices) since signatures may not catch novel variants

## Related concepts
[[AcidRain]] [[Wiper Malware]] [[Sandworm APT]] [[Destructive Malware]] [[Industrial Control System Security]]