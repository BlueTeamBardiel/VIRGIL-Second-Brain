# Sudo and Sudo Caching

## What it is
Like a building's security desk that stamps your badge for 15 minutes so you don't re-swipe every floor — `sudo` lets a standard Linux user temporarily execute commands as root without staying logged in as root. Specifically, `sudo` (Superuser Do) elevates privileges for a single command based on rules defined in `/etc/sudoers`, and caches the authentication token in memory for a default window of **15 minutes**.

## Why it matters
An attacker who gains a low-privilege shell on a Linux box will immediately check `sudo -l` to enumerate what commands the current user can run with elevated rights. A misconfigured sudoers entry — such as `NOPASSWD: ALL` or permission to run an editor like `vim` as root — becomes an instant privilege escalation path, because editors can spawn shells. This is one of the first checks in post-exploitation frameworks like LinPEAS.

## Key facts
- Default sudo credential cache timeout is **15 minutes** (`timestamp_timeout`), controlled in `/etc/sudoers` or `/etc/sudoers.d/`
- `sudo -k` immediately invalidates the cached token; `sudo -v` refreshes it without running a command
- The `/etc/sudoers` file must only be edited via **`visudo`** — which validates syntax before saving, preventing lockouts
- **GTFOBins** catalogs hundreds of allowed sudo binaries (e.g., `find`, `python`, `less`) that can be abused to break out to a root shell
- Sudo logs commands to syslog (`/var/log/auth.log` or `/var/log/secure`), making it a key source for **audit trails** and SOC investigations

## Related concepts
[[Privilege Escalation]] [[Linux File Permissions]] [[Access Control Lists]] [[Principle of Least Privilege]] [[Log Analysis]]