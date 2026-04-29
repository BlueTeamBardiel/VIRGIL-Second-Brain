# thread impersonation hijacking

## What it is
Like a criminal stealing a cop's uniform mid-shift to walk through a secure door unchallenged, thread impersonation hijacking occurs when malware injects malicious code into a legitimate process and then calls `SetThreadToken()` or `ImpersonateLoggedOnUser()` to steal the security token of a privileged thread. This grants the attacker the privileges of that thread's identity — often SYSTEM or a domain admin — without ever touching credential stores.

## Why it matters
In the classic "pass-the-token" lateral movement scenario, an attacker who has already compromised a low-privilege process on a Windows host uses Mimikatz's `token::elevate` command to impersonate a SYSTEM-level thread running in `lsass.exe`. This instantly elevates their effective privileges to SYSTEM, enabling them to dump all credential hashes, pivot across the network, and disable endpoint defenses — all while Windows logs show the *legitimate* process as the actor.

## Key facts
- Windows access tokens carry a security context (user identity, group memberships, privilege flags); stealing one transfers that entire context to the attacker's thread
- `SeImpersonatePrivilege` and `SeAssignPrimaryTokenPrivilege` are the Windows privileges that make this attack possible — services like IIS hold them by default, making them prime targets
- Token impersonation attacks are categorized under **MITRE ATT&CK T1134** (Access Token Manipulation), with sub-techniques covering token impersonation/theft specifically
- Defenders detect this via anomalous `SetThreadToken` calls, unexpected privilege escalation events (Event ID 4672), and process lineage mismatches in EDR telemetry
- Dropping to the `Impersonation` level (vs. `Delegation`) limits token use to the local machine, partially constraining lateral movement

## Related concepts
[[access token manipulation]] [[privilege escalation]] [[process injection]] [[pass-the-token attack]] [[LSASS credential dumping]]