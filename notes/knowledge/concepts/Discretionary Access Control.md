# Discretionary access control

## What it is
Like handing a friend your house key and trusting them not to make copies for others — ownership determines who gets in. Discretionary Access Control (DAC) is a model where the *owner* of a resource decides who can access it and what permissions they receive. The OS enforces those choices, but the human owner holds the decision-making authority.

## Why it matters
DAC's flexibility is also its Achilles' heel: if an attacker compromises a resource owner's account, they inherit that owner's ability to grant permissions. This is how malware can silently share sensitive files or add new ACL entries — because the infected user *is* the authority. A classic example is a Windows NTFS environment where a compromised admin account rewrites file permissions to exfiltrate data without touching system-wide policies.

## Key facts
- DAC is **identity-based**: access decisions hinge on the requester's identity and the owner's explicit grants, not job function or labels
- Implemented via **Access Control Lists (ACLs)** — each resource maintains a list of users/groups and their allowed operations (read, write, execute)
- **Transitive risk**: owners can delegate their permissions to others, making privilege creep difficult to audit
- Contrasts sharply with **Mandatory Access Control (MAC)**, where the OS — not the user — enforces access based on classification labels; DAC is considered less secure
- Most commercial operating systems (Windows, Linux, macOS) use DAC as their **default model**; Linux enforces it through POSIX permissions and ACLs

## Related concepts
[[Mandatory Access Control]] [[Role-Based Access Control]] [[Access Control Lists]] [[Principle of Least Privilege]]