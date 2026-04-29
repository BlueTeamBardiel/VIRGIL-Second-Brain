# AppArmor

## What it is
Think of AppArmor as a bouncer with a specific guest list for each application — nginx can only talk to port 80 and read `/var/www/html`, and no amount of exploitation changes that. Precisely, AppArmor is a Linux Mandatory Access Control (MAC) framework that confines individual programs to a defined set of resources using per-application security profiles. Unlike DAC (file permissions), AppArmor enforces restrictions even when a process runs as root.

## Why it matters
In a real-world scenario, an attacker exploits a buffer overflow in a web server and gains code execution. Without AppArmor, they can pivot — reading `/etc/passwd`, spawning shells, or accessing database credentials. With an enforcing AppArmor profile, the compromised web server process is still caged: it cannot access files outside its profile, cannot execute `/bin/bash`, and the attack chain breaks at the first fence.

## Key facts
- AppArmor uses **path-based** access control (profiles reference filesystem paths), contrasting with SELinux's label-based approach — this makes profiles easier to write but potentially less granular.
- Profiles operate in two modes: **enforce** (violations are blocked and logged) and **complain** (violations are only logged, used for profile development).
- Ships as default MAC on **Ubuntu and SUSE**; SELinux is the default on RHEL/CentOS/Fedora.
- AppArmor profiles are stored in `/etc/apparmor.d/` and loaded into the kernel via the `apparmor_parser` command.
- Supports **capabilities restrictions** — a profile can prevent a process from using dangerous Linux capabilities like `CAP_SYS_PTRACE` even if the process is privileged.

## Related concepts
[[SELinux]] [[Mandatory Access Control]] [[Least Privilege]] [[Linux Capabilities]] [[Discretionary Access Control]]