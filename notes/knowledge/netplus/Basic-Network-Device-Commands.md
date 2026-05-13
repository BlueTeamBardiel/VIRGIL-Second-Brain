# Basic Network Device Commands

## What it is

In **Stardew Valley**, your farm starts as one undifferentiated mess of weeds and rocks. You spend the first week placing fences, paths, and gates — not because the cow needs a fence to exist, but because without one she wanders into the parsnips. You lock the coop at night because raccoons. You give Lewis the key to the shipping bin but not the house. Every secure farm is the same: **identity, boundaries, locks, and a record of who did what**. That's exactly what the basic security commands on a network device do — they decide who gets on the box, what they can touch, how their session is protected, and what gets logged when they touch something.

In N10-009 terms: **basic network device security** is the bundle of configuration commands and policies — authentication, authorization, accounting, encryption, segmentation, physical controls, and logging — that turn a default-config switch or router into something you'd let near a production network. Objective 4.1 expects you to know the *concepts*, not the exact Cisco IOS syntax.

## Why it matters

Default-config network gear is a gift to attackers. Telnet open, admin/admin credentials, no ACLs, no logging, every port a trunk. The first job of anyone touching a device in anger is to harden it. The exam tests whether you understand the *concepts* — encryption in transit, least privilege, MFA, RBAC, PKI, segmentation — not vendor-specific commands. Get the concepts right now and the syntax is a lookup. Get them wrong and you'll be the engineer who left SSH version 1 enabled on the edge router.

This maps directly to Objective 4.1: logical security, physical security, deception technologies, and common security terminology.

## Key facts

### The CIA triad — the lens everything else passes through

- **Confidentiality** — only authorized parties can read it. Encryption, ACLs, RBAC.
- **Integrity** — data hasn't been tampered with. Hashes, digital signatures, change logs.
- **Availability** — the system is up when needed. Redundancy, DDoS protection, backups.

Every control you configure on a device serves one or more of these. SSH? Confidentiality and integrity. Port security? Availability and integrity. *If you can't tell me which leg of the triad a control supports, you don't understand the control yet.*

### Common security terminology

| Term | Definition | Example |
|------|-----------|---------|
| **Threat** | A potential cause of harm | A malicious insider |
| **Vulnerability** | A weakness that can be exploited | Telnet enabled on the switch |
| **Exploit** | The technique used against a vuln | Sniffing the cleartext Telnet password |
| **Risk** | Threat × vulnerability × impact | The probability and cost of that capture |

A threat is a *who* or *what*. A vulnerability is a *hole*. An exploit is the *act*. Risk is the *math*.

### Authentication, authorization, accounting (AAA)

Three different questions:

- **Authentication** — who are you? (password, certificate, MFA)
- **Authorization** — what are you allowed to do? (RBAC, ACL)
- **Accounting** — what did you do? (syslog, audit trail)

AAA is delivered by [[RADIUS]] or [[TACACS+]] — servers your device talks to instead of checking a local username database.

| Feature | RADIUS | TACACS+ |
|---------|--------|---------|
| Transport | UDP 1812/1813 | TCP 49 |
| Encryption | Password only | Entire packet |
| Vendor | Open (RFC) | Cisco (open spec now) |
| Use case | Network access (Wi-Fi, VPN, 802.1X) | Device admin (router/switch login) |
| AAA separation | Combines authN + authZ | Separates all three |

> **CompTIA exam trap:** RADIUS encrypts the password only; TACACS+ encrypts the whole payload. RADIUS = UDP, TACACS+ = TCP 49. *Who can log into the switch CLI* → TACACS+. *Who can join the Wi-Fi* → RADIUS.

### Authentication factors and MFA

The three factors:
- **Something you know** — password, PIN
- **Something you have** — token, smart card, phone
- **Something you are** — fingerprint, face, retina

Sometimes a fourth and fifth — **somewhere you are** (geofencing) and **something you do** (behavior). **MFA** means two or more *different* categories. Two passwords is not MFA. Password + SMS code is.

**Time-based authentication** — TOTP (the 6-digit code that rotates every 30 seconds). Device and server share a seed, both run the clock, both compute the same number. *Clock drift on a network device will silently break TOTP — keep [[NTP]] healthy.*

### Authorization models

- **Role-based access control (RBAC)** — permissions attach to roles, users get roles. The helpdesk role can reset passwords; the network engineer role can modify routing.
- **Least privilege** — every account gets the minimum it needs. The monitoring account reads SNMP; it doesn't get enable mode.
- **Single sign-on (SSO)** — one authentication grants access to many systems. Implemented via [[SAML]] (web apps, XML assertions) or **LDAP**/Active Directory (TCP 389 / 636 for LDAPS).

> **CompTIA exam trap:** LDAP is 389 cleartext, LDAPS is 636 over TLS. SAML is the SSO standard for web apps and uses XML assertions through the browser. Kerberos is the AD authentication protocol underneath. Don't confuse the directory (LDAP) with the SSO assertion format (SAML).

