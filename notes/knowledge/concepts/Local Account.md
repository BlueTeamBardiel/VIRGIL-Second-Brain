# Local Account

## What it is
Think of a local account like a key cut specifically for one house — it only works on that single door, with no master key system involved. A local account is a user credential stored directly on an individual machine's Security Account Manager (SAM) database, granting access only to that specific host, independent of any centralized directory service like Active Directory.

## Why it matters
Attackers frequently target built-in local accounts — especially the default Administrator account (RID 500) — because they exist on virtually every Windows machine and are often left with weak or identical passwords across an enterprise. This "password reuse" weakness enables lateral movement: once an attacker compromises one machine's local admin password, they can use Pass-the-Hash or credential stuffing to pivot across every other host sharing that same credential, a scenario Microsoft's Local Administrator Password Solution (LAPS) was specifically designed to prevent.

## Key facts
- The built-in Windows Administrator account has a well-known RID of **500** and cannot be locked out by default, making it a high-value target
- Local accounts are stored in `C:\Windows\System32\config\SAM` and cannot be accessed while Windows is running (VSS shadow copies are a common attacker workaround)
- **LAPS** randomizes local Administrator passwords per machine, breaking lateral movement chains that exploit shared credentials
- Disabling or renaming the built-in Administrator and Guest accounts is a CIS Benchmark hardening recommendation
- Local accounts are a MITRE ATT&CK technique: **T1136.001** (Create Account: Local Account) is commonly used for persistence after initial compromise

## Related concepts
[[Privileged Account Management]] [[Pass-the-Hash]] [[Security Account Manager (SAM)]] [[Lateral Movement]] [[LAPS]]