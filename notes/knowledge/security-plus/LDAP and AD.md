# LDAP and AD

## What it is
Think of Active Directory as a corporate phonebook combined with a bouncer's clipboard — it stores every user, computer, and permission in an organization, and LDAP is the specific language you use to query it. LDAP (Lightweight Directory Access Protocol) is an open protocol for reading and writing directory services, while Active Directory (AD) is Microsoft's implementation of a directory service that uses LDAP as one of its core communication protocols. AD runs on port 389 (LDAP) and port 636 (LDAPS, the encrypted version).

## Why it matters
In a Pass-the-Hash or Kerberoasting attack, adversaries authenticate against Active Directory using stolen credential material rather than plaintext passwords — they're abusing AD's central role as the authentication authority for the entire domain. Defenders monitor LDAP query traffic for signs of enumeration, where attackers dump the entire directory (users, groups, SPNs) to map the network before lateral movement. Tools like BloodHound specifically query AD via LDAP to visualize attack paths to Domain Admin.

## Key facts
- LDAP uses port **389** (cleartext) and port **636** (LDAPS over TLS); cleartext LDAP exposes credentials to sniffing
- Active Directory stores objects in a hierarchical structure: Forest → Domain → Organizational Units (OUs)
- **LDAP injection** is an attack where unsanitized user input manipulates LDAP queries, similar to SQL injection
- AD uses **Kerberos** as its primary authentication protocol (port 88), with NTLM as a fallback — both are frequent attack targets
- **Anonymous LDAP bind** (null session) can expose directory information without authentication if misconfigured — a common finding in penetration tests

## Related concepts
[[Kerberos Authentication]] [[Pass-the-Hash]] [[Privilege Escalation]]