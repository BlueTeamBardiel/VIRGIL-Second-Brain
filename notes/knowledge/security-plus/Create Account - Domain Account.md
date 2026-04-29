# Create Account - Domain Account

## What it is
Like a master skeleton key that opens every door in a hotel chain rather than just one room, a domain account is a centralized credential managed by a domain controller that grants access across an entire Windows network. Adversaries abuse this by creating rogue domain accounts with elevated privileges, establishing persistent access that survives individual machine reimaging. This maps to MITRE ATT&CK technique T1136.002.

## Why it matters
In the SolarWinds breach, attackers created new domain accounts after compromising on-premises Active Directory, allowing them to move laterally across networks and access cloud resources like Microsoft 365 without triggering obvious alerts. Defenders must monitor for unexpected `net user /domain` commands or new accounts appearing outside normal provisioning windows — especially those added to privileged groups like Domain Admins.

## Key facts
- Domain accounts are stored in **Active Directory (AD)** on the Domain Controller, not on local machines — making them accessible from any domain-joined host
- Creating a domain account typically requires **Domain Admin** or delegated account operator privileges, meaning attackers must have already escalated before executing this technique
- The Windows Security Event Log **Event ID 4720** records domain account creation and is a critical detection artifact
- Adversaries often name rogue accounts to blend in — mimicking service account naming conventions (e.g., `svc_backup`) to avoid scrutiny
- This technique enables **persistence and lateral movement** simultaneously, as the account works across the entire domain environment

## Related concepts
[[Create Account - Local Account]] [[Active Directory]] [[Privilege Escalation]] [[Lateral Movement]] [[Windows Event Logs]]