# Firmware Updates

## What it is
Think of firmware like the BIOS instructions baked into a pacemaker — it's not software you install, it's the code burned into hardware that tells the device how to breathe. Firmware updates are patches applied directly to a device's non-volatile memory (ROM, EEPROM, or flash storage) to fix vulnerabilities, add features, or change device behavior at the hardware control layer. Unlike OS patches, these updates modify the lowest-level logic governing how hardware components function.

## Why it matters
In 2018, researchers demonstrated that certain Cisco routers running outdated firmware were vulnerable to CVE-2018-0171 (Smart Install exploit), allowing attackers to overwrite firmware remotely and achieve persistent, OS-reinstall-surviving persistence. This matters because a compromised firmware image can survive a full factory reset — making detection and remediation extraordinarily difficult without physical hardware replacement.

## Key facts
- Firmware lives in non-volatile memory, meaning it persists without power and survives software-level wipes
- Unsigned or unverified firmware updates are a primary attack vector for supply chain attacks — attackers inject malicious code into legitimate update packages
- **Secure Boot** validates firmware integrity using cryptographic signatures before execution, preventing unauthorized firmware from loading
- NIST SP 800-193 provides the Platform Firmware Resiliency (PFR) guidelines, covering protection, detection, and recovery for firmware
- IoT devices are especially high-risk: many ship with outdated firmware and lack automatic update mechanisms, leaving known CVEs permanently unpatched in production environments

## Related concepts
[[Secure Boot]] [[Supply Chain Attacks]] [[Patch Management]] [[IoT Security]] [[Vulnerability Management]]