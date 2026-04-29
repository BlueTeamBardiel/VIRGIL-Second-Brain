# ESP32

## What it is
Think of it as a Swiss Army knife the size of a postage stamp — it's a low-cost, dual-core microcontroller chip developed by Espressif Systems that integrates Wi-Fi and Bluetooth radios directly on the die. It runs at up to 240 MHz, supports both classic Bluetooth and BLE, and can be programmed via Arduino, MicroPython, or the native ESP-IDF framework.

## Why it matters
Security researchers and red teamers weaponize ESP32 boards to build cheap, concealable rogue access points and packet injection tools — a $4 chip can run a deauthentication attack against a 802.11 network or sniff BLE device advertisements in a parking lot. Defensively, organizations must account for these microcontrollers when auditing physical security and RF environments, since a planted ESP32 inside a server room can exfiltrate data via Wi-Fi without appearing as a standard endpoint on network inventories.

## Key facts
- Supports **802.11 b/g/n Wi-Fi** and **Bluetooth 4.2/5.0 (BLE)**, making it relevant to both wireless attack surfaces simultaneously
- Popular firmware like **Marauder** turns the ESP32 into a handheld Wi-Fi/BLE attack platform capable of deauth flooding, beacon spam, and PMKID capture
- The chip has documented **ROM vulnerabilities** (e.g., CVE-2019-15894) that allow bypassing secure boot under certain conditions
- Operates on **3.3V logic**, easily powered by USB power banks — enabling covert, long-duration implants
- Used legitimately in **IoT device prototyping**, meaning its presence on a network isn't inherently malicious — detection requires behavioral analysis, not just device identification

## Related concepts
[[Rogue Access Point]] [[Bluetooth Low Energy (BLE)]] [[Deauthentication Attack]] [[IoT Security]] [[Evil Twin Attack]]