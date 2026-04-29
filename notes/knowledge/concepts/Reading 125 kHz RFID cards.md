# Reading 125 kHz RFID cards

## What it is
Like overhearing someone whisper their house key's serial number just by standing nearby, reading 125 kHz RFID cards means silently capturing the unique ID broadcast by legacy proximity cards without the cardholder ever knowing. These cards (HID Prox, EM4100 format) operate at 125 kHz, transmitting a fixed, unencrypted identifier when energized by a reader's electromagnetic field — no battery, no authentication, no challenge-response.

## Why it matters
An attacker carrying a concealed reader (e.g., a Proxmark3 or ESPKey device hidden in a laptop bag) can clone an employee's access card by walking past them in a hallway or elevator, then replay the captured ID to gain physical access to secure facilities. This attack bypasses all logical security controls entirely — no password cracking required — and was central to documented breaches of data centers and government buildings relying on outdated physical access systems.

## Key facts
- **125 kHz cards transmit a static, plaintext UID** — no encryption, no rolling codes, making them trivially clonable once captured
- **Effective read range** is typically 2–10 cm with standard readers, but purpose-built long-range antennas can extend this to ~1 meter
- **Proxmark3** is the industry-standard research and attack tool for reading, emulating, and cloning both 125 kHz and 13.56 MHz cards
- **T5577 chips** are the attacker's preferred blank card — writable, and can impersonate most 125 kHz card formats
- **Mitigation**: Upgrade to 13.56 MHz smart cards (MIFARE DESFire EV2, iCLASS SE) with mutual authentication, or layer with PIN/biometric (multi-factor physical access)

## Related concepts
[[Physical Security Controls]] [[RFID Cloning]] [[Replay Attacks]] [[Proximity Card Vulnerabilities]] [[Multi-Factor Authentication]]