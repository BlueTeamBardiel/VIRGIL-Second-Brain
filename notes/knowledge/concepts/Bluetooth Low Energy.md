# Bluetooth Low Energy

## What it is
Think of BLE like a postal service that only delivers postcards — small, infrequent messages with minimal overhead, not full letters. Bluetooth Low Energy (BLE) is a wireless personal area network protocol operating on the 2.4 GHz ISM band, designed for short-range communication with dramatically reduced power consumption compared to classic Bluetooth. It achieves this by transmitting data in short bursts rather than maintaining continuous connections.

## Why it matters
In 2019, researchers demonstrated "BLESA" (BLE Spoofing Attack), where weaknesses in the BLE reconnection process allowed attackers to spoof a trusted device and push falsified data to fitness trackers and medical devices — without any user notification. This matters because BLE devices like insulin pumps, pacemakers, and glucose monitors make authentication failures life-threatening, not just inconvenient.

## Key facts
- BLE uses **40 radio channels** (3 advertising channels at 2402, 2426, 2480 MHz; 37 data channels), making channel hopping a built-in interference defense
- **Advertising mode** broadcasts device presence openly — this is the primary attack surface for enumeration and tracking
- BLE pairing modes include **Just Works** (no authentication, vulnerable to MitM), **Passkey Entry**, and **Numeric Comparison** — Just Works is the most commonly exploited
- The **GATT (Generic Attribute Profile)** structure organizes BLE data into Services and Characteristics — attackers enumerate these to find sensitive exposed attributes
- BLE is distinct from Bluetooth Classic; a device can support one, both (**Bluetooth Dual Mode**), or neither — security controls must account for both stacks separately

## Related concepts
[[Bluetooth Classic Security]] [[MITM Attack]] [[Wireless Protocol Attacks]] [[IoT Security]] [[RF Jamming]]