### Encryption — data in transit vs data at rest

- **Data in transit** — moving across the wire. Protect with TLS, SSH, IPsec, WPA3.
- **Data at rest** — sitting on disk. Full-disk encryption (BitLocker, LUKS), encrypted backups.
- **Data in use** — in RAM, being processed. Hardest to protect; secure enclaves are the bleeding edge.

On a network device: **disable Telnet, enforce SSHv2.** Telnet sends the admin password as cleartext. Any tap, any span port, any mirror — captured.

### PKI, certificates, and self-signed

**Public key infrastructure (PKI)** is the framework: CAs, certificates, keys, revocation lists. A **certificate** binds a public key to an identity, signed by a CA the client already trusts.

- **CA-signed cert** — browser trusts it automatically because it trusts the CA.
- **Self-signed cert** — the device signs its own cert. Encrypts the same way, but no one trusts the signer except whoever manually accepts it. Fine for lab and internal-only management. Never on a public-facing service.

*A self-signed cert encrypts traffic just as well as a paid one. What it doesn't do is prove who's on the other end. That's the whole point of the CA.*

### Network segmentation enforcement

[[VLANs]], subnets, and ACLs slice the LAN into zones. A flat network means a compromised printer can talk to the domain controller. A segmented network means the printer VLAN can talk to the print server and nothing else.

- **Guest network** — separate SSID, separate VLAN, internet-only, no LAN visibility.
- **BYOD** — personal devices on a dedicated VLAN with NAC posture checks and MDM enrollment.
- **IoT / SCADA / ICS / OT** — smart thermostats, factory PLCs, water-treatment controllers. Hardcoded creds, no patches, decades-old firmware. Stuxnet and Colonial Pipeline were both IT-to-OT bridge failures. *Operational technology on the same VLAN as the office printer is a résumé-generating event waiting to happen.*

### Geofencing

Location-based access. The MDM refuses corporate email if the phone is outside the country. Coarse, easily defeated by VPN — but it raises the cost of an attack.

### Physical security — the layer below logical

All the SSH in the world is useless if someone walks out with the switch.

- **Locks** — server room door, rack door, cable lock. Mechanical, electronic, biometric.
- **Cameras** — deterrent and forensic. Cover entrances, racks, and any port someone could reach.
- **Badge readers, mantraps, tailgating policy** — controls on who gets into the room at all.
- **Console port access** — anyone with physical access and a console cable can password-recover most network gear. Lock the rack.

### Deception technologies

- **Honeypot** — a single fake system that looks valuable. Anything touching it is suspicious by definition.
- **Honeynet** — a whole fake network of honeypots. Lets you watch attacker movement, not just initial contact.

### Audits and regulatory compliance

- **PCI DSS** — anyone storing, processing, or transmitting cardholder data. Demands segmentation of the cardholder data environment, logging, encryption in transit, quarterly scans.
- **GDPR** — EU personal data law. Drives **data locality**, breach notification timelines, right-to-erasure.
- **HIPAA** — US health information. PHI confidentiality and integrity.

**Data locality** matters because GDPR says EU resident data shouldn't casually traverse to jurisdictions without adequate protection. Your cloud region choice is now a compliance decision.

### CompTIA exam traps

> **CompTIA exam trap:** *Authentication* proves identity; *authorization* grants permissions. The login succeeded (authN) but you got "permission denied" on `show running-config` (authZ failure).

> **CompTIA exam trap:** Self-signed certificates encrypt traffic but don't establish trust. The browser warning is about *trust*, not *encryption strength*.

> **CompTIA exam trap:** RBAC ≠ MAC ≠ DAC. Role-based attaches permissions to roles. Mandatory uses labels (military classifications). Discretionary lets the resource owner decide. Net+ mostly cares about RBAC.

## Helpdesk reality

- User says: *"I can't log into the VPN."* Check: is their MFA token in sync? Did their AD password expire? Is the cert on their laptop still valid? In that order.
- User says: *"The website says it's not secure."* Almost always an expired or self-signed cert on an internal service. Renew the cert; don't tell the user to "click through."
- Never promise a user you'll "just give them admin" to fix something faster. That promise becomes a ticket auditor's question six months later.
- If you find Telnet enabled, default credentials, or SNMPv1 with community string "public" on a production device — P1, not a backlog item. Document, escalate, fix in a change window.
- Physical first. If you can't log in to the switch and the link lights are off, walk to the rack before you open a remote session.

## Related concepts

[[RADIUS]] · [[TACACS+]] · [[SAML]] · [[LDAP]] · [[Kerberos]] · [[VLANs]] · [[ACLs]] · [[SSH]] · [[TLS]] · [[IPsec]] · [[WPA3]] · [[NTP]] · [[SNMP]] · [[Syslog]] · [[Network Segmentation]] · [[Zero Trust]] · [[NAC]] · [[MDM]]

*Source: VIRGIL knowledge base — 2026-05-11*