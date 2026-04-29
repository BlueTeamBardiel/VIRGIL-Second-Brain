# T1561 - Disk Wipe

## What it is
Like a scorched-earth retreat where a fleeing army salts the fields so nothing can grow back, Disk Wipe is an attacker's final act of destruction — deliberately overwriting or corrupting disk structures so the system becomes unbootable and forensic recovery becomes impossible. Technically, it involves overwriting the Master Boot Record (MBR), partition tables, or raw disk sectors with garbage data, rendering the OS and stored data unrecoverable.

## Why it matters
During the 2012 Shamoon attack against Saudi Aramco, attackers wiped the MBR of roughly 35,000 workstations, forcing the company to spend weeks replacing hardware and rebuilding systems from scratch. This illustrates the classic use case: disk wiping is deployed as the final payload in an intrusion, after exfiltration is complete, to destroy evidence, deny incident responders forensic artifacts, and maximize operational disruption.

## Key facts
- **Two sub-techniques exist:** T1561.001 (Disk Content Wipe — overwriting data sectors) and T1561.002 (Disk Structure Wipe — overwriting MBR/VBR/partition tables)
- Disk Structure Wipe is more destructive per byte written because destroying the MBR makes the entire disk inaccessible without touching most content
- Attackers commonly use tools like `dd` on Linux or custom malware (e.g., WhisperGate in 2022 Ukraine attacks) to execute disk wipes
- Detection signals include raw disk access by unexpected processes, Volume Shadow Copy deletion preceding the wipe, and sudden disk I/O spikes
- Mitigation relies on offline, immutable backups — no software-level control can stop a wipe once an attacker has kernel-level access

## Related concepts
[[T1485 - Data Destruction]] [[T1070 - Indicator Removal]] [[T1490 - Inhibit System Recovery]]