# nRF Connect

## What it is
Think of it as a universal TV remote that can discover, speak to, and control any Bluetooth Low Energy (BLE) device in range — except it shows you the raw signal protocol instead of hiding it. nRF Connect is a Nordic Semiconductor mobile and desktop application used to scan for BLE devices, inspect their GATT (Generic Attribute Profile) services and characteristics, and send/receive raw BLE packets.

## Why it matters
During a penetration test of a smart lock ecosystem, a tester uses nRF Connect to enumerate all advertised BLE services on the lock, discovers an unprotected "unlock" characteristic with no authentication requirement, and writes a single byte to it — opening the door without any credentials. This exact attack class has been documented against consumer smart locks, medical devices, and industrial sensors, making BLE reconnaissance a real-world attack surface that defenders must harden.

## Key facts
- nRF Connect can read, write, and subscribe to **GATT characteristics** — the fundamental data exchange units in BLE — making it a first-stop tool for BLE attack surface mapping.
- It reveals **UUIDs** of services and characteristics, which can be cross-referenced against the Bluetooth SIG registry to identify device type and potential weaknesses.
- Devices advertising with **no pairing requirement** (Security Mode 1, Level 1) are immediately exploitable and visually obvious in nRF Connect scans.
- The desktop version supports **packet sniffing** when paired with a Nordic Sniffer dongle (nRF52840), enabling passive capture of BLE traffic for offline analysis.
- Used in **BLE fuzzing** workflows: testers write unexpected values to writable characteristics to trigger crashes or unintended behavior in embedded firmware.

## Related concepts
[[Bluetooth Low Energy (BLE)]] [[GATT Protocol]] [[Wireless Reconnaissance]] [[Protocol Fuzzing]] [[IoT Security]]