# ESP32Marauder

## What it is
Think of it as a Swiss Army knife soldered onto a $5 chip — ESP32Marauder is an open-source firmware for the ESP32 microcontroller that bundles a suite of 802.11 Wi-Fi and Bluetooth offensive security tools into a device small enough to hide in a coat pocket. It transforms cheap consumer hardware into a capable wireless pentesting platform capable of packet capture, deauthentication attacks, and beacon spam.

## Why it matters
A red team operator can pair an ESP32Marauder-flashed device with a Flipper Zero or a battery pack and conduct Wi-Fi deauthentication attacks against a target facility during a physical penetration test — forcing clients off their access points without ever touching the network. Defenders use this scenario to validate whether their WPA3 or 802.11w (Management Frame Protection) configurations actually prevent deauth floods, exposing gaps in enterprise wireless policy.

## Key facts
- **Deauthentication attacks**: Exploits the unprotected 802.11 management frames in WPA2 to forcibly disconnect clients; mitigated by enabling 802.11w (PMF — Protected Management Frames)
- **Beacon spam**: Floods the local airspace with hundreds of fake SSIDs, overwhelming client Wi-Fi scanners and causing confusion or denial-of-service
- **PMKID capture**: Can passively capture PMKID handshake material from WPA2 networks without a connected client, enabling offline brute-force attacks
- **Runs on ~$5–$20 hardware**: The ESP32 chip makes this accessible; commercial variants exist on the Flipper Zero Wi-Fi dev board
- **Legal boundary**: Using ESP32Marauder on networks without explicit written authorization violates the Computer Fraud and Abuse Act (CFAA) and equivalent laws globally

## Related concepts
[[Deauthentication Attack]] [[Evil Twin Attack]] [[802.11 Management Frame Protection]] [[Wireless Packet Capture]] [[Flipper Zero]]