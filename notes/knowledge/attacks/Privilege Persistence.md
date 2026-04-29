# Privilege Persistence

## What it is
Like a contractor who makes a copy of your house key before you revoke their access badge, privilege persistence is when an attacker maintains elevated access even after the initial vulnerability is patched or credentials are changed. Precisely, it refers to techniques used to retain high-level system privileges across reboots, password resets, and remediation attempts — ensuring the attacker doesn't lose their foothold.

## Why it matters
In the 2020 SolarWinds breach, attackers implanted a backdoor that created new service accounts and Golden Ticket credentials, meaning that even if the compromised SolarWinds binary was removed, they retained Domain Admin-level access through forged Kerberos tickets. Defenders had to treat the *entire Active Directory as compromised* and rebuild trust infrastructure — not just patch a single vulnerability.

## Key facts
- **Golden Ticket attacks** forge Kerberos TGTs using the KRBTGT account hash, granting persistent Domain Admin access valid for 10 years by default
- **Scheduled Tasks and Services** are among the most common persistence mechanisms cataloged in MITRE ATT&CK (T1053, T1543)
- Attackers often create **shadow admin accounts** — accounts with no obvious group memberships but with ACL-level permissions that survive group audits
- **DLL hijacking** can persist privileges by placing malicious DLLs in paths searched before legitimate system directories, re-executing on every boot
- Detecting persistence requires **baselining** — comparing current scheduled tasks, services, and registry run keys against a known-good snapshot

## Related concepts
[[Privilege Escalation]] [[Lateral Movement]] [[Golden Ticket Attack]] [[MITRE ATT&CK Framework]] [[Persistence Mechanisms]]