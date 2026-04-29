# Hard Link Attacks

## What it is
Imagine two library catalog cards pointing to the exact same physical book — if you modify the book through either card, both reflect the change. A hard link attack exploits this filesystem behavior: an attacker creates a hard link to a privileged file, then tricks a high-privilege process into writing to the attacker-controlled path, which silently modifies the real target file. Unlike symlinks, hard links share the same inode, making them harder to detect and immune to certain symlink defenses.

## Why it matters
The Stuxnet malware leveraged hard link–style privilege escalation techniques on Windows systems, and CVE-2018-8440 (Windows ALPC Task Scheduler vulnerability) used hard links to overwrite protected SYSTEM files via a DACL manipulation trick. Defenders must configure filesystem permissions so unprivileged users cannot create hard links to files they don't own — a setting controlled by `SeCreateSymbolicLinkPrivilege` and hardlink restrictions introduced in Windows 10/Server 2016.

## Key facts
- Hard links point to the same **inode** as the original file; deleting the original doesn't remove the data as long as one hard link exists
- On **Linux**, unprivileged users cannot hard-link files they don't own (enforced since kernel 3.6 via `fs.protected_hardlinks = 1`)
- On **Windows**, the `CreateHardLink()` API requires the user to have **read access** to the target — attackers abuse this when privileged processes later write to the linked path
- Hard link attacks are a subset of **TOCTOU (Time-of-Check to Time-of-Use)** race condition vulnerabilities
- Unlike symlinks, hard links **cannot cross filesystem boundaries** and don't appear as a different file type in directory listings, making them stealthier

## Related concepts
[[Symlink Attacks]] [[TOCTOU Race Conditions]] [[Privilege Escalation]] [[Filesystem Permissions]] [[Windows Access Control Lists]]