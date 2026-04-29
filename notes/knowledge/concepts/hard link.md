# hard link

## What it is
Like two different name tags on the same locker — both tags point to the exact same storage space, not copies of it. A hard link is a directory entry that references the same inode (the actual data on disk) as another filename, meaning both "files" are identical at the filesystem level with no original or copy distinction.

## Why it matters
Attackers use hard link abuse to escalate privileges on Linux systems: if a SUID binary has a world-readable hard link created in a writable directory, an attacker can sometimes exploit race conditions (TOCTOU attacks) where a privileged process follows the hard link and operates on attacker-controlled data. Defenders audit for unexpected hard links to sensitive files like `/etc/shadow` as an indicator of tampering or persistence.

## Key facts
- Hard links share the same **inode number** — deleting the "original" file leaves the hard link fully intact and accessible, because the data persists until all links are removed
- Hard links **cannot cross filesystem boundaries** (partitions/volumes) and **cannot link to directories** (to prevent circular loops)
- A file's **link count** in inode metadata reveals how many hard links exist; a count >1 on sensitive files warrants investigation
- Unlike symlinks, hard links are **invisible to most log monitoring** — there's no "link file" to detect, making them stealthy persistence vectors
- On Windows, hard links created with `fsutil hardlink create` can bypass some DLP tools that check filenames rather than file identity (same-inode behavior)

## Related concepts
[[symbolic link]] [[inode]] [[TOCTOU race condition]] [[privilege escalation]] [[file integrity monitoring]]