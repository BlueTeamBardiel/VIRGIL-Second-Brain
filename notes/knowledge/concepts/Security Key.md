# Security Key

## What it is
Like a physical deadbolt key that a thief can't copy by watching you type a PIN, a security key is a hardware device that proves identity through cryptographic challenge-response — not a secret you know. It is a physical token (typically USB, NFC, or Bluetooth) that implements standards like FIDO2/WebAuthn to perform public-key authentication, ensuring possession of the device is required to authenticate.

## Why it matters
Phishing attacks that steal passwords or even TOTP codes are defeated by security keys because the cryptographic response is bound to the legitimate origin domain — a fake login page receives a signature that only works on the real site. Google's internal deployment of security keys in 2017 eliminated account takeovers across 85,000 employees entirely, even against sophisticated spear-phishing campaigns.

## Key facts
- Security keys use **asymmetric cryptography**: the private key never leaves the device; the server stores only the public key
- They satisfy the **"something you have"** factor in multi-factor authentication (MFA) and are resistant to replay attacks because each challenge is unique
- **FIDO2** is the umbrella standard; **WebAuthn** is the browser/server API; **CTAP2** (Client-to-Authenticator Protocol) governs communication between browser and the key itself
- Unlike TOTP codes, security keys provide **origin binding** — the signed response is cryptographically tied to the relying party's domain, making phishing-based credential theft ineffective
- Security keys can store **resident keys** (discoverable credentials) allowing passwordless login entirely, going beyond just second-factor use

## Related concepts
[[Multi-Factor Authentication]] [[FIDO2]] [[WebAuthn]] [[Public Key Cryptography]] [[Phishing Resistance]]