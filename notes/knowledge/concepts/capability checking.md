# capability checking

## What it is
Like a bouncer who checks *what you're allowed to do* rather than just *who you are*, capability checking grants permissions based on possessed tokens or rights rather than identity alone. It is a security model where access is determined by whether a subject holds a specific capability (an unforgeable token representing a right to perform an action), rather than querying a central access control list tied to the subject's identity.

## Why it matters
In 2021, attackers exploiting misconfigured Linux container environments leveraged overly permissive Linux capabilities (like `CAP_SYS_ADMIN`) to escape Docker containers and compromise host systems. If capability checking had been enforced with least privilege — stripping unnecessary capabilities from containers — the privilege escalation path would have been blocked before exploitation began.

## Key facts
- Linux divides root privileges into ~40 distinct capabilities (e.g., `CAP_NET_RAW`, `CAP_SYS_PTRACE`); dropping unneeded ones reduces attack surface even for processes running as root
- Capability-based security differs from ACL-based security: ACLs ask "who is this user and what can they access?", while capabilities ask "does this subject hold the token for this action?"
- POSIX capabilities on Linux are checked per-thread, not per-process, making inheritance chains a common misconfiguration trap
- Windows implements a parallel model via **Privileges** (e.g., `SeDebugPrivilege`) assigned to access tokens — auditing token privileges is a key lateral movement detection technique
- Failing to drop capabilities before executing untrusted code is a classic CWE-250 (Execution with Unnecessary Privileges) finding in penetration test reports

## Related concepts
[[principle of least privilege]] [[access control lists]] [[privilege escalation]] [[mandatory access control]]