# WebAuthn

## What it is
Think of it like a physical deadbolt key that never leaves your house — the lock proves you have the key without the key ever traveling over the internet. WebAuthn (Web Authentication API) is a W3C standard that enables passwordless or multi-factor authentication using public-key cryptography, where the private key stays on the user's device and never transmits to the server.

## Why it matters
In 2022, phishing campaigns targeting Cloudflare employees attempted to steal session tokens and TOTP codes in real time using adversary-in-the-middle proxies — but employees registered with WebAuthn hardware keys were fully protected because the authenticator cryptographically binds itself to the *exact* origin domain, making stolen credentials useless on a fake site. This origin-binding property is the single biggest differentiator from SMS or TOTP-based MFA, which phishing can defeat.

## Key facts
- WebAuthn is part of the broader **FIDO2** specification alongside the **CTAP** (Client to Authenticator Protocol), which governs how the browser talks to hardware authenticators like YubiKeys
- The server stores only a **public key** (called a credential), never a password or secret — a breach of the credential store yields nothing usable
- **Origin binding**: the authenticator signs a challenge that includes the relying party ID (domain), so credentials are cryptographically tied to a specific site and cannot be replayed on phishing domains
- Supports three authenticator types: **platform** (built-in like Face ID/Windows Hello), **roaming/cross-platform** (USB/NFC hardware keys), and **hybrid** (phone as authenticator via Bluetooth)
- Resistant to **credential stuffing**, **phishing**, **replay attacks**, and **MitM attacks** — addressing multiple OWASP Top 10 authentication failure vectors simultaneously

## Related concepts
[[FIDO2]] [[Public Key Infrastructure]] [[Multi-Factor Authentication]] [[Phishing]] [[Credential Stuffing]]