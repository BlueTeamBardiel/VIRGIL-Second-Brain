# Full Backup

## What it is
Like photocopying every single page of a book regardless of whether you've read it before — a full backup captures a complete snapshot of all selected data every time it runs, with no regard for what has or hasn't changed. It is the baseline backup type from which all other backup strategies derive their restore capability.

## Why it matters
In a ransomware scenario where attackers encrypt an entire file server, a full backup is your cleanest recovery path — no dependency chaining, no hunting for differential sets. Organizations that rely solely on full backups, however, often discover their backup windows are too long and their storage costs too high, pushing them toward hybrid strategies that still require a full backup as the anchor point.

## Key facts
- A full backup copies **100% of selected data** every run, regardless of the archive bit or modification timestamps
- It has the **longest backup window** and **highest storage cost** of all backup types, but the **fastest restore time** — only one set needed
- The archive bit is **cleared (reset to 0)** after a full backup runs, signaling that files have been backed up
- Full backups serve as the **baseline** for incremental and differential backup chains — without one, neither can function
- The **3-2-1 rule** (3 copies, 2 media types, 1 offsite) typically uses full backups as the primary copy in the strategy
- Recovery Point Objective (RPO) is determined by backup frequency — a weekly full backup means up to **7 days of potential data loss**

## Related concepts
[[Incremental Backup]] [[Differential Backup]] [[Recovery Point Objective]] [[3-2-1 Backup Rule]] [[Backup Rotation Schemes]]