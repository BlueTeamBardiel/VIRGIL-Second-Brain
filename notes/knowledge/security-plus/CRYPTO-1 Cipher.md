# CRYPTO-1 Cipher

## What it is
Imagine a combination lock where the manufacturer used the same three weak tumblers in every lock ever sold — CRYPTO-1 is exactly that: a proprietary 48-bit stream cipher baked into MIFARE Classic RFID cards that was secretly identical across billions of deployed cards. It is a lightweight, shift-register-based cipher developed by NXP Semiconductors, designed for low-power contactless smart cards but never publicly reviewed before deployment.

## Why it matters
In 2008, researchers reverse-engineered CRYPTO-1 from a MIFARE Classic chip and demonstrated that an attacker with a cheap RFID reader could clone transit cards (used in systems like the London Oyster card and Dutch OV-chipkaart) within minutes. The attack exploited a weak pseudo-random number generator in the authentication handshake, allowing an attacker to recover the 48-bit key with only a handful of authentication attempts — essentially free public transit for anyone with a Proxmark device.

## Key facts
- CRYPTO-1 uses a 48-bit key and a 48-bit Linear Feedback Shift Register (LFSR), making it trivially weak by modern cryptographic standards
- The cipher was kept proprietary ("security through obscurity") — it was reverse-engineered via decapping the chip with acid and optical microscopy in 2008
- MIFARE Classic cards are still widely deployed in access control and transit systems worldwide despite the cipher being fully broken
- The authentication protocol leaks keystream bits predictably, enabling a **nested authentication attack** that recovers keys in seconds
- CRYPTO-1 vulnerabilities are a canonical example of why proprietary, unaudited cryptography fails — violating Kerckhoffs's principle

## Related concepts
[[Stream Ciphers]] [[RFID Security]] [[Kerckhoffs's Principle]] [[Replay Attacks]] [[Physical Security]]