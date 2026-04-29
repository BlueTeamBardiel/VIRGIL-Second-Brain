# passwordless authentication

## What it is
Think of it like a hotel that recognizes you by your face and fingerprint instead of asking for a room key that could be stolen, copied, or forgotten. Passwordless authentication replaces the shared-secret model (passwords) with cryptographic proof of identity using something you *have* (a hardware token, phone) or something you *are* (biometrics), eliminating the password as the credential entirely. The server never stores a secret that an attacker can breach and replay.

## Why it matters
In the 2021 Colonial Pipeline ransomware attack, initial access was gained through a compromised VPN password — a credential that had no MFA protecting it. Passwordless authentication using FIDO2/WebAuthn would have made that specific attack vector impossible, because there is no password hash to phish, spray, or steal from a breached credential database. Organizations adopting passkeys or hardware security keys directly eliminate credential-stuffing and phishing as viable attack paths.

## Key facts
- **FIDO2/WebAuthn** is the dominant standard: the authenticator generates a public/private key pair per site; the private key never leaves the device
- **Passkeys** are a consumer-friendly FIDO2 implementation synced via platform ecosystems (Apple, Google, Microsoft) using device-bound or cloud-synced private keys
- Passwordless does **not** mean unauthenticated — it shifts the trust anchor from "something you know" to "something you have/are"
- **Phishing resistance** is the critical security property: because the private key is bound to a specific origin (domain), a fake phishing site cannot harvest a usable credential
- From a Security+ perspective, passwordless falls under **AAA**, **identity and access management (IAM)**, and is a direct control against **credential-based attacks** (T1078 in MITRE ATT&CK)

## Related concepts
[[FIDO2 and WebAuthn]] [[multi-factor authentication]] [[public key cryptography]] [[phishing]] [[identity and access management]]