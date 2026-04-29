# arbitrary file write

## What it is
Like a rogue postal worker who can drop a package into *any* mailbox in the city — including the postmaster's private one — an arbitrary file write vulnerability lets an attacker write attacker-controlled content to any location on the filesystem, regardless of intended permissions. It occurs when an application accepts user-influenced data (filename, path, or content) without proper validation and writes it to disk with elevated privileges.

## Why it matters
In the 2021 PrintNightmare exploit (CVE-2021-34527), the Windows Print Spooler service allowed low-privileged users to trigger a file write into a protected system directory, enabling attackers to drop a malicious DLL that executed as SYSTEM. This single primitive escalated a standard user account to full domain compromise in minutes.

## Key facts
- **Path traversal is the typical enabler**: attackers use sequences like `../../etc/cron.d/backdoor` to escape the intended write directory and reach privileged locations.
- **Common high-value targets**: cron jobs (`/etc/cron.d/`), SSH authorized keys (`~/.ssh/authorized_keys`), web shells in web roots, and DLLs in system directories.
- **TOCTOU (time-of-check/time-of-use) race conditions** can convert a safe file write into an arbitrary one by swapping the target path between validation and execution.
- **Impact escalates with process privilege**: a file write by a SYSTEM or root process can overwrite startup scripts, achieving persistence or privilege escalation.
- **Mitigation**: use allowlists for filenames/paths, canonicalize paths before writing (resolve symlinks and `..`), enforce least privilege on writing processes, and use chroot/containers to restrict filesystem scope.

## Related concepts
[[path traversal]] [[privilege escalation]] [[symlink attack]] [[directory traversal]] [[TOCTOU race condition]]