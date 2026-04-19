---
domain: "4.0 - Security Operations"
section: "4.1"
tags: [security-plus, sy0-701, domain-4, wireless-security, authentication, aaa-framework]
---

# 4.1 - Wireless Security Settings (continued)

Wireless security settings determine how users authenticate and gain access to wireless networks, with methods ranging from open (no security) to enterprise-grade centralized authentication. This section covers the [[AAA framework]] (Authentication, Authorization, Accounting), wireless security modes ([[WPA3-Personal]], [[WPA3-Enterprise]]), and critical protocols like [[RADIUS]], [[IEEE 802.1X]], and [[EAP]]. For the Security+ exam, you must distinguish between pre-shared key models and centralized authentication, understand the role of authentication servers, and be able to recommend appropriate security modes based on use cases.

---

## Key Concepts

- **[[AAA Framework]]** – The foundational security model with three components:
  - **Identification**: Who you claim to be (typically username)
  - **Authentication**: Proof of identity through credentials, passwords, and/or [[MFA]] factors
  - **Authorization**: Access permissions granted based on authenticated identity
  - **Accounting**: Resource tracking (login/logout times, data usage, session duration)

- **Wireless Authentication Methods**:
  - **Pre-Shared Key (PSK)** / Shared Password – Single key shared by all users; simple but not scalable
  - **Centralized Authentication** – [[IEEE 802.1X]] with [[RADIUS]], [[LDAP]], or [[TACACS+]]; individual user credentials validated by authentication server

- **Wireless Security Modes**:
  - **Open System** – No authentication; anyone can connect (highest risk, sometimes used for guest networks with [[Captive Portal]])
  - **[[WPA3-Personal]] / [[WPA3-PSK]]** – Everyone shares the same 256-bit pre-shared key; suitable for home/small office
  - **[[WPA3-Enterprise]] / [[WPA3-802.1X]]** – Individual authentication via [[RADIUS]]; each user has unique credentials; required for compliance and enterprise environments

- **[[RADIUS]] (Remote Authentication Dial-in User Service)**:
  - Industry-standard [[AAA]] protocol supporting authentication, authorization, and accounting
  - Centralizes user credential validation across multiple network devices (routers, switches, firewalls, [[VPN]] gateways)
  - Works with [[IEEE 802.1X]] for network access control
  - Available on virtually any server operating system
  - Runs on UDP ports 1812 (authentication) and 1813 (accounting)

- **[[IEEE 802.1X]] (Port-Based Network Access Control – NAC)**:
  - Controls network access at the port level—users cannot access network resources until successfully authenticated
  - Requires integration with an authentication database ([[RADIUS]], [[LDAP]], [[TACACS+]])
  - Prevents [[VLAN]] hopping and unauthorized network access
  - Defines three roles:
    - **Supplicant** – The client device requesting access
    - **Authenticator** – The wireless access point or switch providing network access
    - **Authentication Server** – Backend server (e.g., [[RADIUS]]) validating credentials

- **[[EAP]] (Extensible Authentication Protocol)**:
  - Flexible authentication framework supporting multiple methods defined by RFC standards
  - Allows manufacturers to develop proprietary EAP methods tailored to specific environments
  - Integrates seamlessly with [[IEEE 802.1X]] to enforce network access control
  - Common EAP variants: [[EAP-TLS]], [[EAP-TTLS]], [[PEAP]], [[EAP-FAST]]
  - Prevents network access until authentication succeeds

---

## How It Works (Feynman Analogy)

**The Bouncer & The VIP List:**

Imagine a nightclub with two security approaches:

1. **Open System / PSK Mode** – The bouncer doesn't check IDs; he just lets everyone in (Open System), or everyone uses the same secret password (PSK). Fast, but no real security.

2. **Enterprise / 802.1X Mode** – The bouncer checks your ID against a master guest list (the authentication server running [[RADIUS]]). Your ID is unique (Supplicant), the bouncer is the Authenticator, and the guest list database is the Authentication Server. Only when your identity is verified do the doors unlock.

**The Technical Reality:**

When a user connects to a [[WPA3-Enterprise]] network, their device ([[Supplicant]]) sends credentials to the wireless access point ([[Authenticator]]), which relays them to a [[RADIUS]] server. The [[RADIUS]] server validates the credentials using [[EAP]] (which supports various methods like [[EAP-TLS]] for certificate-based auth or [[PEAP]] for password-based auth). Only after successful authentication does the [[IEEE 802.1X]]-controlled port transition from the "unauthorized" state to the "authorized" state, granting network access. Meanwhile, [[RADIUS]] also logs the session for [[Accounting]] purposes.

---

## Exam Tips

