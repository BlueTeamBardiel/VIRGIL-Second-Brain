# Token Impersonation

## What it is
Imagine stealing a valet ticket after a car has already been authenticated at the gate — you don't need the keys, you just wave the ticket and drive out. Token impersonation is exactly that: an attacker captures or duplicates an existing Windows access token (the OS proof-of-identity object assigned after login) and uses it to execute processes under a victim's security context without knowing their password.

## Why it matters
In the Mimikatz-assisted "Pass-the-Token" technique, an attacker with local admin rights uses the `impersonate_token` command in Meterpreter to steal a Domain Admin's token from memory — instantly escalating from a workstation compromise to full domain control without ever cracking a single credential. Defenders counter this by enforcing the principle of least privilege and monitoring for anomalous token duplication events (Windows Event ID 4674).

## Key facts
- Windows tokens come in two flavors: **primary tokens** (assigned at process creation) and **impersonation tokens** (used for client-server delegation); attackers target impersonation tokens specifically
- The `SeImpersonatePrivilege` right is the critical enabler — services like IIS and SQL Server hold it by default, making them prime pivot points (see: Juicy Potato exploit)
- Token theft requires the attacker to already have **local admin or SYSTEM-level access** — it's a privilege *escalation* technique, not an initial access technique
- **Incognito** (Metasploit module) and **Mimikatz** are the two most cited tools for token manipulation in penetration testing contexts
- Mitigation includes enabling **Windows Defender Credential Guard**, restricting `SeImpersonatePrivilege`, and auditing token impersonation attempts via Advanced Audit Policy

## Related concepts
[[Privilege Escalation]] [[Pass-the-Hash]] [[Access Tokens]] [[Mimikatz]] [[Lateral Movement]]