# Honeyfiles

## What it is
Like a jar of fake honey left on the counter to catch a thief with sticky fingers — honeyfiles are decoy files deliberately planted on a system to detect unauthorized access. They appear legitimate (named things like `passwords.xlsx` or `client_data.csv`) but have no real business value, so any access to them is a high-confidence indicator of malicious activity.

## Why it matters
During the 2013 Adobe breach, attackers exfiltrated massive amounts of data before detection. Honeyfiles address exactly this gap — when an attacker lands on a system and starts hunting for credentials or sensitive data, they often can't resist obviously named bait files. The moment they open `backup_credentials.txt`, an alert fires, giving defenders early warning of lateral movement or insider threat activity before real damage is done.

## Key facts
- Honeyfiles are a form of **deception technology**, closely related to honeypots but scoped to individual files rather than entire systems
- Any access to a honeyfile is treated as an **Indicator of Compromise (IoC)** — false positives are extremely rare because legitimate users have no reason to open them
- Effective deployment requires placing them in **realistic locations** (e.g., shared drives, Desktop folders) alongside real data so they blend in
- They are particularly effective at detecting **insider threats**, since external attackers and malicious insiders both gravitate toward files with tempting names
- Some implementations embed **canary tokens** (callback URLs or tracking beacons) inside the file that phone home when opened, even if network alerts are unavailable

## Related concepts
[[Honeypots]] [[Deception Technology]] [[Canary Tokens]] [[Indicators of Compromise]] [[Insider Threat Detection]]