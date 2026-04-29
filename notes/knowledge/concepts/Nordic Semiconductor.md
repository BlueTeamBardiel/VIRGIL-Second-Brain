# Nordic Semiconductor

## What it is
Think of Nordic Semiconductor as the tiny beating heart inside millions of wireless gadgets — the same way Intel CPUs power laptops, Nordic's nRF chips power the Bluetooth and Zigbee world of IoT. Nordic Semiconductor is a Norwegian fabless chip company specializing in ultra-low-power wireless System-on-Chip (SoC) solutions, most notably the nRF52 and nRF5340 series used in Bluetooth Low Energy (BLE), Thread, Zigbee, and 2.4 GHz proprietary protocols. Their chips appear in fitness trackers, smart locks, medical devices, and industrial sensors worldwide.

## Why it matters
An attacker targeting a smart lock running a Nordic nRF52 chip can exploit poorly implemented BLE pairing — such as "Just Works" mode — to perform a MITM attack, capturing and replaying authentication tokens to unlock a door without credentials. Security researchers have also demonstrated fault injection attacks against nRF52 devices to bypass readback protection (APPROTECT), dumping firmware that manufacturers assumed was locked. This makes Nordic chips a frequent target in hardware hacking competitions and IoT penetration tests.

## Key facts
- The **nRF52840** is one of the most widely deployed BLE SoCs; it supports BLE 5.0, Zigbee, Thread, and USB — a massive attack surface in a single package
- Nordic's **APPROTECT** (Access Port Protection) mechanism was publicly defeated in 2021 via voltage glitching, exposing locked firmware on deployed devices
- Many Nordic-based devices use **BLE "Just Works" pairing**, which offers zero MITM protection — a common finding in IoT security audits
- Nordic chips are programmed via **SWD (Serial Wire Debug)** interface — leaving debug pins exposed on a PCB is a critical hardware vulnerability
- Relevant to **CWE-1191** (On-Chip Debug and Test Interface With Improper Access Control)

## Related concepts
[[Bluetooth Low Energy Security]] [[Hardware Debug Interfaces]] [[IoT Firmware Extraction]] [[Fault Injection Attacks]] [[BLE Pairing Vulnerabilities]]