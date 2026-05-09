# Authentication, Authorization, and Accounting

## What it is

In Metroid, Samus arrives at a Chozo statue holding the Varia Suit. The statue verifies it's actually her (authentication), grants her the upgrade that unlocks Norfair's heat zones (authorization), and the game records her item percentage and completion time on the save file (accounting). That's exactly what AAA does — it proves who you are, decides what you can touch, and writes down everything you did.

**AAA** is the security framework that handles **identity verification (Authentication)**, **permission enforcement (Authorization)**, and **activity logging (Accounting)** for users and devices accessing a system.

## Why it matters

Skip authentication and anyone walks in. Skip authorization and a logged-in intern deletes the production database. Skip accounting and you can't prove who did it, which means no forensics, no compliance (PCI DSS, HIPAA, SOX all require audit trails), and no insurance payout. SY0-701 Objective 1.2 explicitly tests **Authenticating people**, **Authenticating systems**, and **Authorization models** — the trap CompTIA loves is conflating *authentication* with *authorization*. Memorize: AuthN = who, AuthZ = what.

## Key facts

### The three A's

| Phase | Question Answered | Mechanism Examples |
|-------|-------------------|---------------------|
| **Authentication** | Who are you? | [[Passwords]], [[MFA]], [[Biometrics]], [[Certificates]], [[Kerberos]] tickets |
| **Authorization** | What can you do? | [[RBAC]], [[ABAC]], [[MAC]], [[DAC]], [[Rule-based access control]] |
| **Accounting** | What did you do? | [[Audit logs]], [[SIEM]], [[Syslog]], session records |

### Authenticating people

- **Something you know** — password, PIN, security question
- **Something you have** — [[Smart card]], [[Hardware token]], phone for [[TOTP]]
- **Something you are** — [[Biometrics]]: fingerprint, retina, facial geometry
- **Somewhere you are** — [[Geolocation]], IP-based
- **Something you do** — keystroke dynamics, gait

Combining two or more distinct factors = [[Multi-factor authentication]]. Two passwords is **not** MFA. CompTIA will test that.

### Authenticating systems

Machines need identity too. A rogue server is an attacker's playground.

- **[[Digital certificates]]** — X.509, signed by a [[Certificate Authority]]
- **[[Mutual TLS]]** — both sides present certs
- **[[802.1X]]** — port-based network access control, often with [[EAP-TLS]]
- **[[Kerberos]]** — mutual authentication via [[KDC]] tickets, port **88**
- **[[TPM]]** and **[[HSM]]** — hardware-rooted device identity

### Authorization models

| Model | How it Decides |
|-------|----------------|
| **[[DAC]]** (Discretionary) | Owner sets permissions. Windows NTFS ACLs. |
| **[[MAC]]** (Mandatory) | OS enforces labels (Top Secret, Secret). [[SELinux]]. |
| **[[RBAC]]** (Role-Based) | Permissions tied to job role. |
| **[[ABAC]]** (Attribute-Based) | Policy evaluates attributes: user, resource, time, location. |
| **[[Rule-based]]** | Conditional rules — firewall ACLs, time-of-day login. |

### Accounting essentials

- **[[Non-repudiation]]** — user can't deny the action; logs + signatures prove it
- **[[Audit trail]]** — chronological record of events
- **[[Log aggregation]]** — centralized collection so attackers can't wipe local logs
- Protocols carrying accounting data: [[RADIUS]] (UDP **1812** auth, **1813** accounting), [[TACACS+]] (TCP **49**), [[Diameter]]

### AAA protocols compared

| Protocol | Transport | Encryption | Use Case |
|----------|-----------|------------|----------|
| **[[RADIUS]]** | UDP 1812/1813 | Password only | VPN, Wi-Fi ([[WPA2-Enterprise]]) |
| **[[TACACS+]]** | TCP 49 | Full payload | Cisco device admin |
| **[[Diameter]]** | TCP/SCTP | TLS/IPsec | 4G/5G mobile networks |
| **[[Kerberos]]** | UDP/TCP 88 | Tickets | Active Directory SSO |

### What breaks when AAA fails

- Weak AuthN → [[Credential stuffing]], [[Pass-the-hash]], account takeover
- Broken AuthZ → [[Privilege escalation]], [[Insecure direct object reference]]
- Missing accounting → no forensics, failed audit, regulatory fines

## Related concepts

[[Identity and Access Management]] · [[Single Sign-On]] · [[Federation]] · [[SAML]] · [[OAuth 2.0]] · [[OpenID Connect]] · [[Privileged Access Management]] · [[Zero Trust]] · [[Least Privilege]]

---
*Source: VIRGIL knowledge base — 2026-05-08*