# passkeys

## What it is
Think of a passkey like a hotel key card that only works in *your* hand — the hotel never sees your fingerprint, just confirms the card's cryptographic handshake. Technically, a passkey is a FIDO2/WebAuthn credential consisting of a public-private key pair where the private key never leaves your device, and authentication is proven via a local biometric or PIN rather than a shared secret transmitted to the server.

## Why it matters
In 2022, attackers phished Twilio employees with fake login pages that captured passwords and OTP codes in real time — a classic adversary-in-the-middle credential harvest. Passkeys are **phishing-resistant by design**: the private key signs a challenge bound to the exact origin (domain), so a fake phishing site receives a signature it can never replay against the legitimate server, rendering the entire attack class ineffective.

## Key facts
- Passkeys replace passwords entirely — authentication uses asymmetric cryptography (typically ECDSA over P-256); the server stores only the public key
- Built on **FIDO2 = WebAuthn (browser API) + CTAP2 (device/authenticator protocol)**; passkeys are the consumer-friendly name for FIDO2 discoverable credentials
- The private key is stored in a device's **Secure Enclave / TPM** and is never exported or transmitted
- Passkeys are **origin-bound**: the cryptographic challenge includes the relying party ID (domain), defeating both phishing and credential stuffing attacks simultaneously
- Synced passkeys (e.g., via Apple Keychain or Google Password Manager) trade some hardware-binding for cross-device usability, creating a distinct threat model from device-bound passkeys

## Related concepts
[[FIDO2]] [[WebAuthn]] [[multi-factor authentication]] [[asymmetric cryptography]] [[phishing-resistant MFA]]