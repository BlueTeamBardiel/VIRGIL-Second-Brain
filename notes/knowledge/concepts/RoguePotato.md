# RoguePotato

## What it is
Like a corrupt building superintendent who tricks the master key system into granting them owner-level access, RoguePotato is a Windows privilege escalation exploit that abuses the DCOM/OXID resolver mechanism to coerce a SYSTEM-level token into authenticating against an attacker-controlled endpoint. It is the evolved successor to JuicyPotato, designed specifically to bypass the COM server restrictions Microsoft introduced in Windows 10 version 1809 and Server 2019.

## Why it matters
In a penetration test where an attacker has landed a shell as a low-privileged service account (e.g., `IIS APPPOOL\DefaultAppPool`), RoguePotato can escalate that foothold to SYSTEM in minutes. This is critical because service accounts often hold `SeImpersonatePrivilege`, which is the exact permission the exploit weaponizes — making it a frequent post-exploitation pivot on unpatched Windows servers.

## Key facts
- **Requires `SeImpersonatePrivilege` or `SeAssignPrimaryTokenPrivilege`** — typically held by IIS, SQL Server, and similar service accounts
- **Abuses OXID Resolver** — it redirects the DCOM resolver to a fake local RPC listener on port 135, forcing a SYSTEM-level NTLM authentication the attacker can impersonate
- **Bypasses CLSID restrictions** in JuicyPotato by using a fixed OXID resolver trick instead of enumerating vulnerable COM objects
- **Tool artifacts**: Requires two binaries — `RoguePotato.exe` and a helper `RogueOxidResolver.exe` — making it detectable by endpoint tooling watching for unusual port 135 binding
- **Mitigated** by removing `SeImpersonatePrivilege` from service accounts and enforcing least privilege; Windows Defender credential guard provides partial protection

## Related concepts
[[SeImpersonatePrivilege]] [[JuicyPotato]] [[Token Impersonation]] [[DCOM Abuse]] [[Privilege Escalation]]