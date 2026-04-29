# Windows Administration

## What it is
Think of Windows Administration like being the head janitor of a skyscraper — you hold the master keycard, set who gets access to which floors, and decide what gets installed in the building. Precisely, Windows Administration is the management of Windows OS environments through tools, policies, and accounts that control resources, permissions, users, and security configurations across individual machines or enterprise networks.

## Why it matters
In the 2021 Colonial Pipeline attack, threat actors moved laterally through Windows infrastructure using compromised privileged credentials — a failure of proper administrative account hygiene and least privilege enforcement. A hardened Windows environment with properly configured Group Policy, disabled default admin accounts, and monitored Event Logs could have significantly limited attacker movement.

## Key facts
- **Local Administrator Account (RID 500)** is a high-value target; it should be renamed, disabled, or managed via LAPS (Local Administrator Password Solution) to prevent pass-the-hash attacks
- **Group Policy Objects (GPOs)** are the primary mechanism for enforcing security baselines across Active Directory domains — mapped to CIS Benchmarks and STIG compliance
- **Windows Event Log IDs to memorize:** 4624 (successful logon), 4625 (failed logon), 4648 (explicit credential use), 4688 (process creation) — critical for CySA+ threat hunting
- **UAC (User Account Control)** enforces privilege separation by requiring elevation prompts; attackers frequently bypass it via techniques like DLL hijacking or token impersonation
- **PowerShell Execution Policy** is a *security preference, not a security boundary* — it can be bypassed with `-ExecutionPolicy Bypass` flags, making Script Block Logging essential for detection

## Related concepts
[[Active Directory]] [[Group Policy]] [[Privilege Escalation]] [[Event Log Analysis]] [[Least Privilege]]