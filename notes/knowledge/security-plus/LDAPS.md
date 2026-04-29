# LDAPS

## What it is
Think of LDAP as shouting employee records across an open office — anyone nearby can hear. LDAPS is the same directory lookup service, but now conducted in a soundproof room. Technically, LDAPS (Lightweight Directory Access Protocol Secure) is LDAP wrapped inside TLS/SSL encryption, protecting authentication credentials and directory queries transmitted between clients and an Active Directory or LDAP server.

## Why it matters
In 2019, Microsoft announced plans to disable unsigned and unencrypted LDAP binds by default — a direct response to credential-harvesting attacks where attackers performed LDAP simple binds over plaintext and captured domain credentials via network sniffing. Organizations still running legacy applications that authenticate against Active Directory without LDAPS are vulnerable to credential interception on any network segment where an attacker has achieved a listening position, making this a critical hardening step for Active Directory environments.

## Key facts
- LDAPS operates on **port 636** (vs. plain LDAP on port 389)
- Requires a valid PKI certificate installed on the Domain Controller to function
- LDAPS is distinct from **LDAP signing** — signing ensures integrity but does not encrypt the payload; LDAPS provides full confidentiality
- Starting with a March 2020 Windows Update, Microsoft enforces LDAP channel binding and signing by default, breaking legacy apps using anonymous or simple binds
- LDAPS is commonly tested on Security+ as the correct answer when asked how to secure directory service authentication traffic

## Related concepts
[[LDAP]] [[Active Directory]] [[TLS]] [[PKI]] [[Kerberos]]