# Bluetooth LE

## What it is
Think of Bluetooth LE like a postal service that only delivers postcards — lightweight, cheap, and fast, but not built for moving furniture. Bluetooth Low Energy (BLE) is a short-range wireless protocol designed for devices that need to transmit small amounts of data while running on a coin battery for months or years. Unlike classic Bluetooth, BLE uses a separate radio stack optimized for intermittent, low-bandwidth communication between devices like fitness trackers, smart locks, and medical sensors.

## Why it matters
In 2019, researchers demonstrated "KNOB" (Key Negotiation of Bluetooth) attacks, where an attacker could force BLE devices to negotiate encryption keys as short as 1 byte — making brute-force trivial. This matters because hospitals deploy BLE-connected insulin pumps and pacemaker monitors, where a successful attack on a weak pairing session could allow an adversary to intercept or manipulate health data within the 30–100 meter operational range.

## Key facts
- BLE operates on the **2.4 GHz ISM band**, using 40 channels, with 3 dedicated advertising channels (37, 38, 39) where devices broadcast their presence
- **Pairing modes** include Just Works (no authentication, vulnerable to MitM), Passkey Entry, Numeric Comparison, and Out-of-Band — Just Works is the most commonly exploited
- BLE uses **AES-128 CCM** for encryption when enabled, but encryption is *optional* and frequently disabled on commodity IoT devices
- **Bluejacking, Bluesnarfing, and BIAS (Bluetooth Impersonation Attacks)** are BLE-relevant attack categories tested on Security+ and CySA+
- Devices in **promiscuous advertising mode** are discoverable to any scanner — tools like `bettercap` and `Wireshark` with a BTLE plugin can passively capture advertising packets without authentication

## Related concepts
[[Bluetooth Classic Security]] [[IoT Attack Surface]] [[Man-in-the-Middle Attack]] [[Wireless Protocol Vulnerabilities]]