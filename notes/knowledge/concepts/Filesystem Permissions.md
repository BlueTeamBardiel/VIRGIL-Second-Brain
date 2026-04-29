# Filesystem Permissions

## What it is
Think of a nightclub with a velvet rope — the bouncer checks your wristband before letting you into VIP, the bar, or the back office. Filesystem permissions are the OS-enforced rules that determine which users or processes can read, write, or execute specific files and directories. They are implemented via access control metadata attached to each filesystem object, evaluated by the kernel on every file operation.

## Why it matters
In the 2021 Polkit vulnerability (CVE-2021-4034), a SUID-root binary (`pkexec`) could be exploited by a local unprivileged user to gain full root access — a textbook case of misconfigured permissions on an executable with the Set-UID bit. Proper permission hardening (removing unnecessary SUID bits) would have contained the blast radius to the user's own account.

## Key facts
- **Linux octal notation**: permissions are expressed as three groups (owner/group/others), each combining read(4), write(2), execute(1) — e.g., `chmod 755` means rwxr-xr-x.
- **SUID/SGID/Sticky bits**: SUID (4xxx) runs a file as its *owner* rather than the caller; SGID (2xxx) inherits group context; sticky bit (1xxx) on directories (like `/tmp`) prevents users from deleting files they don't own.
- **Windows NTFS ACLs**: more granular than Linux DAC — support explicit Allow/Deny entries per user/group, with Deny overriding Allow when both apply.
- **Principle of Least Privilege (PoLP)**: permissions should grant only the minimum access required — world-writable files (`777`) or world-readable `/etc/shadow` are immediate red flags during audits.
- **`umask`**: defines the *default* permission mask subtracted when new files are created; a `umask 022` yields `644` for files and `755` for directories.

## Related concepts
[[Discretionary Access Control]] [[Privilege Escalation]] [[Principle of Least Privilege]]