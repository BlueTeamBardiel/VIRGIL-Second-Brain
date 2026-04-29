# YubiKey

## What it is
Think of it like a physical house key that also generates a one-time password — even if someone photographs it, the copy is useless because the secret changes every press. A YubiKey is a small hardware security key manufactured by Yubico that implements FIDO2/WebAuthn, TOTP, and other authentication protocols to provide phishing-resistant multi-factor authentication via USB, NFC, or Lightning connection.

## Why it matters
In 2017, Google deployed YubiKeys to all 85,000+ employees and reported zero successful phishing account takeovers afterward — compared to the prior reality of credential theft via fake login pages. Because the YubiKey cryptographically binds the authentication response to the *specific legitimate domain*, a fake login site receives a response that is mathematically invalid even if the user was tricked into entering credentials there.

## Key facts
- Implements **FIDO2/WebAuthn** (passwordless), **FIDO U2F** (second factor), **TOTP/HOTP** (OTP codes), **PIV smart card**, and **OpenPGP** — multiple protocols in one device
- Uses **public-key cryptography**: the private key never leaves the device and cannot be extracted by software
- Supports **tap-to-authenticate** (capacitive touch) to prevent malware from silently triggering authentication in the background
- Resistant to **man-in-the-middle and phishing attacks** because the origin URL is cryptographically verified during the WebAuthn challenge-response
- Loss of the key is a common operational risk — organizations must maintain **backup keys** or recovery codes as part of access continuity planning

## Related concepts
[[Multi-Factor Authentication]] [[FIDO2/WebAuthn]] [[Public Key Infrastructure]] [[Phishing]] [[Smart Card Authentication]]