# Admin Credentials

## What it is
Like a master key that opens every door in a building, admin credentials are authentication secrets (username + password, token, or certificate) that grant elevated or full control over a system, application, or network device. Unlike standard user accounts, these credentials can modify configurations, create or delete accounts, and override security controls.

## Why it matters
In the 2020 SolarWinds attack, threat actors used compromised admin credentials to move laterally across networks, accessing sensitive systems with full privileges while appearing as legitimate administrators. This is why credential hardening and privileged access management are foundational controls — stolen admin credentials effectively hand attackers the entire kingdom.

## Key facts
- **Default credentials** (e.g., `admin/admin` on routers) are among the most exploited attack vectors; changing them is a baseline hardening requirement per CIS Controls
- Admin credentials should follow the **principle of least privilege** — even admin accounts should only have the minimum access needed for their specific role
- **Privileged Access Workstations (PAWs)** are dedicated, hardened machines used exclusively to access admin accounts, reducing exposure to credential theft
- **Pass-the-Hash (PtH)** attacks allow attackers to authenticate using a captured NTLM hash without knowing the plaintext password, making credential storage security critical
- Security+ and CySA+ expect you to know that **multi-factor authentication (MFA)** on admin accounts is a top mitigation against credential compromise, per NIST SP 800-63B

## Related concepts
[[Principle of Least Privilege]] [[Privileged Access Management]] [[Pass-the-Hash Attack]] [[Multi-Factor Authentication]] [[Default Credentials]]