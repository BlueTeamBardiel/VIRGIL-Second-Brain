# Flipper Mobile App

## What it is
Think of it as the TV remote control app that pairs with a universal remote capable of speaking dozens of wireless languages — the Flipper Mobile App is the companion iOS/Android application that connects via Bluetooth to the Flipper Zero device, enabling wireless control, firmware updates, and signal management from a smartphone interface. It extends the Flipper Zero's capabilities by offloading some processing and providing a user-friendly GUI for configuring attacks and reviewing captured data.

## Why it matters
During a physical penetration test, an attacker can discretely keep their phone in hand while the Flipper Zero sits concealed in a bag, using the mobile app to trigger NFC cloning or Sub-GHz replay attacks without touching the device directly. This separation of control surface from hardware makes detection significantly harder for security personnel conducting physical surveillance.

## Key facts
- Communicates with Flipper Zero over **Bluetooth Low Energy (BLE)**, meaning proximity is required (typically ~10 meters)
- Enables **remote triggering** of stored payloads: replaying RF signals, emitting captured IR codes, and sending cloned NFC/RFID credentials
- Supports **firmware updates (OTA)** — keeping the Flipper Zero current without a computer, including community-built firmware like Unleashed or RogueMaster that unlock restricted frequencies
- The app provides a **file manager** for uploading custom payloads, scripts, and BadUSB rubber-ducky style attack files directly to the device
- From a **defense perspective**, organizations should treat Flipper Zero + mobile app combos as a combined threat vector in physical security assessments, not just the hardware alone

## Related concepts
[[Flipper Zero]] [[Sub-GHz Radio Attacks]] [[NFC Cloning]] [[Bluetooth Low Energy Security]] [[BadUSB]]