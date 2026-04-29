# Mandatory Access Control

## What it is
Think of a nuclear facility where every document has a classification stamp and every person has a clearance level — a guard doesn't decide who gets in, the *rules* do. Mandatory Access Control (MAC) is a security model where the operating system enforces access policies based on sensitivity labels assigned to objects and clearance levels assigned to subjects, with no exceptions granted by the object owner. Unlike discretionary models, users cannot override or delegate these permissions — only the system administrator or security policy can.

## Why it matters
In 2013, Edward Snowden was able to access and exfiltrate NSA files partly because controls were insufficiently enforced at the data layer — a properly implemented MAC system would have blocked access to files whose sensitivity labels exceeded his operational need-to-know, regardless of his system administrator privileges. MAC is the architectural backbone of high-assurance environments precisely because it stops lateral movement and privilege abuse cold.

## Key facts
- MAC is implemented in **SELinux** (Security-Enhanced Linux) and **Trusted Solaris**, and is required for systems meeting **Bell-LaPadula model** compliance
- Labels have two components: **classification level** (Top Secret, Secret, Unclassified) and **categories/compartments** (need-to-know groups)
- The Bell-LaPadula model enforces **no read up, no write down** — a subject cannot read above their clearance or write to a lower classification (preventing data leakage)
- MAC is contrasted with **DAC (Discretionary Access Control)**, where the file owner sets permissions, and **RBAC**, where roles determine access
- Common on Security+ exams as the control type associated with **government/military environments** and the **highest assurance level**

## Related concepts
[[Bell-LaPadula Model]] [[Discretionary Access Control]] [[Role-Based Access Control]] [[SELinux]] [[Data Classification]]