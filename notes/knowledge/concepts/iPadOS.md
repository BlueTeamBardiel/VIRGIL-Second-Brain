# iPadOS

## What it is
Think of iPadOS as iOS wearing a business suit — it's the same core operating system as iPhone's iOS, but tailored with extra productivity features for the larger iPad form factor. Precisely, iPadOS is Apple's Unix-based mobile operating system derived from iOS, introduced in 2019, designed specifically for iPad devices with added multitasking, file management, and peripheral support capabilities.

## Why it matters
In enterprise environments, iPadOS devices are frequently enrolled in Mobile Device Management (MDM) platforms like Jamf or Microsoft Intune. An attacker who compromises an MDM server can push malicious configuration profiles to every enrolled iPad — silently installing rogue certificates that enable SSL interception or redirecting VPN traffic through attacker-controlled infrastructure, affecting thousands of devices simultaneously with a single administrative action.

## Key facts
- iPadOS enforces **app sandboxing** by default — each app runs in an isolated container, limiting lateral movement if one app is compromised
- **Sideloading restrictions**: Unlike Android, iPadOS historically only allows app installation via the App Store (or MDM/Enterprise certificates), significantly reducing the attack surface from malicious APKs
- **Secure Enclave** protects biometric data (Face ID/Touch ID) and cryptographic keys in hardware-isolated storage, separate from the main processor
- Configuration profiles (`.mobileconfig` files) can be weaponized — malicious profiles can install rogue CA certificates, modify DNS settings, or configure VPN tunnels
- iPadOS supports **Always-On VPN** enforcement through MDM, a key control for ensuring enterprise traffic is never transmitted unencrypted
- As of iOS/iPadOS 16+, **Lockdown Mode** provides extreme hardening for high-risk users, disabling JIT compilation, limiting message attachment types, and blocking wired connections from unknown accessories

## Related concepts
[[Mobile Device Management]] [[iOS Security]] [[Secure Enclave]] [[Certificate Pinning]] [[App Sandboxing]]