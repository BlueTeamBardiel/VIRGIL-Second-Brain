# BLE Secure Connections

## What it is
Like replacing a combination lock with a bank-vault door — BLE Secure Connections (introduced in Bluetooth 4.2) upgraded the older "Legacy Pairing" by swapping out its broken cryptography for Elliptic Curve Diffie-Hellman (ECDH) key exchange. This gives two devices a way to establish a shared secret over the air without ever transmitting the actual key, even if a passive observer is recording every packet.

## Why it matters
Before Secure Connections, Bluetooth Legacy Pairing used a PIN-based scheme so weak that tools like Crackle could recover the Long Term Key from a single captured pairing session in seconds — exposing all past and future traffic. A medical device using BLE Secure Connections with "Numeric Comparison" association model, by contrast, is protected against passive eavesdropping and MITM attacks because the session keys are derived from ECDH rather than a guessable PIN.

## Key facts
- Uses **P-256 elliptic curve** for the ECDH key exchange, providing ~128-bit security strength
- Four association models: **Just Works**, **Numeric Comparison**, **Passkey Entry**, and **Out of Band (OOB)** — only Numeric Comparison and OOB resist MITM attacks
- Provides **forward secrecy**: compromise of one session key does not expose previous sessions
- Legacy Pairing (pre-4.2) is vulnerable to **passive eavesdropping** attacks; Secure Connections is not
- "Just Works" mode offers **no MITM protection** despite using ECDH — user verification is skipped entirely, making it suitable only for devices with no I/O capability

## Related concepts
[[Elliptic Curve Diffie-Hellman]] [[Bluetooth Legacy Pairing]] [[Man-in-the-Middle Attack]] [[Forward Secrecy]] [[IoT Security]]