# JuicyPotato

## What it is
Like a corrupt valet who exploits a loophole in a parking garage's "trusted employee" policy to steal cars, JuicyPotato abuses Windows' COM object impersonation to trick the operating system into handing over SYSTEM-level tokens. It is a privilege escalation exploit targeting the `SeImpersonatePrivilege` or `SeAssignPrimaryTokenPrivilege` rights on Windows systems, allowing a low-privileged service account to escalate to SYSTEM.

## Why it matters
In a real-world penetration test, an attacker who compromises a web server running as `IIS APPPOOL\DefaultAppPool` gains a service account with `SeImpersonatePrivilege`—a common default. Using JuicyPotato, they can escalate to SYSTEM within seconds, pivot laterally, and dump credentials from LSASS before any alert fires. Defenders monitor for unexpected CLSID-based COM server registrations and restrict `SeImpersonatePrivilege` to only explicitly required accounts.

## Key facts
- Targets Windows service accounts (IIS, SQL Server, etc.) that hold `SeImpersonatePrivilege` by default
- Exploits the Windows COM/DCOM subsystem by creating a rogue COM server and forcing a privileged process to authenticate to it, capturing and impersonating its token
- Requires a specific **CLSID** (Class Identifier) tied to a COM object running as SYSTEM; attackers enumerate valid CLSIDs per OS version since they vary
- **Patched in Windows 10 1809 and Server 2019** — Microsoft restricted token impersonation, spawning successor tools like **RoguePotato** and **PrintSpoofer**
- Commonly chained after an initial foothold via web shell, SQL injection with `xp_cmdshell`, or a low-privilege RCE vulnerability

## Related concepts
[[Privilege Escalation]] [[Token Impersonation]] [[SeImpersonatePrivilege]] [[PrintSpoofer]] [[Windows COM Objects]]