# multi-factor authentication

## What it is
Like a bank vault that requires both a physical key *and* a combination code — so stealing one gets you nowhere — MFA requires a user to present credentials from two or more distinct categories before granting access. These categories are: something you **know** (password), something you **have** (hardware token), and something you **are** (fingerprint). Critically, the factors must come from *different* categories; two passwords is just two-factor, not MFA.

## Why it matters
In the 2020 SolarWinds breach aftermath, Microsoft reported that 99.9% of compromised accounts had no MFA enabled. Attackers routinely harvest credentials through phishing or credential-stuffing, but even a perfect password theft is neutralized when the attacker can't also produce the victim's TOTP code or push-notification approval. MFA is the single highest-impact control against account takeover at scale.

## Key facts
- **Three factor categories**: Knowledge (PIN/password), Possession (smart card, OTP token), Inherence (biometrics) — and sometimes Location or Behavior as additional factors
- **TOTP** (Time-based One-Time Password) codes rotate every 30 seconds using a shared secret + current timestamp, per RFC 6238
- **SMS-based MFA is weakest** — vulnerable to SIM-swapping attacks; FIDO2/WebAuthn hardware keys are phishing-resistant
- **MFA fatigue attacks** flood a user with push-approval requests until they accept out of frustration — mitigated by number-matching prompts
- On Security+, MFA is contrasted with **2FA** (a subset) and distinguished from **SSO**, which reduces authentication events but doesn't inherently strengthen factor count

## Related concepts
[[phishing]] [[credential stuffing]] [[FIDO2]] [[single sign-on]] [[social engineering]]