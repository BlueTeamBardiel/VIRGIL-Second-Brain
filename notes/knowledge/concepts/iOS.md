# iOS

## What it is
Think of iOS like a high-security apartment building where Apple is the landlord — tenants (apps) can only access their own units, can't wander the halls, and must be vetted before moving in. Precisely: iOS is Apple's mobile operating system for iPhones and iPads, built on a Unix-derived kernel with a security architecture centered on hardware-enforced sandboxing, mandatory code signing, and a curated app distribution model.

## Why it matters
In 2021, the NSO Group's Pegasus spyware exploited a zero-click iMessage vulnerability (FORCEDENTRY) to silently compromise fully patched iPhones belonging to journalists and activists — no user interaction required. Apple responded with Lockdown Mode in iOS 16, a hardened configuration that disables entire attack surface areas like JIT compilation and link previews, demonstrating that even the most locked-down mobile OS has exploitable seams at the zero-day level.

## Key facts
- **Secure Enclave**: A dedicated coprocessor that stores cryptographic keys, biometric data, and handles Touch/Face ID — isolated even from the main iOS kernel
- **App sandboxing**: Every app runs in its own container; inter-app data access requires explicit entitlements granted by Apple
- **Code signing**: All executable code must be signed with an Apple-trusted certificate; unsigned code cannot run without jailbreaking
- **Full Disk Encryption (FDE)**: Enabled by default using AES-256; tied to the Secure Enclave, making brute-force attacks without the device passcode computationally infeasible
- **Jailbreaking** breaks iOS security guarantees by exploiting kernel vulnerabilities to gain root access, bypassing code signing and sandbox enforcement entirely

## Related concepts
[[Mobile Device Management (MDM)]] [[Sandboxing]] [[Code Signing]] [[Secure Enclave]] [[Zero-Click Exploit]]