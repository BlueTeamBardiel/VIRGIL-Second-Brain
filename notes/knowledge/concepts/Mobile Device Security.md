# Mobile Device Security

## What it is
Think of your smartphone like a wallet, office, and house key fused into one object you leave on café tables — mobile device security is the discipline of protecting that object from physical theft, remote exploitation, and data leakage. It encompasses policies, configurations, and technologies that secure smartphones and tablets across their hardware, OS, and application layers.

## Why it matters
In 2020, attackers used **SIM swapping** to hijack a Twitter employee's phone number, gaining access to internal admin tools and compromising high-profile accounts including Barack Obama and Elon Musk. This attack bypassed strong passwords entirely — the phone number *was* the authentication factor, illustrating how mobile-specific threats undermine otherwise solid security architectures.

## Key facts
- **MDM (Mobile Device Management)** solutions like Microsoft Intune enforce policies such as screen lock, encryption, and remote wipe across corporate fleets — a core control tested on Security+
- **BYOD (Bring Your Own Device)** policies require **containerization** to isolate corporate data from personal apps, preventing data leakage between partitions
- **Full Device Encryption** is enabled by default on modern iOS (via Secure Enclave) and Android (AES-256), but is only as strong as the PIN/passphrase protecting the key
- **Sideloading** — installing apps outside official stores — bypasses app store vetting and is a primary vector for mobile malware delivery
- **Jailbreaking/Rooting** removes OS sandboxing protections, invalidates MDM enforcement, and exposes kernel-level attack surface — automatic policy violation in most enterprise frameworks

## Related concepts
[[Mobile Device Management]] [[SIM Swapping]] [[Application Sandboxing]] [[BYOD Policy]] [[Containerization]]