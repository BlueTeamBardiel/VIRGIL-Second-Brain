# mklink

## What it is
Like a street address that points to a building located elsewhere in the city, `mklink` is a Windows command-line utility that creates symbolic links (symlinks) and hard links — filesystem pointers that make one path transparently redirect to another file or directory.

## Why it matters
Attackers exploit `mklink` in **symlink attacks** to escalate privileges: if a high-privileged process (like an installer running as SYSTEM) writes to a predictable temp file path, an attacker can pre-create a symlink at that path pointing to `C:\Windows\System32\evil.dll`, causing the privileged process to write attacker-controlled content to a protected location. This technique appears in numerous Windows LPE (Local Privilege Escalation) CVEs.

## Key facts
- **Three link types**: `/D` creates a directory symlink, `/H` creates a hard link (same-volume only, no directories), and the default creates a file symlink
- Symlinks require **SeCreateSymbolicLinkPrivilege** by default — standard users cannot create them unless Developer Mode is enabled in Windows 10+
- Hard links share the same **inode/MFT entry**; deleting the original file doesn't remove data as long as one hard link remains
- Symlink attacks are a class of **TOCTOU (Time-of-Check Time-of-Use)** vulnerability — the window between a process checking a path and using it is exploited
- Defenders monitor for `mklink` usage via **Sysmon Event ID 11** (file creation) and audit policies tracking symlink creation in sensitive directories

## Related concepts
[[Privilege Escalation]] [[TOCTOU Race Condition]] [[Windows File Permissions]] [[Sysmon]] [[Hard Links]]