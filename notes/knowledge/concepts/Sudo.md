# sudo

## What it is
Like a master key that a hotel manager briefly loans to a janitor — granting temporary, logged access to restricted areas without handing over permanent ownership — `sudo` (Superuser Do) allows a permitted, non-root user to execute specific commands with elevated privileges on Unix/Linux systems. It enforces least privilege by granting temporary root-level access only for the duration of a single command.

## Why it matters
Misconfigured `sudo` rules are a primary Linux privilege escalation vector. If an attacker compromises a low-privileged account and finds that user can run `sudo vim` without a password (via `/etc/sudoers`), they can escape to a root shell using vim's built-in shell execution — a technique well-documented on GTFOBins. This turns a limited foothold into full system compromise within seconds.

## Key facts
- The `/etc/sudoers` file controls who can run what commands as which user; it must be edited with `visudo` to prevent syntax errors that could lock out all privileged access
- `sudo -l` lists the current user's permitted sudo commands — frequently the first command an attacker runs after gaining initial access
- The `NOPASSWD` directive in sudoers allows commands to run without password confirmation, dramatically increasing risk if misconfigured
- By default, sudo caches credentials for **15 minutes**, meaning a single authentication grants a window of elevated access
- All sudo usage is logged (typically to `/var/log/auth.log` or `/var/log/secure`), making it a critical source for audit trails and forensic investigation

## Related concepts
[[Principle of Least Privilege]] [[Privilege Escalation]] [[Access Control]] [[Linux File Permissions]] [[Audit Logging]]