# T1531 - Account Access Removal

## What it is
Like a disgruntled employee changing the office locks on their way out the door, Account Access Removal is when an adversary deliberately deletes, disables, or modifies credentials to lock legitimate users — including defenders — out of their own systems. This is a pure impact technique (MITRE Tactic: Impact, TA0040) designed to deny access rather than steal data.

## Why it matters
During the 2017 NotPetya attack, after encrypting systems, attackers had effectively removed all operational access to critical infrastructure — defenders couldn't log in to stop the spread or begin recovery. More targeted variants appear in ransomware incidents where threat actors delete administrator accounts or change passwords on domain controllers *before* deploying ransomware payloads, buying time by blinding the incident response team.

## Key facts
- **Three mechanisms**: account deletion, password changes on existing accounts, and modifying access control configurations (e.g., removing users from privileged groups)
- Attackers require **sufficient privileges** to execute this — typically SYSTEM, root, or Domain Admin level access first
- Commonly observed as a **pre-ransomware deployment step**, not a standalone action — it's part of maximizing impact
- On Windows, tracked via **Event ID 4726** (account deleted), **4723/4724** (password change attempts), and **4732/4733** (group membership changes)
- Distinct from T1078 (Valid Accounts) — this technique *removes* access rather than *abusing* existing access

## Related concepts
[[T1486 - Data Encrypted for Impact]] [[T1078 - Valid Accounts]] [[Privileged Access Management]] [[Windows Security Event Logs]] [[Ransomware TTPs]]