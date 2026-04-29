# CaddyWiper

## What it is
Like a janitor with a flamethrower instead of a mop — it doesn't clean up, it destroys everything so the building can never reopen. CaddyWiper is a destructive malware strain classified as a wiper, designed to overwrite and corrupt data on victim systems, rendering them completely inoperable. Unlike ransomware, it demands nothing; its sole purpose is permanent, irreversible destruction.

## Why it matters
CaddyWiper was deployed against Ukrainian organizations in March 2022, just weeks after Russia's invasion began, as part of a coordinated cyber-physical campaign targeting critical infrastructure. Defenders responding to the incident noted it was delivered via Group Policy Object (GPO) abuse, meaning attackers had already achieved domain controller-level access before the wiper was even launched — the wiper was the *final act*, not the intrusion itself.

## Key facts
- Discovered March 14, 2022, targeting Ukrainian entities; attributed to Sandworm (APT44), a Russian GRU-linked threat actor
- Overwrites files with null bytes (zeros), then destroys the Master Boot Record (MBR) and partition table, making recovery without backups essentially impossible
- Deliberately skips the first 1,000 bytes of the first physical drive on domain controllers — likely to preserve attacker access while destroying workstations
- Delivered via GPO, indicating prior Active Directory compromise; the wiper itself is a small (~9KB) PE executable
- Part of a family of Ukraine-targeted wipers alongside HermeticWiper, WhisperGate, and AcidRain, demonstrating a sustained wiper campaign strategy

## Related concepts
[[HermeticWiper]] [[Destructive Malware]] [[Master Boot Record (MBR)]] [[Sandworm APT]] [[Active Directory Group Policy Abuse]]