# Dallas

## What it is
Like a skeleton key that was copied and handed out to thieves, Dallas is a well-known default credential set (username: `admin`, password: `1234` or blank) associated with legacy industrial control systems and SCADA devices — particularly older Siemens and similar PLCs. More broadly, "Dallas" refers to the Dallas Semiconductor iButton and related hardware authentication tokens, small stainless-steel contact devices used to store cryptographic keys or access credentials in physical form.

## Why it matters
In industrial environments, attackers targeting SCADA systems have exploited default credentials embedded in Dallas-style authentication chips or hardcoded into PLCs to gain unauthorized access to critical infrastructure — power grids, water treatment facilities, and manufacturing lines. The Stuxnet worm, for example, specifically targeted Siemens S7 PLCs that relied on weak or default authentication mechanisms, demonstrating exactly how physical and logical credential failures converge in OT environments.

## Key facts
- Dallas Semiconductor iButtons store data (keys, passwords, logs) in a 64-bit unique ROM address, making them tamper-evident but not tamper-proof
- iButtons use the 1-Wire protocol — a single-wire communication standard that is trivially sniffable with basic hardware
- Default credentials on Dallas-compatible devices are a top attack vector in ICS/SCADA penetration tests
- Physical theft of an iButton grants full credential access — there is no PIN or secondary factor by default
- NIST SP 800-82 specifically addresses hardcoded and default credential risks in industrial control system environments

## Related concepts
[[SCADA Security]] [[Default Credentials]] [[ICS/OT Security]] [[Hardware Security Tokens]] [[1-Wire Protocol]]