# DAC - Discretionary Access Control

## What it is
Like a homeowner who can hand out spare keys to whoever they choose — without asking the landlord — DAC lets **resource owners decide who gets access** to their own objects. It is an access control model where the data or file owner has the discretion to grant or revoke permissions to other users, typically implemented through Access Control Lists (ACLs) or permission bits.

## Why it matters
DAC's flexibility is also its Achilles' heel: if an attacker compromises a user account that owns sensitive files, they **inherit that user's ability to share those files freely** — including exfiltrating data by granting access to a malicious account. This is exactly why ransomware spreads so effectively in Windows environments: the infected user account owns documents and can read/write/delete them without any higher authority stopping it.

## Key facts
- **Owner controls access** — the creator of a file is typically its owner and sets its permissions (classic Unix `chmod` model)
- **Implemented via ACLs** — Windows NTFS uses Discretionary ACLs (DACLs) to list which users/groups have which permissions on an object
- **Transitive trust risk** — permissions can be passed along; a user can grant rights they themselves possess to a third party
- **Contrast with MAC** — unlike Mandatory Access Control, DAC does not use security labels and does not involve a central authority enforcing policy
- **Most common in commercial OS** — Windows, Linux, and macOS all default to DAC models, making it the most widely tested model on Security+

## Related concepts
[[MAC - Mandatory Access Control]] [[RBAC - Role-Based Access Control]] [[Access Control Lists]] [[Principle of Least Privilege]]