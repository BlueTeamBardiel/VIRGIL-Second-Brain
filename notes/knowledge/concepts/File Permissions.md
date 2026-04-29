# File Permissions

## What it is
Think of file permissions like a nightclub's three-tiered wristband system: owners get VIP access, group members get general admission, and everyone else waits outside. Precisely, file permissions are access control rules attached to files and directories that define who can read, write, or execute them — enforced at the operating system level using discretionary access control (DAC).

## Why it matters
In 2021, misconfigured world-writable cron job scripts were a common privilege escalation path in Linux systems — an attacker with low-level access would simply overwrite a script run by root, injecting malicious commands that executed with full system privileges. Auditing file permissions on scheduled tasks and sensitive config files is a routine hardening step that directly prevents this class of attack.

## Key facts
- **Linux octal notation**: permissions are represented as three digits (e.g., `755` = rwxr-xr-x) — Owner/Group/Other, each calculated by summing Read(4) + Write(2) + Execute(1)
- **SUID/SGID bits**: when set on an executable, it runs with the *file owner's* privileges rather than the caller's — a misconfigured SUID root binary is a classic privilege escalation vector
- **Windows uses ACLs** (Access Control Lists) via NTFS, granting granular permissions per user/group; Linux DAC is simpler but less granular by default
- **Principle of Least Privilege** demands files carry minimum permissions necessary — world-writable files (`chmod 777`) are a red flag in any audit
- **`umask`** defines the *default* permissions subtracted when new files are created; a loose umask (e.g., `000`) creates insecure files automatically

## Related concepts
[[Discretionary Access Control]] [[Privilege Escalation]] [[Principle of Least Privilege]]