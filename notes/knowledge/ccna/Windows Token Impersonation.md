# Windows Token Impersonation

## What it is
Think of a Windows access token like a hotel keycard — it encodes what rooms you're allowed to enter. Token impersonation is when a process steals or borrows another user's keycard to access resources as that person. Precisely, it's a post-exploitation technique where an attacker duplicates a security token from an existing process to execute code under a different user's security context without knowing their credentials.

## Why it matters
After gaining initial foothold as a low-privileged user, an attacker running Incognito (via Metasploit) can list available tokens on the compromised machine. If a Domain Administrator has an active session, their token may be available in memory — stealing it grants DA-level access across the entire domain without a single password being cracked.

## Key facts
- **Two impersonation types**: `SeImpersonatePrivilege` (impersonate a client's token) and `SeAssignPrimaryTokenPrivilege` (assign tokens to processes); service accounts often hold these by default
- **Token types matter**: Impersonation tokens are temporary and context-bound; Primary tokens are attached to processes and more persistent
- **Potato attacks** (Hot Potato, Juicy Potato, PrintSpoofer) exploit `SeImpersonatePrivilege` to escalate from SERVICE to SYSTEM by coercing a privileged process into authenticating to an attacker-controlled endpoint
- **Detection signature**: Look for `OpenProcessToken` + `DuplicateTokenEx` + `ImpersonateLoggedOnUser` API call sequences in EDR telemetry
- **Mitigation**: Apply the Principle of Least Privilege; avoid granting `SeImpersonatePrivilege` to non-service accounts; Windows Protected Users security group restricts token delegation

## Related concepts
[[Privilege Escalation]] [[Access Control Lists]] [[Pass the Hash]] [[Windows Privileges and Rights]] [[Lateral Movement]]