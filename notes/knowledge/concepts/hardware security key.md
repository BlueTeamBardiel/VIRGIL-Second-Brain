# hardware security key

## What it is
Think of it like a physical deadbolt key that must be physically inserted before your front door's PIN pad even activates — the password alone is useless without the physical object. A hardware security key is a physical device (typically USB, NFC, or Bluetooth) that stores cryptographic credentials and performs authentication challenges locally, never transmitting the private key itself. Standards like FIDO2/WebAuthn govern how these devices communicate with browsers and operating systems.

## Why it matters
In 2017, Google rolled out hardware security keys (YubiKeys) to all 85,000+ employees and reported zero successful phishing account takeovers afterward — even when employees clicked malicious links. This works because the key performs a cryptographic handshake bound to the *legitimate* domain origin, so a fake login page receives a response that is cryptographically useless to the attacker.

## Key facts
- Hardware security keys are **phishing-resistant** because the FIDO2 protocol binds authentication to the relying party's origin URL — the key simply won't respond correctly to a spoofed domain
- Private keys **never leave the device**; the hardware performs signing internally, preventing credential theft via malware or keyloggers
- Support two primary protocols: **FIDO U2F** (older, second-factor only) and **FIDO2/WebAuthn** (supports passwordless authentication)
- Satisfies the **"something you have"** factor in multi-factor authentication (MFA)
- Lost/stolen keys alone are insufficient for attack — an adversary still needs the account username and typically a PIN (device-local, not transmitted)

## Related concepts
[[multi-factor authentication]] [[FIDO2]] [[public key cryptography]] [[phishing]] [[passwordless authentication]]