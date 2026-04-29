# sudoers

## What it is
Think of it like a backstage pass list at a concert — only people on the list can access restricted areas, and the list specifies exactly *which* areas each person can enter. The `/etc/sudoers` file is a Linux configuration file that defines which users (or groups) can execute commands with elevated privileges via the `sudo` command, and under what conditions. It is the authoritative access control list for privilege escalation on Unix/Linux systems.

## Why it matters
A misconfigured sudoers entry like `ALL=(ALL) NOPASSWD: ALL` grants a user full root access without requiring a password — a trivial privilege escalation vector attackers actively hunt for during post-exploitation. In 2021, attackers compromising cloud instances routinely scanned for world-writable sudoers files or overly permissive entries to establish persistent root access without needing to crack credentials.

## Key facts
- The file must **only** be edited using `visudo`, which validates syntax before saving — a syntax error can lock all users out of sudo entirely
- The format is: `user host=(runas_user) command` — e.g., `alice ALL=(ALL) /usr/bin/apt` restricts Alice to only running `apt` as root
- The `#includedir /etc/sudoers.d/` directive allows modular config files — attackers who gain write access to this directory can inject malicious entries
- `NOPASSWD:` is a critical keyword to audit — it bypasses password authentication for sudo commands entirely
- `sudo -l` lists a user's allowed commands and is one of the first commands run during Linux privilege escalation enumeration

## Related concepts
[[Privilege Escalation]] [[Principle of Least Privilege]] [[Linux File Permissions]] [[Access Control Lists]] [[SUID Bit]]