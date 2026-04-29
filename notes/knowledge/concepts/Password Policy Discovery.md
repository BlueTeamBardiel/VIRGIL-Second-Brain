# Password Policy Discovery

## What it is
Like a burglar casing a bank vault by reading the posted security guidelines on the lobby wall, Password Policy Discovery is the technique attackers use to enumerate an organization's password rules before crafting or guessing credentials. It is the reconnaissance act of learning minimum length, complexity requirements, lockout thresholds, and history rules — turning defensive policies into an attacker's roadmap.

## Why it matters
During a red team engagement, an attacker who discovers that a domain enforces only 8-character passwords with no complexity requirements can dramatically narrow a brute-force wordlist, cutting attack time from weeks to hours. Conversely, a defender who audits their own policy via `net accounts` or LDAP queries can identify dangerously weak settings before adversaries do. This technique maps directly to MITRE ATT&CK T1201.

## Key facts
- **Windows command**: `net accounts` reveals lockout threshold, minimum password length, and password age for local policy; `net accounts /domain` queries domain policy
- **Linux command**: `/etc/pam.d/common-password` and `/etc/login.defs` store password complexity and age settings that can be read if file permissions are misconfigured
- **LDAP enumeration**: Tools like `ldapsearch` or `enum4linux` can pull Active Directory password policies without authentication in misconfigured environments
- **Lockout threshold discovery matters**: Knowing the lockout count (e.g., 5 attempts) allows attackers to spray exactly 4 passwords per account across thousands of users — staying under the wire
- **MITRE ATT&CK T1201** classifies this as a Discovery technique; it commonly precedes Credential Access tactics like password spraying or brute force

## Related concepts
[[Password Spraying]] [[Account Lockout Policy]] [[LDAP Enumeration]] [[Credential Access]] [[Active Directory Reconnaissance]]