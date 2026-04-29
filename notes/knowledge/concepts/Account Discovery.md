# Account Discovery

## What it is
Like a burglar who finds a house key and immediately checks every door to map out who lives where, an attacker who gains initial access will enumerate all user accounts to understand the target environment. Account Discovery (MITRE ATT&CK T1087) is a reconnaissance technique where adversaries query systems, directories, or cloud environments to list valid user accounts and groups, identifying high-value targets like administrators for further exploitation.

## Why it matters
After the SolarWinds breach, attackers used Account Discovery to enumerate Active Directory accounts and identify privileged service accounts, which they then used to move laterally across government networks undetected for months. Defenders monitoring for unusual LDAP queries or bulk `net user /domain` commands could have flagged this activity early in the kill chain.

## Key facts
- **Common commands used:** `net user`, `net localgroup administrators`, `whoami /all` (Windows); `cat /etc/passwd`, `id`, `getent passwd` (Linux)
- **Cloud variant (T1087.004):** Attackers use AWS CLI (`aws iam list-users`), Azure AD queries, or Google Workspace APIs to discover cloud accounts
- **Detection signal:** Bulk or rapid account enumeration queries in SIEM logs, especially from non-admin accounts or off-hours activity
- **Sub-techniques include:** Local accounts (T1087.001), Domain accounts (T1087.002), Email accounts (T1087.003), and Cloud accounts (T1087.004)
- **Mitigation:** Restrict access to directory enumeration tools, apply least privilege, and alert on `net user` or LDAP queries from unusual sources

## Related concepts
[[Privilege Escalation]] [[Lateral Movement]] [[Active Directory Enumeration]] [[MITRE ATT&CK Framework]] [[Credential Access]]