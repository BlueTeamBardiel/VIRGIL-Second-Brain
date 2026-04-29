# Permission Restrictions

## What it is
Like a hospital where janitors have keys to supply closets but *not* the pharmacy, permission restrictions enforce who can access what resources on a system. Formally, they are access control rules that define the specific actions (read, write, execute, delete) a user, process, or group is authorized to perform on files, directories, or system objects.

## Why it matters
In the 2020 Twitter hack, attackers used social engineering to compromise internal admin tools — accounts with excessive permissions allowed them to hijack high-profile accounts and broadcast a Bitcoin scam. Had Twitter enforced strict least-privilege permission restrictions, the blast radius would have been dramatically smaller.

## Key facts
- **Principle of Least Privilege (PoLP):** Users and processes should hold only the minimum permissions required for their function — this is the foundational rule underlying permission restrictions
- **DAC vs. MAC:** Discretionary Access Control (DAC) lets owners set permissions (common in Windows/Linux file systems); Mandatory Access Control (MAC) enforces system-wide policies users cannot override (SELinux, MLS systems)
- **Linux octal permissions:** `chmod 755` means owner=rwx, group=r-x, others=r-x — a common Security+ exam target
- **Privilege creep:** Over time, users accumulate permissions beyond their role; regular access reviews (permission audits) are a key control to prevent this
- **NTFS permissions vs. Share permissions:** In Windows environments, the *most restrictive* combination of NTFS and Share permissions applies — a frequent CySA+ scenario question

## Related concepts
[[Least Privilege]] [[Role-Based Access Control]] [[Privilege Escalation]] [[Discretionary Access Control]] [[Access Control Lists]]