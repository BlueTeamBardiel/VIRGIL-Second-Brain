# multifactor authentication

## What it is
Think of it like a bank vault that requires both a physical key *and* a combination code — one stolen key gets you nowhere without the other. Multifactor authentication (MFA) requires users to verify identity using two or more independent factors drawn from: something you **know** (password), something you **have** (hardware token, smartphone), and something you **are** (fingerprint, retina scan). A fourth category — somewhere you **are** (geolocation) — appears increasingly in modern implementations.

## Why it matters
In the 2021 Colonial Pipeline attack, attackers gained initial access through a compromised VPN account that lacked MFA — a single stolen password unlocked critical infrastructure. Had MFA been enforced, the credential alone would have been worthless, since the attacker would still need physical possession of a second factor to authenticate.

## Key facts
- MFA is categorically different from **2-Step Verification** when the second step uses the *same factor type* (e.g., two passwords = still single-factor)
- **TOTP** (Time-based One-Time Passwords, RFC 6238) generates codes valid for ~30 seconds, used by apps like Google Authenticator
- **SMS-based MFA is the weakest form** — vulnerable to SIM swapping attacks where attackers port your number to their device
- **FIDO2/WebAuthn** hardware keys (e.g., YubiKey) are considered phishing-resistant MFA and are preferred for high-assurance environments
- NIST SP 800-63B explicitly discourages SMS OTP as a primary MFA mechanism for government systems due to interception risks

## Related concepts
[[password attacks]] [[phishing]] [[identity and access management]] [[zero trust architecture]] [[SIM swapping]]