- **Distinguish PSK from Centralized Auth**: PSK (WPA3-Personal) = shared key for everyone; Enterprise (WPA3-802.1X) = individual credentials validated by [[RADIUS]]. The exam loves testing which mode you'd recommend for specific scenarios.

- **Know the 802.1X Roles Cold**: Supplicant (client), Authenticator (AP/switch), Authentication Server ([[RADIUS]]). Questions often ask you to identify which role does what—don't confuse them.

- **[[RADIUS]] is the AAA Protocol**: Recognize that [[RADIUS]] implements all three components of the [[AAA framework]]. The exam may ask what protocol centralizes authentication for wireless networks—the answer is [[RADIUS]] (or sometimes [[TACACS+]], but [[RADIUS]] is more common for wireless).

- **Common Exam Question Pattern**: "Which of the following is a Port-Based Network Access Control protocol?" → [[IEEE 802.1X]]. "Which protocol validates user credentials for 802.1X?" → [[RADIUS]]. "What is the framework that defines authentication methods for 802.1X?" → [[EAP]].

- **Trap Answer**: Don't confuse [[WPA2]] with [[WPA3]]. Both support Personal and Enterprise modes, but [[WPA3]] is the current standard and offers stronger encryption (256-bit vs. 128-bit). The exam expects you to recommend [[WPA3-Enterprise]] for high-security environments.

---

## Common Mistakes

- **Thinking [[IEEE 802.1X]] Works Alone**: Candidates often forget that 802.1X is a framework that *requires* a backend [[AAA]] protocol like [[RADIUS]] to actually validate credentials. 802.1X is the *gatekeeper*; [[RADIUS]] is the *credentialer*.

- **Confusing EAP Methods with EAP Itself**: [[EAP]] is the framework; [[EAP-TLS]], [[EAP-TTLS]], and [[PEAP]] are implementations. The exam tests whether you know [[EAP]] enables flexible authentication methods, not just a single method.

- **Assuming Open System is Always Bad**: While insecure, Open System is sometimes intentionally used for guest networks paired with [[Captive Portal]] authentication and [[VPN]] tunneling. The exam may ask about scenarios where Open System is appropriate—don't blindly say "never use it."

---

## Real-World Application

In **Morpheus's [YOUR-LAB] homelab**, you could implement [[WPA3-Enterprise]] by running [[RADIUS]] on a server (e.g., FreeRADIUS on a VM) and integrating it with [[Active Directory]] or [[LDAP]] for centralized user management. This allows secure wireless access across the lab while maintaining audit logs through [[RADIUS]] accounting, which feeds into [[Wazuh]] for security monitoring. For less critical infrastructure, [[WPA3-Personal]] suffices; for production homelab services requiring compliance (HIPAA, PCI-DSS), [[WPA3-Enterprise]] with [[IEEE 802.1X]] is mandatory.

---

## Wiki Links

- [[AAA Framework]] – The foundation of access control
- [[Authentication]] – Proving identity
- [[Authorization]] – Access permissions
- [[Accounting]] – Resource tracking and logging
- [[RADIUS]] – Remote Authentication Dial-in User Service
- [[TACACS+]] – Alternative centralized authentication protocol
- [[LDAP]] – Lightweight Directory Access Protocol for credential storage
- [[IEEE 802.1X]] – Port-based Network Access Control
- [[EAP]] – Extensible Authentication Protocol
- [[EAP-TLS]] – EAP with TLS certificates
- [[EAP-TTLS]] – Tunneled TLS
- [[EAP-FAST]] – Fast authentication via secure tunneling
- [[PEAP]] – Protected EAP
- [[WPA3-Personal]] – WPA3 with pre-shared key
- [[WPA3-Enterprise]] – WPA3 with centralized authentication
- [[WPA3-PSK]] – Pre-shared key variant
- [[WPA2]] – Legacy wireless security standard
- [[Encryption]] – Cryptographic protection of data
- [[TLS]] – Transport Layer Security
- [[MFA]] – Multi-factor authentication
- [[VPN]] – Virtual Private Network
- [[Captive Portal]] – Web-based network authentication
- [[VLAN]] – Virtual Local Area Network
- [[Active Directory]] – Microsoft directory service
- [[Wazuh]] – Security monitoring and SIEM platform
- [[NIST]] – National Institute of Standards and Technology
- [[Compliance]] – Meeting regulatory or organizational requirements
- [[Firewall]] – Network access control
- [[Network Security]] – Protection of network infrastructure

---

## Tags

#domain-4 #security-plus #sy0-701 #wireless-security #authentication #aaa-framework #radius #802-1x #eap #wpa3 #network-access-control #enterprise-security

---
_Ingested: 2026-04-16 00:05 | Source: professor-messer-sy0-701-comptia-security-plus-course-notes-v107.pdf_
