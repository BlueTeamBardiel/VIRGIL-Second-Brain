# Access Control Models

## What it is
Think of a nightclub: the bouncer checks your ID (authentication), but the VIP list, the staff-only back room, and the open dance floor all follow different *rules* about who gets in based on different criteria. Access control models are the formal frameworks that define *how* those rules are structured — who grants permissions, based on what attributes, and whether those rules can be changed by users or only by system policy.

## Why it matters
In 2017, an Equifax employee was able to access a database containing 143 million records because overly permissive discretionary access controls allowed lateral movement after the initial breach. A stricter mandatory or role-based model — where users cannot self-grant access to sensitive data — would have contained the blast radius significantly.

## Key facts
- **DAC (Discretionary Access Control):** The resource *owner* sets permissions. Flexible but risky — users can accidentally share sensitive files. Windows NTFS ACLs are a classic example.
- **MAC (Mandatory Access Control):** The *system* enforces policy based on classification labels (e.g., Top Secret, Secret). Users cannot override it. Common in military/government systems (SELinux implements this).
- **RBAC (Role-Based Access Control):** Permissions attach to *roles*, not individuals. A nurse role gets patient-record access; a billing role does not. Most common model in enterprise environments.
- **ABAC (Attribute-Based Access Control):** The most granular — decisions use multiple attributes (user department, time of day, device health). Used in Zero Trust architectures.
- **Rule-Based AC:** Access granted based on system-defined rules (e.g., firewall ACLs blocking traffic outside business hours). Often confused with RBAC — note: *rules*, not *roles*.

## Related concepts
[[Principle of Least Privilege]] [[Zero Trust Architecture]] [[Identity and Access Management]]