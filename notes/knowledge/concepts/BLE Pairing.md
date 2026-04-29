# BLE Pairing

## What it is
Like two strangers agreeing on a secret handshake in a crowded room — someone might be watching. BLE (Bluetooth Low Energy) pairing is the process by which two devices establish a shared secret key to encrypt and authenticate future communications. It defines *how* devices exchange credentials and negotiate security parameters before becoming "bonded" (long-term trusted partners).

## Why it matters
In 2019, researchers demonstrated the KNOB attack (Key Negotiation of Bluetooth), where an attacker in the middle could force two pairing devices to negotiate a 1-byte entropy encryption key — making brute-force trivial. A medical device like a Bluetooth glucose monitor using "Just Works" pairing (no PIN, no confirmation) is silently vulnerable to passive eavesdropping and credential theft on any scan-capable device nearby.

## Key facts
- **Four pairing methods exist:** Just Works (no authentication), Passkey Entry, Numeric Comparison, and Out-of-Band (OOB) — each offering different MITM protection levels
- **Just Works** provides no MITM protection; it's the default fallback and the most dangerous mode in practice
- **LE Secure Connections** (introduced in BLE 4.2) uses Elliptic Curve Diffie-Hellman (ECDH) and is significantly stronger than legacy pairing
- **Bonding** stores the Long Term Key (LTK) so devices can reconnect without re-pairing — compromising the LTK grants persistent access
- **Bluejacking, bluesnarfing, and BIAS attacks** all exploit weaknesses in the authentication and pairing negotiation phases of classic or BLE stacks

## Related concepts
[[Bluetooth Attacks]] [[Man-in-the-Middle Attack]] [[Cryptographic Key Exchange]] [[Elliptic Curve Diffie-Hellman]] [[IoT Security]]