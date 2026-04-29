# ESP32 Marauder

## What it is
Think of it as a Swiss Army knife crammed into a $5 chip — except every blade is designed to probe wireless networks. ESP32 Marauder is an open-source firmware for the ESP32 microcontroller that transforms the cheap Wi-Fi/Bluetooth SoC into a portable offensive wireless tool capable of sniffing, scanning, and attacking 802.11 and Bluetooth Low Energy (BLE) networks.

## Why it matters
A red teamer can carry an ESP32 Marauder device disguised as a USB charging brick into a target facility and perform deauthentication attacks against Wi-Fi clients, forcing them to reconnect and capturing the WPA2 4-way handshake for offline cracking. Defenders can use the same tool to audit their own environments for rogue access points and verify that 802.11w (Management Frame Protection) is properly enforced, since MFP directly neutralizes deauth attacks.

## Key facts
- **Deauthentication attacks**: Sends forged 802.11 disassociation/deauthentication frames to disconnect clients from legitimate APs — only defeated by enabling IEEE 802.11w (PMF).
- **Evil Portal**: Can host a captive portal that harvests credentials from users who auto-reconnect to a spoofed SSID.
- **BLE scanning**: Enumerates nearby Bluetooth Low Energy devices, exposing IoT devices and wearables broadcasting device names and UUIDs.
- **Runs on ~$10 hardware**: Flipper Zero with Wi-Fi dev board, M5StickC Plus, or bare ESP32 modules all support Marauder firmware.
- **Packet capture output**: Can save PCAP files to a connected SD card, feeding directly into Wireshark for offline analysis — relevant to network forensics workflows.

## Related concepts
[[Deauthentication Attack]] [[Evil Twin Attack]] [[WPA2 4-Way Handshake]] [[802.11w Management Frame Protection]] [[Flipper Zero]]