---
domain: "Identity and Access Management"
tags: [authentication, iam, protocols, kerberos, radius, ldap]
---
# Authentication Server

An **authentication server** is a networked system responsible for verifying the identity of users, devices, or services before granting access to protected resources. It acts as a trusted third party in the [[AAA Framework]] (Authentication, Authorization, and Accounting), separating the credential verification function from the applications and services that consume it. Common implementations include [[RADIUS]], [[LDAP]]-based directory services, [[Kerberos]] Key Distribution Centers, and modern identity providers using [[OAuth 2.0]] and [[SAML]].

---

## Overview

Authentication servers exist to centralize identity verification in environments where many services, devices, or users need to prove who they are. Without a dedicated authentication server, each application would need to maintain its own credential store — a model that scales poorly, creates inconsistent security policies, and multiplies the attack surface. Centralizing authentication allows administrators to enforce uniform password policies, multi-factor authentication requirements, and access logging from a single control point.

The concept traces back to early distributed computing, when organizations began deploying networks too large for per-host user accounts. MIT's [[Kerberos]] protocol, developed in the 1980s as part of Project Athena, was one of the first formalized authentication server architectures. It introduced the notion of a **Key Distribution Center (KDC)** — a trusted server that issues cryptographic tickets allowing clients to prove their identity to services without transmitting passwords over the network. This ticket-based model remains the backbone of Active Directory authentication in enterprise Windows environments today.

Modern authentication servers have evolved significantly beyond simple username/password verification. Contemporary systems integrate **multi-factor authentication (MFA)**, **certificate-based authentication**, **federation** (trusting identities from external organizations), and **risk-based adaptive authentication** that challenges users based on behavioral signals like login location, device posture, or time of day. Products like Microsoft Entra ID (formerly Azure AD), Okta, Ping Identity, and open-source solutions like FreeIPA and Keycloak represent the current state of the art.

In the context of network access control, **RADIUS (Remote Authentication Dial-In User Service)** and its successor **DIAMETER** serve as authentication servers for VPN gateways, Wi-Fi access points (via [[802.1X]]), and network equipment. When a user connects to a corporate Wi-Fi network, the access point acts as a RADIUS client, forwarding credentials to the RADIUS server, which consults a backend directory (like Active Directory) and returns an accept or reject decision — all within milliseconds.

Authentication servers are high-value targets in any environment. Compromise of an authentication server is effectively a compromise of every system that trusts it. This is why incidents like the **2020 SolarWinds breach** and **Golden Ticket attacks** against Kerberos KDCs are so devastating — attackers who control the authentication plane can forge identities for any user or service in the domain.

---

## How It Works

Authentication server operation varies by protocol, but the general flow involves a **supplicant** (the entity claiming an identity), an **authenticator** (the device or service enforcing access), and the **authentication server** itself. Below are the detailed mechanics of the three most common authentication server types:

### Kerberos (Active Directory / KDC)

Kerberos operates on **port 88 (TCP/UDP)**. The KDC contains two logical services: the **Authentication Service (AS)** and the **Ticket-Granting Service (TGS)**.

**Step-by-step flow:**

1. **AS-REQ**: The client sends a cleartext username and a timestamp encrypted with the user's password-derived key to the KDC's Authentication Service.
2. **AS-REP**: If the username exists, the KDC returns a **Ticket-Granting Ticket (TGT)** encrypted with the `krbtgt` account's secret key, and a session key encrypted with the user's key. The client cannot read the TGT — only the KDC can.
3. **TGS-REQ**: To access a specific service (e.g., a file server), the client presents the TGT to the Ticket-Granting Service and requests a **Service Ticket** for the target Service Principal Name (SPN).
4. **TGS-REP**: The KDC returns a Service Ticket encrypted with the target service's key, along with a session key for communicating with that service.
5. **AP-REQ**: The client presents the Service Ticket directly to the target service, which decrypts it using its own key and verifies the authenticator.

```bash
# Check Kerberos ticket cache on Linux (MIT Kerberos)
klist

# Request a TGT manually
kinit username@DOMAIN.COM

# List Service Tickets
klist -v

# Test KDC reachability
nmap -p 88 -sU -sT <domain-controller-ip>
```

### RADIUS Authentication

RADIUS uses **UDP port 1812** for authentication/authorization and **UDP port 1813** for accounting (legacy: 1645/1646). All RADIUS packets are signed with an MD5-based shared secret.

**Step-by-step flow (802.1X Wi-Fi example):**

1. Client (supplicant) associates with a Wi-Fi access point and begins [[EAP]] negotiation.
2. The access point (RADIUS client/authenticator) encapsulates EAP messages inside RADIUS **Access-Request** packets, forwarding them to the RADIUS server.
3. The RADIUS server processes the EAP method (e.g., PEAP, EAP-TLS) and may challenge the client multiple times.
4. Upon successful credential verification against Active Directory or a local database, the RADIUS server sends an **Access-Accept** packet with optional attributes (VLAN assignment, ACLs).
5. The access point opens the controlled port, granting network access.

