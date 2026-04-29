# SELinux

## What it is
Think of a regular Linux system as an office where employees can wander into any unlocked room — SELinux adds a security guard who checks a laminated badge policy even *after* the door is already unlocked. Security-Enhanced Linux is a mandatory access control (MAC) framework built into the Linux kernel, originally developed by the NSA, that enforces fine-grained policies defining exactly what processes can access which files, ports, and resources — regardless of file permissions.

## Why it matters
In 2016, a compromised Apache web server process on a standard Linux system could pivot to read `/etc/shadow` or write to system binaries if misconfigured permissions allowed it. With SELinux enforcing a targeted policy, that same compromised `httpd` process is confined to its security context — it literally cannot open files outside its allowed domain even if the attacker has code execution, containing the breach automatically.

## Key facts
- SELinux operates in three modes: **Enforcing** (blocks and logs violations), **Permissive** (logs but doesn't block — used for troubleshooting), and **Disabled** (completely off)
- Every subject and object gets a **security context** label in the format `user:role:type:level` — policy decisions are based on these labels, not just UIDs
- **Type Enforcement (TE)** is the primary mechanism: it controls which process types can interact with which file/resource types
- SELinux is a **Mandatory Access Control** system, contrasting with Linux's default **Discretionary Access Control** (DAC) where file owners set their own permissions
- The `audit2allow` tool converts SELinux denial logs into policy rules — a critical tool for administrators but also a risk if used blindly to silence legitimate alerts

## Related concepts
[[Mandatory Access Control]] [[AppArmor]] [[Principle of Least Privilege]]