# Honeyfile

## What it is
Like leaving a wallet stuffed with dye packs on a park bench, a honeyfile is a fake but convincing document deliberately placed on a system to lure and expose unauthorized users. Precisely: it is a decoy file — often named something irresistible like `passwords.xlsx` or `employee_salaries.csv` — designed to trigger an alert the moment an attacker opens, copies, or exfiltrates it. Unlike real data files, any interaction with a honeyfile is inherently suspicious and warrants immediate investigation.

## Why it matters
During the 2016 Democratic National Committee breach, attackers exfiltrated large volumes of documents. Had honeyfiles been seeded throughout the file share, security teams could have detected the intrusion earlier — the moment an adversary opened a decoy document, an alert would have fired, reducing dwell time significantly. Honeyfiles are particularly effective against insider threats, where attackers already have legitimate access to the environment but cannot easily distinguish real assets from traps.

## Key facts
- Honeyfiles are a form of **deception technology**, categorized alongside honeypots and honeytokens under active defense strategies.
- Opening a honeyfile should generate a **SIEM alert** via file access auditing (e.g., Windows Security Event ID 4663).
- Effective honeyfiles use **convincing naming conventions** and realistic metadata to blend with legitimate files and tempt attackers.
- They provide **zero false-positive context** — legitimate users have no business reason to access files they weren't told exist.
- Honeyfiles can embed **canary tokens** (unique URLs or identifiers) that phone home when the file is opened, even if exfiltrated off-network.

## Related concepts
[[Honeypot]] [[Canary Token]] [[Deception Technology]] [[SIEM]] [[Insider Threat Detection]]