# Privileged Access Management

## What it is
Think of it like a nuclear launch protocol — no single person holds all the keys, every access event is logged, and the keys themselves rotate automatically after each use. Privileged Access Management (PAM) is a security discipline and toolset that controls, monitors, and audits access to high-value accounts (root, admin, service accounts) that can make sweeping changes to systems. PAM enforces least privilege by ensuring elevated credentials are issued only when needed, to verified users, for a defined purpose.

## Why it matters
In the 2020 SolarWinds attack, threat actors moved laterally through networks by compromising service accounts with excessive, persistent privileges — exactly the scenario PAM is designed to prevent. A mature PAM solution with just-in-time (JIT) access and automatic credential vaulting would have forced attackers to re-authenticate through monitored workflows, dramatically shrinking their operational window and leaving a clear audit trail.

## Key facts
- **Credential vaulting** stores privileged passwords in an encrypted repository and rotates them automatically after each checkout session
- **Just-in-Time (JIT) access** grants elevated privileges only for a specific task window, then revokes them — eliminating standing privileges
- **Session recording** captures keystroke logs and screen recordings of all privileged sessions, supporting forensic investigation and compliance (PCI-DSS, HIPAA)
- PAM tools enforce **dual control / four-eyes authorization** for the most sensitive operations, requiring a second approver before credentials are released
- PAM is distinct from Identity and Access Management (IAM): IAM governs *who* can access *what*; PAM governs *how* high-risk accounts are used once access is granted

## Related concepts
[[Least Privilege]] [[Identity and Access Management]] [[Just-in-Time Access]] [[Credential Stuffing]] [[Zero Trust Architecture]]