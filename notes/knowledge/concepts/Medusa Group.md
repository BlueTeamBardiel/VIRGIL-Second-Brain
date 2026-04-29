# Medusa Group

## What it is
Like a franchised crime syndicate that rents out its extortion infrastructure to affiliate operators, Medusa is a Ransomware-as-a-Service (RaaS) group that emerged around 2022 and operates a multi-extortion model. The group develops and maintains ransomware tooling, then recruits affiliates who conduct intrusions and split ransom proceeds with the core developers.

## Why it matters
In February 2024, Medusa claimed responsibility for attacking the Minneapolis Public Schools district, leaking sensitive student and staff data on their public "Medusa Blog" after the district refused to pay a $1 million ransom. This incident demonstrated how RaaS groups pressure victims by publishing countdown timers and threatening staged data releases — turning encryption ransoms into public extortion campaigns.

## Key facts
- Medusa operates a **Tor-based leak site** ("Medusa Blog") where victim data is posted publicly if ransom demands go unmet, enabling double extortion
- Primarily gains initial access via **unpatched internet-facing vulnerabilities** and compromised Remote Desktop Protocol (RDP) credentials
- Uses **living-off-the-land (LotL)** techniques — leveraging legitimate tools like PowerShell, PsExec, and certutil — to evade endpoint detection
- Offers victims a paid option to **extend the ransom deadline** by 24 hours for ~$10,000, a psychological pressure tactic built into their model
- Distinct from the older "MedusaLocker" ransomware strain — Medusa Group is a **separate threat actor**, a common exam/analyst confusion point

## Related concepts
[[Ransomware-as-a-Service]] [[Double Extortion]] [[Living off the Land Attacks]] [[RDP Exploitation]] [[Threat Actor Attribution]]