# nRF Connect for Desktop

## What it is
Think of it as a Swiss Army knife for Bluetooth Low Energy (BLE) — a graphical workbench sitting on your laptop that lets you probe, sniff, and manipulate wireless protocols without soldering a single wire. Precisely, nRF Connect for Desktop is an open-source application suite developed by Nordic Semiconductor that provides tools for scanning, connecting to, and debugging BLE and other 2.4 GHz wireless devices using compatible USB dongles (like the nRF52840).

## Why it matters
During a physical penetration test of a smart lock manufacturer, a security researcher used nRF Connect to enumerate BLE advertisement packets and discovered that door locks were broadcasting their device identifiers in plaintext — no authentication required to replay the unlock command. This directly maps to real-world IoT attack surfaces where BLE misconfigurations enable unauthorized access to physical security systems, medical devices, and industrial sensors.

## Key facts
- Requires a **compatible Nordic dongle** (e.g., nRF52840 DK or USB dongle) to operate as a BLE sniffer/analyzer — it is hardware-dependent
- The **Bluetooth Low Energy app** within nRF Connect can perform **active scanning**, read GATT (Generic Attribute Profile) services, and write characteristic values — enabling both reconnaissance and fuzzing
- BLE sniffing via nRF Connect captures **advertisement packets on channels 37, 38, and 39**, the three dedicated broadcast channels
- Used in conjunction with **Wireshark** (via the nRF Sniffer plugin), raw BLE packets can be dissected at the protocol layer
- Relevant to **CWE-319** (Cleartext Transmission of Sensitive Information) when BLE devices expose unencrypted data discoverable through this toolset

## Related concepts
[[Bluetooth Low Energy Security]] [[GATT Protocol]] [[Wireless Reconnaissance]] [[IoT Attack Surface]] [[Wireshark]]