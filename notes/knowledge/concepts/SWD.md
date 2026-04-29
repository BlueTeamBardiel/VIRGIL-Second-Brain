# SWD

## What it is
Think of SWD like a secret maintenance hatch on a safe — it lets technicians read and rewrite the internals without going through the front door. Serial Wire Debug (SWD) is a two-wire hardware debug interface (SWDIO + SWDCLK) used on ARM Cortex microcontrollers to allow direct read/write access to CPU registers, flash memory, and RAM during development.

## Why it matters
Attackers with physical access to an IoT device can attach a cheap logic analyzer or debug probe (like a $10 ST-Link) directly to exposed SWD pads on a PCB, extract the firmware, and reverse-engineer credentials, encryption keys, or proprietary algorithms — even if the device has no network interface exposed. Security researchers used this technique to extract firmware from smart locks, revealing hardcoded master passwords valid for every unit ever shipped.

## Key facts
- SWD uses only **2 signals** (SWDIO + SWDCLK) compared to JTAG's 4–5, making it easier to route on compact PCBs — and easier to find with a multimeter
- **Read-out Protection (RDP)** levels on STM32 chips (Level 0 = open, Level 1 = no readback, Level 2 = permanent lock) are the primary defense against SWD firmware extraction
- Bypassing RDP Level 1 via **voltage glitching** on the power rail is a documented attack that resets protection bits without erasing memory on some chip families
- Legitimate use: **in-circuit debugging**, setting breakpoints, and flashing firmware during manufacturing — production units should have SWD disabled or physically removed
- **Debug port lock-out** and epoxy-potting PCBs are common hardware hardening countermeasures against SWD probing in deployed products

## Related concepts
[[JTAG]] [[Firmware Extraction]] [[Hardware Hacking]] [[Side-Channel Attacks]] [[Physical Security]]