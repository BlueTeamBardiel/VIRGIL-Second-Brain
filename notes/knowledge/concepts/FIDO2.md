# FIDO2

## What it is
Think of FIDO2 like a physical key cut uniquely for one lock — your authenticator device generates a cryptographic keypair per site, so even if a server is breached, attackers only get a public key that's useless without your hardware. FIDO2 is an open authentication standard combining the W3C's WebAuthn API and the CTAP2 protocol, enabling passwordless or phishing-resistant MFA using public-key cryptography bound to a specific origin (domain). The private key never leaves the authenticator device — a hardware token, platform TPM, or biometric sensor.

## Why it matters
In a credential-stuffing attack, stolen username/password pairs from one breach are replayed across dozens of sites — but FIDO2 completely breaks this chain because there are no passwords to steal or replay. Additionally, FIDO2 defeats real-time phishing proxies (like Evilginx2) that intercept session cookies after legitimate login, because the cryptographic challenge is bound to the exact origin URL — a lookalike domain returns a different challenge that the authenticator silently refuses to sign.

## Key facts
- **Two core components**: WebAuthn (browser/server API spec by W3C) + CTAP2 (Client-to-Authenticator Protocol, how browser talks to hardware key like YubiKey)
- **Phishing-resistant by design**: Private key signatures are scoped to the relying party ID (origin), making credential forwarding attacks impossible
- **Authenticator types**: Roaming authenticators (USB/NFC hardware tokens) vs. platform authenticators (Windows Hello, Face ID via TPM)
- **Replaces or supplements passwords**: Supports passwordless login, MFA second factor, or step-up authentication flows
- **Attestation**: During registration, authenticators can provide a cryptographically signed certificate proving the hardware model and manufacturer — relevant for enterprise policy enforcement

## Related concepts
[[WebAuthn]] [[Multi-Factor Authentication]] [[Public Key Infrastructure]] [[Credential Stuffing]] [[Hardware Security Keys]]