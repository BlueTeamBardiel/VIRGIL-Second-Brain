# Inhibit System Recovery

## What it is
Like an arsonist who slashes the fire hoses before lighting the building ablaze, attackers deliberately destroy or disable the tools you'd use to rebuild after an attack. Inhibit System Recovery (MITRE ATT&CK T1490) is a technique where adversaries delete backups, disable recovery services, or corrupt restore points to prevent victims from recovering without paying a ransom or suffering prolonged downtime.

## Why it matters
In virtually every major ransomware campaign — including Ryuk and Conti — attackers execute commands like `vssadmin delete shadows /all /quiet` to wipe Volume Shadow Copies before deploying their encryption payload. This ensures that even technically savvy victims cannot simply roll back to yesterday's snapshot, dramatically increasing the pressure to pay the ransom. Defenders who monitor for VSS deletion commands or unexpected changes to backup configurations can detect ransomware staging *before* encryption begins.

## Key facts
- **Common tools abused:** `vssadmin`, `wbadmin`, `bcdedit`, and PowerShell are frequently used to delete shadow copies and disable Windows recovery boot options
- **bcdedit targeting:** Attackers use `bcdedit /set {default} recoveryenabled No` to prevent Windows from booting into recovery mode after system corruption
- **MITRE mapping:** Classified under Impact tactic (TA0040), meaning detection at this stage means encryption may be imminent or already occurring
- **Detection opportunity:** VSS deletion and backup service termination are high-fidelity indicators of compromise — these actions are rarely legitimate in production environments
- **Defense countermeasure:** Immutable backups (write-once storage) and the 3-2-1 backup rule directly counter this technique by ensuring at least one copy cannot be modified or deleted by an attacker with OS-level access

## Related concepts
[[Ransomware]] [[Volume Shadow Copy]] [[Data Encrypted for Impact]] [[Backup and Recovery Controls]] [[Defense Evasion]]