# Incremental Backup

## What it is
Like a photographer who only develops the new photos taken since their last session instead of reprinting the entire album every day — an incremental backup captures only the data that has changed since the **most recent backup of any kind** (full or incremental). It sets the archive bit after each backup, so only net-new changes accumulate, making each individual backup fast and small.

## Why it matters
During ransomware incident response, recovery time depends critically on backup strategy. An organization using incremental backups must restore the last full backup **plus every incremental backup in the chain** — if a single incremental set is corrupted or encrypted by the attacker, the entire restore chain breaks. This is why attackers specifically target backup repositories: destroying one link in an incremental chain can make complete recovery impossible without paying the ransom.

## Key facts
- **Fastest to create, slowest to restore**: recovery requires the last full backup plus all subsequent incrementals in sequence.
- Incremental differs from **differential**: differential captures all changes since the last *full* backup only, making restore faster but individual backups larger.
- The **archive bit** (changed attribute) is cleared after each incremental backup, signaling that the file has been backed up.
- **3-2-1 backup rule** recommends 3 copies, 2 different media types, 1 offsite — incremental backups stored on the same network as production data violate the spirit of this rule.
- Recovery Point Objective (**RPO**) directly determines incremental backup frequency — a 4-hour RPO requires incrementals at least every 4 hours.

## Related concepts
[[Differential Backup]] [[Recovery Point Objective (RPO)]] [[Backup and Recovery]] [[Ransomware]] [[Business Continuity Planning]]