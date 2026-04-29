# MFA

## What it is
Like a bank vault that requires both a key card *and* a combination code — losing one doesn't unlock the door — Multi-Factor Authentication requires proof from two or more distinct categories before granting access. These categories are something you **know** (password), something you **have** (hardware token), and something you **are** (fingerprint). Critically, factors must come from *different* categories; two passwords is just two-step, not multi-factor.

## Why it matters
In the 2021 Colonial Pipeline ransomware attack, attackers accessed a VPN account using a single compromised password — no MFA was enforced. Had MFA been required, the stolen credential alone would have been useless, and a $4.4 million ransom payment might have been avoided. This is the canonical example of why password-only authentication fails at scale.

## Key facts
- The three factor categories are **Type 1** (knowledge), **Type 2** (possession), and **Type 3** (inherence/biometrics); location and behavior are sometimes called Type 4 and Type 5
- **TOTP** (Time-based One-Time Password, RFC 6238) generates codes that expire every 30 seconds — used by Google Authenticator and Authy
- **SMS-based MFA is the weakest** second factor due to SIM-swapping attacks, where attackers convince carriers to transfer your number to their SIM
- **Push notification fatigue (MFA bombing)** is a real attack: flood a user with approval requests until they accidentally or frustratedly tap "Approve" — used against Uber in 2022
- FIDO2/WebAuthn hardware keys (e.g., YubiKey) are considered **phishing-resistant MFA** because authentication is bound to a specific origin URL

## Related concepts
[[Authentication]] [[SIM Swapping]] [[Phishing-Resistant Authentication]] [[Zero Trust]] [[Identity and Access Management]]