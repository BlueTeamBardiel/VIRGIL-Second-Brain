# Windows Hello

## What it is
Think of it like a bouncer who recognizes your face instead of checking your ID card — no password to steal, no card to clone. Windows Hello is Microsoft's biometric and PIN-based authentication framework built into Windows 10/11 that replaces passwords with facial recognition, fingerprint scanning, or a device-bound PIN using asymmetric cryptography under the hood.

## Why it matters
In a credential-stuffing attack, stolen password databases are worthless against Windows Hello because no password ever leaves the device — the private key never moves off the TPM chip. Even if an attacker compromises a corporate server, they cannot extract a reusable credential; authentication requires both the physical device and the biometric or PIN confirmation present at that machine.

## Key facts
- Windows Hello for Business (WHfB) uses **asymmetric key pairs**: a private key stored in the device's TPM and a public key registered with Azure AD or Active Directory — this is PKI-backed passwordless auth
- The PIN is **not a password** — it's a TPM-unlocking gesture that is device-local and never transmitted across the network, unlike a domain password
- Facial recognition uses **infrared imaging** (not standard RGB) to resist photo-based spoofing attacks
- WHfB satisfies **MFA requirements** by combining "something you have" (the device/TPM) with "something you are" (biometric) or "something you know" (PIN)
- Relies on **FIDO2/WebAuthn** standards when extended to browser and cloud authentication, making it interoperable beyond Windows environments

## Related concepts
[[Multi-Factor Authentication]] [[TPM (Trusted Platform Module)]] [[FIDO2]] [[Public Key Infrastructure]] [[Credential Guard]]