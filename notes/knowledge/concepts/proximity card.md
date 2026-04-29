# proximity card

## What it is
Like a bar coaster that whispers your name to the bartender when you hold it close — no touching required. A proximity card is a passive RFID credential that broadcasts a unique ID number when energized by a reader's electromagnetic field, typically operating at 125 kHz (low frequency). No battery, no contact — just wave and authenticate.

## Why it matters
An attacker carrying a concealed RFID reader can silently clone a proximity card from inches away in a crowded elevator or lobby — a technique called skimming or relay attack. Because legacy 125 kHz prox cards transmit their ID in plaintext with no encryption or challenge-response, the cloned credential works identically to the original, granting physical access to secured areas without the victim ever knowing their card was copied.

## Key facts
- **Frequency:** Standard proximity cards operate at **125 kHz**; smart cards (Mifare, iCLASS) use **13.56 MHz** and offer encryption
- **Read range:** Typically 2–5 cm by design, but purpose-built long-range readers can skim from **~1 meter**
- **No mutual authentication:** The card transmits its Facility Code + Card Number in the clear — there is no cryptographic handshake
- **Facility Code weakness:** Many organizations use the same Facility Code across all cards, so one cloned card can open every door on-site
- **Mitigation:** Upgrade to smart card systems (PIV, CAC, or FIDO2-capable NFC) that use challenge-response cryptography and support multi-factor pairing

## Related concepts
[[RFID]] [[physical security]] [[access control]] [[social engineering]] [[multi-factor authentication]]