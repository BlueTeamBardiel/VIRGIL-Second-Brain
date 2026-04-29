# Root of Trust

## What it is
Like a notary whose signature everyone agrees to trust before any other document can be verified, a Root of Trust is the foundational component in a system whose integrity is assumed rather than proven. It is a hardware or firmware element — typically a dedicated chip or secure enclave — that provides cryptographically verified measurements from which all subsequent trust in a system is derived. Everything above it in the trust chain is only trusted *because* the Root of Trust says it is.

## Why it matters
In 2011, RSA SecurID tokens were compromised partly because attackers could not be stopped once they bypassed software-level defenses — a problem a hardware Root of Trust is specifically designed to prevent. Modern defenses like UEFI Secure Boot use a Root of Trust stored in firmware to verify bootloader signatures before execution, ensuring that even if an attacker plants a bootkit, the system refuses to run unsigned code. Without this anchor, every layer of the security stack is vulnerable to subversion from below.

## Key facts
- The **Trusted Platform Module (TPM)** is the most common hardware Root of Trust; it stores cryptographic keys and platform measurements in tamper-resistant hardware
- **Platform Configuration Registers (PCRs)** inside a TPM record hash measurements of boot components, enabling **remote attestation** — proving to a remote party that a system booted cleanly
- A Root of Trust can be hardware (TPM), firmware (UEFI), or software-based — but hardware roots are considered most secure because they cannot be modified by OS-level malware
- **Chain of Trust** describes how each layer (firmware → bootloader → OS → applications) verifies the next, rooted back to this initial anchor
- NIST SP 800-164 and TCG (Trusted Computing Group) specifications define standards for implementing hardware Roots of Trust

## Related concepts
[[TPM (Trusted Platform Module)]] [[Secure Boot]] [[Chain of Trust]] [[Remote Attestation]] [[Hardware Security Module (HSM)]]