```text
# Sample FreeRADIUS clients.conf entry
client corporate-ap-01 {
    ipaddr          = 192.168.10.5
    secret          = SuperSecretSharedKey123!
    shortname       = corp-ap-01
    nas_type        = other
}

# Test RADIUS authentication from command line
radtest john.doe Password123 127.0.0.1 0 testing123

# Expected success response:
# Received Access-Accept Id 123 from 127.0.0.1:1812
```

### LDAP-Based Authentication (e.g., OpenLDAP, Active Directory)

LDAP authentication uses **port 389 (plaintext/StartTLS)** or **port 636 (LDAPS)**. Applications bind to the directory with a service account, then perform a user lookup and credential validation.

```bash
# Test LDAP bind and search
ldapsearch -x -H ldap://dc01.corp.local \
  -D "cn=svc-ldap,ou=ServiceAccounts,dc=corp,dc=local" \
  -w 'ServicePassword' \
  -b "dc=corp,dc=local" \
  "(sAMAccountName=john.doe)" cn mail memberOf

# Test LDAPS
openssl s_client -connect dc01.corp.local:636 -showcerts
```

### SAML / OIDC Flow (Modern IdP)

Modern **Identity Providers (IdPs)** like Keycloak or Okta operate over **HTTPS (port 443)** using [[SAML 2.0]] or [[OpenID Connect]]:

1. User accesses a **Service Provider (SP)** (e.g., a web app).
2. SP redirects to the IdP with a SAML AuthnRequest or OIDC authorization request.
3. IdP authenticates the user (password + MFA if required).
4. IdP issues a signed **SAML Assertion** or **ID Token (JWT)** to the SP.
5. SP validates the signature against the IdP's public certificate and establishes a session.

---

## Key Concepts

- **Ticket-Granting Ticket (TGT)**: In Kerberos, a cryptographic credential issued by the Authentication Service that proves a user has authenticated. The TGT is used to request Service Tickets without re-entering credentials, enabling **Single Sign-On (SSO)**. TGTs have a default lifetime of 10 hours in Active Directory.
- **Service Principal Name (SPN)**: A unique identifier for a service instance in Kerberos environments. SPNs are registered in Active Directory and tie service accounts to the services they run, enabling clients to request the correct Service Ticket. Misconfigured or duplicate SPNs cause Kerberos failures and are targeted in **Kerberoasting** attacks.
- **Shared Secret**: In RADIUS, a pre-shared password configured on both the RADIUS server and the RADIUS client (NAS device). All RADIUS packet integrity checking relies on this secret via MD5 HMAC. A weak or reused shared secret is a critical vulnerability.
- **EAP (Extensible Authentication Protocol)**: A framework used over RADIUS that supports multiple authentication methods. **EAP-TLS** uses mutual certificate authentication (strongest). **PEAP-MSCHAPv2** uses a server certificate with username/password (common but attackable via rogue AP). **EAP-TTLS** tunnels credentials within a TLS session.
- **Bind Operation (LDAP)**: The LDAP operation by which a client authenticates to the directory server. An **anonymous bind** provides read access to public attributes; an **authenticated bind** uses a DN and password. Applications should use **service accounts with least privilege** for bind operations, never admin accounts.
- **Federation**: A trust relationship between authentication domains that allows identities from one organization (the **Identity Provider**) to be accepted by services in another (the **Service Provider**) without creating duplicate accounts. Implemented via SAML, OIDC, or WS-Federation.
- **Credential Store Backend**: The actual database the authentication server checks credentials against. RADIUS servers typically proxy to Active Directory via [[LDAP]] or [[Kerberos]]; standalone servers may use flat files, SQL databases, or hardware token systems.

---

## Exam Relevance

**Security+ SY0-701 Domain Mapping:** Authentication servers appear primarily in **Domain 4.0 – Security Operations** and **Domain 1.0 – General Security Concepts**, specifically under authentication, authorization, and identity management.

**High-Frequency Exam Topics:**
- **RADIUS vs. TACACS+**: RADIUS encrypts only the password field; **TACACS+** encrypts the entire payload and separates authentication, authorization, and accounting into distinct functions. TACACS+ uses **TCP port 49**. RADIUS uses **UDP 1812/1813**. On the exam, TACACS+ is preferred for **device administration** (network equipment); RADIUS is preferred for **network access** (VPN, Wi-Fi).
- **Kerberos components**: Know that the **KDC** contains both the AS and TGS. Know the **krbtgt** account — its hash is used to sign TGTs, and compromising it enables **Golden Ticket** attacks (forged TGTs that never expire).
- **Authentication factors**: Authentication servers verify factors — know **something you know** (password), **something you have** (smart card, OTP token), **something you are** (biometric). Authentication servers enforce which factors are required.
- **SSO and Federation**: Know that SSO is enabled by Kerberos TGTs or SAML assertions. Federation extends SSO across organizational boundaries.

