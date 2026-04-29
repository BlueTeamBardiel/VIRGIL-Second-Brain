# Unlocking cards with passwords

## What it is
Like a safe-deposit box that requires both a physical key *and* a PIN code, unlocking a smart card with a password combines something-you-have (the card) with something-you-know (the PIN or password) to release the card's stored cryptographic keys. Precisely, this is a two-factor authentication mechanism where the card's private key material remains locked and inaccessible until the correct PIN is presented to the card's onboard processor — the key never leaves the card itself.

## Why it matters
In a Common Access Card (CAC) or PIV card environment, an attacker who physically steals an employee's smart card still cannot authenticate to a VPN or sign documents without the correct PIN. This is why theft of a smart card alone is far less catastrophic than theft of a password alone — and why organizations mandate PIN complexity requirements and lockout thresholds to prevent brute-force attacks against the card directly.

## Key facts
- Smart card PINs are verified **on the card's microprocessor**, not sent to a server, making network interception attacks ineffective against the PIN itself.
- Most smart cards implement a **lockout after 3–10 failed PIN attempts**, rendering the card permanently unusable (brute-force resistant by design).
- The **PIN unlocks the private key** stored in protected memory; the key is used for operations but never exported — this is called "key non-exportability."
- PIV and CAC cards used in U.S. federal systems are governed by **FIPS 201**, which mandates PIN length (6–8 digits minimum) and lockout policies.
- This mechanism is distinct from a password manager — the card is a **hardware security module (HSM)** in miniature, providing tamper-resistant cryptographic operations.

## Related concepts
[[Smart Cards]] [[Multi-Factor Authentication]] [[Public Key Infrastructure (PKI)]] [[Hardware Security Module (HSM)]] [[PIV/CAC Authentication]]