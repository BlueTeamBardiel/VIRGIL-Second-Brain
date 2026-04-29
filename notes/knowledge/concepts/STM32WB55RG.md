# STM32WB55RG

## What it is
Think of it as a Swiss Army knife soldered onto a chip — one silicon die containing both a Cortex-M4 application processor *and* a dedicated Cortex-M0+ radio coprocessor, purpose-built to keep wireless stack firmware isolated from application code. Precisely, the STM32WB55RG is a dual-core wireless microcontroller from STMicroelectronics supporting Bluetooth 5.0 LE, Zigbee 3.0, and IEEE 802.15.4, commonly deployed in IoT edge devices, smart home hubs, and medical wearables.

## Why it matters
In 2021, researchers demonstrated that STM32-family devices with improperly configured Read-Out Protection (RDP) levels could be downgraded via voltage glitching attacks, allowing full flash memory extraction even on "protected" devices. An attacker recovering firmware from a smart lock or insulin pump built on the WB55RG could reverse-engineer proprietary cryptographic keys or hardcoded credentials, turning a physical device into a full network compromise vector.

## Key facts
- **Dual-core security boundary**: The M0+ coprocessor runs ST's certified BLE/Zigbee stack in isolation; inter-core communication uses a hardware mailbox (IPCC peripheral), reducing attack surface on the radio stack.
- **Read-Out Protection (RDP)** has three levels (0, 1, 2): Level 2 is irreversible and disables JTAG/SWD entirely — a critical hardening step before production deployment.
- **TrustZone is NOT present** on the WB55; security architects must implement privilege separation manually through MPU (Memory Protection Unit) configuration.
- **AES-256 hardware accelerator** is on-chip, supporting CCM and GCM modes relevant to BLE link-layer encryption.
- Firmware update attacks via ST's proprietary OTA mechanism are a known threat vector if update authenticity (code signing) is not enforced at the application layer.

## Related concepts
[[Firmware Extraction]] [[JTAG Debugging Interface]] [[Bluetooth LE Security]] [[Memory Protection Unit]] [[Side-Channel Attacks]]