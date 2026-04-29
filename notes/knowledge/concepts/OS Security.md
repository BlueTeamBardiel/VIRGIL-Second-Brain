# OS Security

## What it is
Think of an operating system like the building manager of a skyscraper — controlling who gets keys, which floors they can access, and what they can do once inside. OS security is the set of mechanisms, configurations, and hardening practices that protect the operating system kernel, user processes, file system, and memory from unauthorized access, privilege escalation, and exploitation.

## Why it matters
In 2017, the EternalBlue exploit targeted an unpatched vulnerability in Windows SMBv1, allowing attackers to execute arbitrary code at the SYSTEM level with no user interaction — directly enabling the WannaCry ransomware outbreak that crippled hospitals worldwide. Proper OS hardening (disabling unused services like SMBv1, applying patches, enforcing least privilege) would have broken the attack chain entirely.

## Key facts
- **Least privilege principle**: Users and processes should run with the minimum permissions necessary; violations enable privilege escalation attacks.
- **Patch management is foundational**: The majority of OS exploits target known CVEs with available patches — unpatched systems are low-hanging fruit.
- **Mandatory Access Control (MAC)** (e.g., SELinux, AppArmor) enforces policy-defined labels that override discretionary user permissions, containing damage from compromised processes.
- **Attack Surface Reduction**: Disabling unnecessary services, ports, and features (e.g., disabling Telnet, SMBv1) is a core hardening benchmark item (CIS Benchmarks, STIG).
- **Secure Boot** verifies bootloader and kernel integrity using cryptographic signatures, preventing rootkits from loading before the OS starts — relevant to the chain of trust concept on exam scenarios.

## Related concepts
[[Privilege Escalation]] [[Patch Management]] [[Hardening]] [[Mandatory Access Control]] [[Rootkits]]