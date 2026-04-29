# Timestamps

## What it is
Like a wax seal on a medieval letter that records exactly when it was stamped, a timestamp is a recorded value marking the precise date and time an event occurred. In digital systems, timestamps are embedded in files, logs, network packets, and certificates to establish a chronological record of activity.

## Why it matters
During incident response, attackers often use **timestomping** — deliberately altering file metadata timestamps (created, modified, accessed) on Windows NTFS or Linux ext4 systems to make malicious files appear legitimate or pre-date their intrusion. A forensic analyst correlating file timestamps against firewall logs and SIEM events may catch this manipulation when $STANDARD_INFORMATION and $FILE_NAME timestamps in the MFT disagree with each other — a classic detection tell.

## Key facts
- **NTFS stores two timestamp sets**: `$STANDARD_INFORMATION` (easily modified) and `$FILE_NAME` (harder to alter) — discrepancies between them indicate timestomping
- Windows tracks **MACE timestamps**: Modified, Accessed, Created, Entry Modified — all stored in file metadata
- **Kerberos tickets** rely on timestamp synchronization; the default tolerance is **±5 minutes** — clocks outside this window cause authentication failures, which attackers exploit via replay attacks if clocks drift
- Timestamps in logs use **UTC** (Coordinated Universal Time) as the forensic standard; local time zone offsets must be normalized during multi-system investigations
- **Certificate validity windows** are timestamp-enforced — an expired certificate whose timestamp is accepted by a lenient client is a known TLS exploitation vector

## Related concepts
[[Log Analysis]] [[Digital Forensics]] [[Kerberos Authentication]] [[NTFS Artifacts]] [[Timestomping]]