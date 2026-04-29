# Windows Impersonation Token

## What it is
Like a hotel staff member borrowing a guest's keycard to service a room — acting with *their* access rather than their own — an impersonation token lets a Windows process temporarily adopt another user's security context. Specifically, it is an access token that a thread (not the whole process) uses to perform actions under a different identity, without requiring that user's credentials.

## Why it matters
In the **Pass-the-Token** attack, an adversary with local admin rights uses tools like Mimikatz or Incognito to harvest impersonation tokens from memory — particularly from processes owned by privileged users or SYSTEM accounts. By impersonating a Domain Admin token still alive in memory, an attacker can pivot laterally or escalate privileges without ever cracking a password.

## Key facts
- Windows defines four impersonation levels: **Anonymous**, **Identification**, **Impersonation**, and **Delegation** — only the last two allow meaningful resource access
- Impersonation tokens are **thread-level**; primary tokens are process-level — this distinction matters for privilege scope
- The Windows API calls `ImpersonateLoggedOnUser()` and `SetThreadToken()` are the legitimate mechanisms, but are abused by attackers for token theft
- `SeImpersonatePrivilege` is the key privilege enabling impersonation — services like IIS and SQL Server hold it by default, making them attractive lateral movement targets
- **Potato attacks** (e.g., JuicyPotato, PrintSpoofer) exploit `SeImpersonatePrivilege` to escalate from a service account to SYSTEM without a token already in memory

## Related concepts
[[Access Token]] [[Privilege Escalation]] [[SeImpersonatePrivilege]] [[Pass-the-Hash]] [[Token Impersonation Attack]]