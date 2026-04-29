# CyberArk

## What it is
Think of it as a maximum-security vault with a rotating combination lock — every privileged account gets its own sealed compartment, and the combination changes automatically after each use. CyberArk is a Privileged Access Management (PAM) platform that secures, controls, and audits access to privileged accounts (admin, root, service accounts) across enterprise environments. It enforces least privilege, rotates credentials automatically, and records every privileged session.

## Why it matters
In the 2020 SolarWinds supply chain attack, attackers pivoted through the environment by harvesting privileged credentials that persisted for months without rotation. A properly deployed CyberArk implementation would have automatically rotated those credentials after each use and flagged anomalous privileged session activity — drastically limiting lateral movement. PAM tools like CyberArk are now considered a critical control in any zero-trust architecture.

## Key facts
- **Password Vaulting**: Stores privileged credentials in an encrypted Digital Vault, eliminating hardcoded passwords in scripts and applications
- **Just-in-Time (JIT) Access**: Provisions elevated privileges only when needed and revokes them automatically after a defined window
- **Session Recording**: Records full privileged sessions (keystroke + video) for forensic auditing and compliance (PCI-DSS, SOX, HIPAA)
- **Credential Rotation**: Automatically rotates passwords on a schedule or immediately after use, reducing the window of exposure for compromised credentials
- **Dual Control**: Requires approval from a second authorized person before releasing credentials for highly sensitive accounts

## Related concepts
[[Privileged Access Management]] [[Least Privilege Principle]] [[Just-in-Time Access]] [[Credential Harvesting]] [[Zero Trust Architecture]]