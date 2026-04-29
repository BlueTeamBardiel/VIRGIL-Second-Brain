# Jailbreaking

## What it is
Like picking the lock on a hotel minibar to access items the hotel never intended to sell you — jailbreaking is the process of removing software restrictions imposed by a manufacturer or platform owner to gain unauthorized elevated access. Specifically, it exploits vulnerabilities in an operating system (commonly iOS or Android) to bypass code-signing enforcement and run unsigned, privileged code. The result is root or administrator-level access that the vendor explicitly designed to prevent.

## Why it matters
In enterprise mobile device management (MDM) environments, a single jailbroken phone can bypass Data Loss Prevention controls, allowing an employee to exfiltrate sensitive data through apps the MDM policy would otherwise block. MDM solutions like Microsoft Intune use jailbreak detection heuristics (checking for suspicious file paths like `/Applications/Cydia.app` or failed sandbox integrity checks) to flag and quarantine non-compliant devices before they reach corporate resources.

## Key facts
- Jailbreaking exploits **privilege escalation vulnerabilities** in the device kernel, granting root access outside the manufacturer's intended security model
- On iOS, jailbreaking typically bypasses **Secure Boot chain** and **code-signing** enforcement — two core pillars of Apple's security architecture
- Jailbroken devices lose access to **hardware-backed security features** (e.g., Secure Enclave isolation may be compromised), undermining biometric and key storage protections
- Under the **DMCA (Digital Millennium Copyright Act)**, jailbreaking personal smartphones is legal in the U.S., but jailbreaking tablets or gaming consoles occupies grayer legal territory
- From an attacker's perspective, jailbroken devices are high-value targets because they often disable **ASLR**, **sandboxing**, and certificate pinning simultaneously

## Related concepts
[[Privilege Escalation]] [[Mobile Device Management]] [[Rooting]] [[Code Signing]] [[Sandboxing]]