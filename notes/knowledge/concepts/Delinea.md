# Delinea

## What it is
Think of Delinea as the bouncer at an exclusive club who doesn't just check your ID once — they verify your clearance every time you approach a VIP section, and keep a detailed log of everywhere you went. Delinea is a Privileged Access Management (PAM) vendor (formed from the merger of Thycotic and Centrify) that provides enterprise solutions for securing, managing, and auditing privileged accounts, credentials, and secrets across hybrid environments.

## Why it matters
In the 2020 SolarWinds attack, threat actors moved laterally through networks by harvesting privileged credentials and abusing service accounts — exactly the attack surface PAM solutions like Delinea are designed to shrink. Delinea's Secret Server product stores privileged credentials in an encrypted vault and enforces just-in-time access, meaning attackers can't simply steal a static admin password that sits exposed in a script or config file.

## Key facts
- **Secret Server** is Delinea's flagship product — a credential vault that rotates passwords automatically and requires checkout/check-in for privileged account use
- Supports **Zero Standing Privileges (ZSP)**: accounts only receive elevated access when needed, then permissions are revoked automatically
- Provides **session recording and keystroke logging** for privileged sessions, critical for forensic investigation and compliance audits (SOX, HIPAA, PCI-DSS)
- Integrates with **Active Directory and LDAP** to discover and onboard privileged accounts, reducing shadow IT credential risk
- Delinea enforces **MFA at privilege elevation**, not just at login — aligning with the principle of least privilege enforced at the session level

## Related concepts
[[Privileged Access Management]] [[Just-In-Time Access]] [[Credential Vaulting]] [[Least Privilege]] [[Zero Trust Architecture]]