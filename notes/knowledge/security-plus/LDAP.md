# LDAP

## What it is
Think of LDAP like a corporate phone book with a strict filing system — you look up "John in Accounting" and get his extension, email, and access badge level all at once. Precisely, LDAP (Lightweight Directory Access Protocol) is a protocol used to query and modify directory services, most commonly Microsoft Active Directory, running over TCP port 389 (or 636 for LDAPS). It organizes network resources — users, groups, devices — into a hierarchical tree structure called the Directory Information Tree (DIT).

## Why it matters
LDAP injection attacks work like SQL injection but against directory services — an attacker manipulates an unsanitized LDAP query (e.g., stuffing `)(uid=*)` into a login field) to bypass authentication or dump all user records from Active Directory. This is a critical attack vector in web applications that authenticate users against an LDAP backend. Proper input sanitization and using LDAPS (port 636) with TLS encryption prevent both injection and credential interception.

## Key facts
- **Port 389** = plaintext LDAP; **Port 636** = LDAPS (encrypted with TLS/SSL) — Security+ loves this distinction
- LDAP uses a **DN (Distinguished Name)** to uniquely identify entries: `CN=JohnDoe,OU=Accounting,DC=corp,DC=com`
- **Anonymous bind** is an LDAP misconfiguration allowing unauthenticated queries — attackers use it for reconnaissance to enumerate users and groups
- LDAP is the underlying query protocol for **Active Directory**; Kerberos handles the authentication tickets, but LDAP handles directory lookups
- LDAP injection is listed in the **OWASP Top 10** (Injection category) and is testable on CySA+ exam scenarios

## Related concepts
[[Active Directory]] [[Kerberos]] [[LDAP Injection]] [[Directory Services]] [[Port Security]]