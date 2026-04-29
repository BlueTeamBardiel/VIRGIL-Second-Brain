# permissions

## What it is
Like a hotel key card that only opens your assigned room, the gym, and the pool — but not the kitchen or other guests' rooms — permissions define exactly what actions a subject (user, process, or service) can perform on a specific object (file, directory, or resource). In security, permissions enforce the principle of least privilege by granting only the minimum access required to perform a task.

## Why it matters
In 2021, a misconfigured S3 bucket with world-readable permissions exposed 50 million records from a Brazilian insurance company — no exploit required, just an HTTP GET request. Attackers routinely scan for overpermissioned cloud storage, SUID binaries on Linux, and writable directories in Windows PATH to escalate privileges or exfiltrate data without ever touching malware.

## Key facts
- **Linux permission triad**: Read (4), Write (2), Execute (1) assigned to Owner, Group, and Others — expressed as octal (e.g., `chmod 755`)
- **SUID/SGID bits** allow executables to run with the file owner's privileges rather than the caller's — a common local privilege escalation vector
- **Windows uses ACLs** (Access Control Lists) with explicit Allow/Deny entries; Deny always overrides Allow when both apply
- **Discretionary Access Control (DAC)** lets resource owners set permissions; **Mandatory Access Control (MAC)** enforces system-wide policy regardless of owner preference
- **Privilege creep** occurs when users accumulate permissions over time through role changes without corresponding revocation — mitigated by periodic access reviews

## Related concepts
[[least privilege]] [[access control models]] [[privilege escalation]] [[ACL]] [[SUID]]