# SIM swapping

## What it is
Imagine someone convincing your bank to hand a duplicate key to your safe deposit box to a stranger — that's exactly what happens here, but with your phone number. SIM swapping (also called SIM hijacking) is a social engineering attack where an adversary impersonates a victim to a mobile carrier, convincing them to transfer the victim's phone number to a SIM card the attacker controls.

## Why it matters
In 2019, Twitter CEO Jack Dorsey's account was hijacked via SIM swap — attackers gained control of his number and used SMS-based account recovery to post unauthorized tweets. This attack vector is particularly devastating because SMS-based multi-factor authentication (MFA), widely deployed as a security upgrade, becomes the attacker's key rather than a barrier.

## Key facts
- SIM swapping exploits the mobile carrier's identity verification process, which often relies on weak authenticators like last four digits of SSN or billing address — data obtainable via OSINT or prior data breaches
- Once successful, all SMS messages and calls — including OTP codes for banking, email, and crypto accounts — are routed to the attacker's device
- NIST SP 800-63B explicitly flags SMS-based OTP as a restricted authenticator due to SIM swap risk
- Defense includes switching to authenticator apps (TOTP) or hardware tokens (FIDO2/WebAuthn), which are not tied to phone numbers
- Carriers now offer "SIM lock" or "port freeze" features; victims should enable these as a preventive control

## Related concepts
[[Social Engineering]] [[Multi-Factor Authentication]] [[Vishing]] [[Account Takeover]] [[OSINT]]