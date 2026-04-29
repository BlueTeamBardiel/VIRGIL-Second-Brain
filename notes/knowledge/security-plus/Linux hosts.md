# Linux hosts

## What it is
Like a Swiss Army knife where every blade is visible and replaceable, Linux is an open-source operating system where every component — kernel, services, permissions — can be inspected and modified. Precisely, a Linux host is any system running the Linux kernel, commonly deployed as servers, embedded devices, and cloud infrastructure due to its stability and configurability.

## Why it matters
During the 2021 Log4Shell crisis, attackers specifically targeted Linux-based servers running Java applications because Linux hosts dominate cloud and server environments — compromising one often means pivoting into an entire infrastructure. Defenders must understand Linux file permissions, running services, and log locations to detect and contain such intrusions before lateral movement occurs.

## Key facts
- **Critical log files**: `/var/log/auth.log` (Debian/Ubuntu) or `/var/log/secure` (RHEL/CentOS) record authentication attempts — first stop when investigating unauthorized access
- **Privilege escalation paths**: SUID binaries (`find / -perm -4000`), misconfigured `sudo` rules (`/etc/sudoers`), and writable cron jobs are top vectors for local privilege escalation
- **Common persistence mechanisms**: attackers add SSH keys to `~/.ssh/authorized_keys`, plant cron jobs in `/etc/cron.d/`, or install rootkits via kernel modules
- **Key forensic artifacts**: bash history (`~/.bash_history`), `/etc/passwd` and `/etc/shadow` for account changes, and `netstat`/`ss` output for unexpected listening services
- **Hardening benchmarks**: CIS Linux Benchmarks specify controls like disabling unused services via `systemctl`, enforcing `noexec` mount options, and configuring PAM password policies

## Related concepts
[[File Permissions and Linux ACLs]] [[Privilege Escalation]] [[Log Analysis and SIEM]] [[SSH Security]] [[Hardening and Baselines]]