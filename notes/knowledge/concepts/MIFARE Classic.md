# MIFARE Classic

## What it is
Imagine a combination lock where the manufacturer used the same three "master combinations" for millions of locks worldwide — and published them by accident. MIFARE Classic is a family of contactless smart cards (ISO 14443-A) widely used in transit systems, building access, and payment, which relies on a proprietary and cryptographically broken stream cipher called CRYPTO-1 for authentication and data protection.

## Why it matters
In 2008, researchers reverse-engineered CRYPTO-1 and demonstrated that an attacker with a cheap NFC reader (like a Proxmark3) could eavesdrop on a single card-reader transaction, recover the 48-bit sector key in seconds, and then clone the card entirely — enabling free subway rides or unauthorized building access. This attack was deployed against the London Oyster card, the Dutch OV-chipkaart, and Boston's CharlieCard systems at real scale.

## Key facts
- Uses **CRYPTO-1**, a proprietary 48-bit stream cipher developed by NXP; it is NOT AES and has been fully reverse-engineered
- Vulnerable to **nested authentication attacks** and **darkside attacks**, both of which recover secret sector keys without knowing them in advance
- Cards store data in **16 sectors**, each protected by two 6-byte keys (Key A and Key B), but default factory keys (e.g., `FFFFFFFFFFFF`) are frequently left unchanged in deployed systems
- A **Proxmark3** or **ACR122U** with tools like `mfoc` or `mfcuk` can clone most MIFARE Classic cards in under a minute
- NXP released **MIFARE Plus** and **MIFARE DESFire** as hardened replacements using AES-128, but legacy Classic cards remain widespread

## Related concepts
[[CRYPTO-1]] [[NFC Cloning]] [[RFID Security]] [[Proxmark3]] [[Physical Access Control]]