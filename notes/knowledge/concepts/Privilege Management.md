# Privilege Management

## What it is
Like a hospital where janitors have keys to supply closets but not the pharmacy, privilege management ensures each user or process gets exactly the access their role requires — no more. It is the formal discipline of assigning, controlling, reviewing, and revoking access rights to systems and data based on least privilege and need-to-know principles.

## Why it matters
In the 2020 Twitter hack, attackers used social engineering to compromise an internal admin tool that had excessive privileges, allowing them to reset passwords on 130 high-profile accounts including Barack Obama's. A proper privilege management program — with just-in-time access and strict role separation — would have limited which employees could access that tool and for how long, dramatically shrinking the attack surface.

## Key facts
- **Least Privilege**: Users and processes should operate with the minimum permissions required to complete their task — nothing extra.
- **Privilege Creep**: Over time, users accumulate permissions from role changes without old rights being revoked; periodic **access reviews** (recertification) catch this.
- **Privileged Access Workstations (PAWs)**: Dedicated, hardened machines used exclusively for admin tasks to reduce attack exposure.
- **Just-in-Time (JIT) Access**: Elevated privileges are granted temporarily on-demand and automatically expire, reducing the window of exploitation.
- **Separation of Duties (SoD)**: No single user should control an entire sensitive process end-to-end; splits power to prevent insider abuse or undetected errors.

## Related concepts
[[Least Privilege]] [[Role-Based Access Control]] [[Privileged Access Management]] [[Separation of Duties]] [[Identity and Access Management]]