**Common Gotchas:**
- LDAP is a **directory protocol**, not natively an authentication protocol, though it is used for authentication via bind operations.
- Kerberos requires **clock synchronization** within 5 minutes (default) — time skew causes authentication failures, not password errors.
- RADIUS shared secrets hashed with **MD5** are considered weak; always use long, random secrets and prefer **RADSEC** (RADIUS over TLS) for transport security.
- Don't confuse **authentication** (proving identity) with **authorization** (what you can do) — the authentication server primarily handles the former, though RADIUS Access-Accept packets can carry authorization attributes.

---

## Security Implications

Authentication servers are among the most critical and targeted systems in any network. Their compromise grants an attacker the ability to impersonate any identity in the environment.

**Kerberos Attack Surface:**
- **Pass-the-Ticket (PtT)**: Stolen TGTs or Service Tickets can be injected into a session using tools like **Mimikatz** (`kerberos::ptt`), allowing lateral movement without knowing passwords.
- **Golden Ticket Attack**: Attackers who obtain the **NTLM hash of the krbtgt account** (possible after Domain Controller compromise) can forge arbitrary TGTs for any user, including non-existent ones, with any group membership and any expiry time. Detection requires monitoring for tickets with anomalous lifetimes (>10h) or tickets for accounts not in current event logs.
- **Kerberoasting**: Attackers request Service Tickets for accounts with SPNs registered, extract the ticket, and crack it offline. Service accounts often have weak passwords and never expire. **CVE-2022-33647** and related research have highlighted RC4 downgrade attacks that make cracking easier.
- **AS-REP Roasting**: Accounts with pre-authentication disabled can have their AS-REP captured and cracked offline without any credentials.

**RADIUS Attack Surface:**
- **RADIUS Blast (CVE-2024-3596)**: A critical vulnerability in the RADIUS protocol allowing on-path attackers to forge Access-Accept responses using MD5 chosen-prefix collision attacks. Fixed by deploying **Message-Authenticator** attribute in all packets.
- **Rogue RADIUS Server / Evil Twin**: An attacker sets up a rogue Wi-Fi AP that accepts 802.1X connections; if clients use PEAP-MSCHAPv2 without validating the server certificate, credentials can be captured and cracked offline using tools like **hostapd-wpe** and **asleap**.
- **RADIUS Shared Secret Brute Force**: Tools like **nmap's radius-brute** script can attempt to enumerate valid shared secrets.

**LDAP Attack Surface:**
- **LDAP Null Base Bind**: Misconfigurations allowing anonymous binds can expose the entire directory structure.
- **LDAP Injection**: Applications constructing LDAP queries from user input are vulnerable to filter manipulation — e.g., injecting `)(uid=*)` to bypass authentication logic.
- **Credential Stuffing Against LDAP Bind**: LDAP bind operations generate authentication events; high-volume failed binds indicate a credential stuffing attack.

**Real-World Incidents:**
- **2020 SolarWinds/SUNBURST**: Attackers pivoted to Active Directory through SAML token forgery after compromising the ADFS signing certificate — effectively attacking the authentication server's trust chain.
- **2021 Microsoft Exchange ProxyLogon**: Included SSRF that bypassed authentication, demonstrating that authentication servers only protect systems that actually enforce authentication.

---

## Defensive Measures

**Kerberos / Active Directory Hardening:**
```powershell
# Disable RC4 encryption for Kerberos (enforce AES-only)
# Set via Group Policy: Computer Configuration > Windows Settings >
# Security Settings > Local Policies > Security Options
# "Network security: Configure encryption types allowed for Kerberos"
# Uncheck DES, RC4; Check AES128, AES256

# Find accounts with pre-authentication disabled (AS-REP Roasting targets)
Get-ADUser -Filter {DoesNotRequirePreAuth -eq $true} -Properties DoesNotRequirePreAuth

# Fix: Enable pre-authentication
Set-ADAccountControl -Identity vulnerable_user -DoesNotRequirePreAuth $false

# Find Kerberoastable accounts (have SPNs)
Get-ADUser -Filter {ServicePrincipalName -ne "$null"} -Properties ServicePrincipalName, PasswordLastSet

# Rotate krbtgt password (do TWICE, 10+ hours apart, to invalidate all tickets)
# Use Microsoft's krbtgt password reset script from GitHub
```

**RADIUS Hardening:**
- Always enable the **Message-Authenticator** attribute on all Access-Request and Access-Accept packets (mitigates CVE-2024-3596).
- Deploy **RADSEC** (RADIUS over TLS, port 2083) to encrypt all RADIUS traffic in transit.
- Use unique, 32+ character random shared secrets per NAS device.
- Configure certificate validation on all 802.1X supplicants to prevent rogue AP attacks — clients must verify the RADIUS server's certificate CN/SAN before submitting credentials.
- Deploy **Network Policy Server (Windows NPS)