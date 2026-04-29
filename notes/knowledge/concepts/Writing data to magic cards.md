# Writing data to magic cards

## What it is
Like a locksmith cutting a blank key to match a specific lock, writing data to magic cards means programming a blank smart card with credential data — certificates, PINs, access codes — so it functions as a legitimate (or cloned) authentication token. Precisely: it is the process of encoding data onto writable smart cards (e.g., Java Cards, SLE4442 chips) using card programming hardware and software to create functional identity credentials.

## Why it matters
An attacker who skims a victim's smart card data using a hidden card reader can write that captured data onto a blank magic card, creating a functional clone that passes physical access controls. This technique has been used in hotel keycard attacks and corporate badge cloning to gain unauthorized physical entry without triggering alarm systems that look for card *cancellation* rather than duplication.

## Key facts
- **Magic cards** (e.g., UID-changeable MIFARE cards) allow the normally fixed Unique Identifier (UID) block to be overwritten, bypassing systems that authenticate solely on UID
- Writing requires a compatible card reader/writer (e.g., ACR122U) and software such as MFCUK or MFOC that can inject captured sector data
- **MIFARE Classic** cards are vulnerable due to broken Crypto-1 encryption; cloned data can be written to magic card blank stock in minutes
- Defensive countermeasure: use cards with **mutual authentication** (e.g., MIFARE DESFire EV2) where the reader and card verify each other cryptographically, making raw data replay insufficient
- Physical security audits should include **anti-cloning detection** — systems that flag simultaneous use of the same credential ID at different entry points

## Related concepts
[[Smart Card Attacks]] [[RFID Cloning]] [[Physical Access Controls]] [[Replay Attacks]]