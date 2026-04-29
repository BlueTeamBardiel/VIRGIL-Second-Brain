# Active Directory Search and Publication Technologies

## What it is
Think of it like a library card catalog for your entire corporate network — every resource (users, computers, printers, services) registers itself so others can find it. Active Directory Search and Publication Technologies are the mechanisms that allow objects to be **published** into the AD directory and **queried** by clients and applications using protocols like LDAP (Lightweight Directory Access Protocol) and the Global Catalog.

## Why it matters
Attackers performing internal reconnaissance heavily abuse these technologies — tools like **BloodHound** and **ldapsearch** query AD's LDAP interface to enumerate users, group memberships, and trust relationships without triggering alerts, because LDAP queries are routine network traffic. A defender monitoring for abnormally high LDAP query volumes or unauthenticated LDAP binds can detect early-stage lateral movement before privilege escalation occurs.

## Key facts
- **LDAP (port 389)** is the standard query protocol; **LDAPS (port 636)** is the encrypted version — misconfigured AD environments often allow unencrypted LDAP binds, leaking credentials
- The **Global Catalog (port 3268/3269)** is a partial replica of all AD objects across a forest, enabling cross-domain searches — a prime recon target
- **Service Publication** allows services like file shares and printers to register SPNs (Service Principal Names) in AD — attackers enumerate SPNs to identify **Kerberoastable** accounts
- **Anonymous LDAP bind** (null session) is a legacy misconfiguration that permits unauthenticated directory enumeration — should be explicitly disabled
- AD search relies on the **Distinguished Name (DN)** hierarchy (e.g., `CN=User,OU=Corp,DC=example,DC=com`) — understanding DN structure is critical for both attacks and SIEM filtering

## Related concepts
[[LDAP Injection]] [[Kerberoasting]] [[Active Directory Enumeration]]