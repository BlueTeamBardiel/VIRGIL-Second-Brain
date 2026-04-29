# Trezor Safe

## What it is
Think of it like a bank vault bolted inside a calculator that never connects to the internet — your private keys live there, and the machine only signs transactions when you physically approve them. Trezor Safe is a hardware security key and cryptocurrency hardware wallet series (including the Safe 3 and Safe 5) that stores private keys in a secure element chip, isolated from internet-connected devices, requiring physical button confirmation for every transaction.

## Why it matters
In 2023, a major wave of phishing campaigns targeted software wallet users by deploying clipboard-hijacking malware that silently replaced copied crypto addresses with attacker-controlled addresses. Hardware wallet users like those running Trezor Safe were protected because even if malware infected the host PC, the transaction details are displayed on the device's own trusted screen and require physical confirmation — the attacker cannot forge an approval without touching the hardware.

## Key facts
- Uses a **secure element (EAL6+ certified chip in Safe 3)** to store private keys, making cold extraction extremely resistant even to physical tampering
- Implements **air-gap logic**: private keys never leave the device; only signed transactions are exported to the host system
- **Open-source firmware** (Trezor publishes code on GitHub), allowing community audit — a transparency model contrasting with closed-source competitors
- Vulnerable historically to **supply chain attacks** and **physical glitching attacks** — Kraken Security Labs demonstrated voltage fault injection on older models in 2020
- Recovery relies on a **BIP-39 seed phrase** (12–24 words); if compromised, all funds are accessible regardless of hardware security

## Related concepts
[[Hardware Security Module (HSM)]] [[Cold Storage]] [[Supply Chain Attack]] [[BIP-39 Seed Phrase]] [[Secure Element]]