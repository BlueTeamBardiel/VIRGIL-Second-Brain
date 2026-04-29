# Recovering MIFARE Classic Keys

## What it is
Like picking a combination lock by listening to the clicks — MIFARE Classic key recovery exploits a broken random number generator (RNG) to predict the keystream and reverse-engineer the secret sector keys. Specifically, it attacks the CRYPTO-1 cipher used in MIFARE Classic cards, which was kept proprietary but reverse-engineered in 2008, exposing fatal weaknesses in both the cipher design and the card's nonce generation.

## Why it matters
Physical access control systems worldwide — office buildings, transit systems like the London Oyster card, and university campuses — deployed MIFARE Classic cards for years. An attacker with a Proxmark3 or even an Android phone running MFOC (MIFARE Classic Offline Cracker) can recover all sector keys in minutes, clone the card, and walk through doors or ride transit for free indefinitely.

## Key facts
- **Nested authentication attack**: Once one sector key is known (often the default key), the card's weak RNG leaks enough information to crack remaining sector keys offline — typically within seconds.
- **Default keys are common**: Many deployments never change factory keys (e.g., `FFFFFFFFFFFF`, `A0A1A2A3A4A5`), making the nested attack trivial since the starting key is already known.
- **Darkside attack**: Even with no known keys, the CRYPTO-1 implementation leaks bits through error responses, allowing an attacker to recover at least one key from scratch.
- **Tools**: MFOC automates offline cracking; Proxmark3 with MFCUK enables the darkside attack; libnfc-based tools handle card communication.
- **MIFARE Classic is a 48-bit key cipher** — far too short by modern standards and compounded by the RNG flaw making brute force unnecessary.

## Related concepts
[[RFID Cloning]] [[CRYPTO-1 Cipher]] [[Proxmark3]] [[Physical Access Control Bypass]] [[Default Credential Exploitation]]