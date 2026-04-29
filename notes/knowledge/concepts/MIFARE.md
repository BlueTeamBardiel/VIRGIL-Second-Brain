# MIFARE

## What it is
Think of it like a vending machine token that a counterfeiter learned to mint perfectly — it looks real, spends real, but cost nothing to forge. MIFARE is a family of contactless smart card technologies (operating at 13.56 MHz via NFC/ISO 14443) developed by NXP Semiconductors, widely used in transit passes, building access cards, and payment systems. The classic variant, MIFARE Classic, uses a proprietary cipher called CRYPTO1 that was reverse-engineered and broken, exposing billions of deployed cards to cloning attacks.

## Why it matters
In 2008, researchers at Radboud University fully broke CRYPTO1 and demonstrated that a MIFARE Classic card — like the London Oyster card or Dutch OV-chipkaart — could be cloned in seconds using a ~$100 Proxmark reader. An attacker could tap a victim's transit card in a crowded subway, extract the key material through a series of authentication attempts exploiting the weak RNG, and produce a perfect duplicate to ride for free — or worse, clone an access badge to enter a secure facility.

## Key facts
- **MIFARE Classic** uses the 48-bit proprietary CRYPTO1 cipher, which was never publicly vetted and was fully broken in 2008
- Cards operate at **13.56 MHz** using the ISO/IEC 14443 standard (NFC proximity)
- **MIFARE DESFire** and **MIFARE Plus** are successor versions using AES-128, significantly more resistant to known attacks
- The **Proxmark3** is the standard pentesting tool used to read, emulate, and clone MIFARE cards
- MIFARE Classic remains deployed in millions of legacy systems worldwide despite known vulnerabilities, making supply-chain replacement a major organizational risk

## Related concepts
[[NFC Security]] [[RFID Attacks]] [[Physical Access Control]] [[Proxmark3]] [[Cryptographic Weaknesses]]