# Linux

## What it is
Like a house where every room, appliance, and utility is visible and modifiable by the owner — Linux is an open-source, Unix-based operating system kernel where users have transparent access to system internals, file structures, and processes. Unlike Windows, everything from the bootloader to system calls is inspectable and configurable, making it both powerful and a high-value target when misconfigured.

## Why it matters
In the 2021 Log4Shell exploitation wave, attackers who gained initial access to vulnerable Java applications on Linux servers quickly escalated privileges by exploiting weak sudo configurations — running `sudo -l` to discover commands they could execute as root without a password. Defenders counter this by auditing `/etc/sudoers`, disabling root SSH login in `/etc/ssh/sshd_config`, and reviewing SUID binaries with `find / -perm -4000`.

## Key facts
- **File permissions** use octal notation (e.g., `chmod 755`) and three triads: owner, group, others — misconfigured world-writable files are a common privilege escalation vector
- **SUID bit** (`-rwsr-xr-x`) allows a binary to run as its owner (often root), making it a top target for local privilege escalation — check with `find / -perm /4000`
- **`/etc/passwd` and `/etc/shadow`** store user accounts and hashed passwords respectively; shadow is root-readable only — shadow file exposure enables offline cracking
- **Systemd and cron jobs** are common persistence mechanisms; attackers plant malicious services in `/etc/systemd/system/` or rogue cron entries in `/etc/cron.d/`
- **Logs live in `/var/log/`** — `auth.log` (Debian) or `secure` (RHEL) record authentication events critical for forensic investigation

## Related concepts
[[Privilege Escalation]] [[File Permissions]] [[Log Analysis]] [[SSH Hardening]] [[Persistence Mechanisms]]