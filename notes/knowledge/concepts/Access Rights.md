# Access Rights

## What it is
Like a hotel key card that only opens your room, the gym, and the pool — but not the kitchen or server closet — access rights are the specific permissions granted to a user, process, or system to read, write, execute, or delete specific resources. They define *what* an authenticated identity is allowed to do, enforced by the operating system or application after identity is confirmed.

## Why it matters
In the 2020 Twitter hack, attackers used social engineering to compromise an internal admin tool, granting themselves elevated access rights to high-profile accounts. If Twitter had enforced least privilege — limiting which employees could access that tool and what actions it permitted — the blast radius would have been dramatically smaller. This illustrates that misconfigured or overly broad access rights are a primary amplifier of breach impact.

## Key facts
- **Principle of Least Privilege (PoLP):** Users and processes should have only the minimum access rights required to perform their function — nothing more.
- **DAC vs. MAC vs. RBAC:** Discretionary Access Control lets owners set permissions; Mandatory Access Control uses system-enforced labels (e.g., Top Secret); Role-Based Access Control assigns rights by job role — all three appear on Security+.
- **Access rights ≠ Authentication:** Authentication proves *who you are*; access rights determine *what you can do* — conflating them is a classic exam trap.
- **Privilege creep** occurs when users accumulate access rights over time without revocation, violating PoLP and expanding attack surface.
- **Access control lists (ACLs)** are the technical mechanism that stores and enforces access rights on files, network devices, and directories.

## Related concepts
[[Principle of Least Privilege]] [[Role-Based Access Control]] [[Privilege Escalation]] [[Authentication vs Authorization]] [[Access Control Lists]]