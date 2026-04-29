# Golden Ticket

## What it is
Imagine stealing the master key to a hotel — not a room key, but the grandmaster key that the locksmith uses to *create* all other keys. A Golden Ticket is a forged Kerberos Ticket Granting Ticket (TGT) crafted by an attacker who has obtained the KRBTGT account's NTLM password hash from a Windows Active Directory domain controller, allowing them to impersonate *any* user for up to 10 years by default.

## Why it matters
In the 2020 SolarWinds supply chain attack, threat actors moved laterally across networks using forged authentication tokens — the same principle as a Golden Ticket. Defenders must monitor for TGTs with anomalously long lifetimes or tickets claiming membership in privileged groups like Domain Admins, since these are red flags that standard Kerberos policy cannot produce legitimately.

## Key facts
- Requires the **KRBTGT account hash**, obtainable via DCSync attack or direct NTLM extraction from the domain controller's NTDS.dit file
- Forged tickets **bypass normal Kerberos validation** because they are cryptographically signed with the real KRBTGT key — the KDC trusts them unconditionally
- Default forged ticket lifetime can be set to **10 years**, far exceeding the normal 10-hour maximum
- **Mitigation**: Reset the KRBTGT password **twice** (because Active Directory caches the previous password), forcing all existing tickets to be invalid
- Detection hallmarks: Event ID **4769** (Kerberos service ticket request) with abnormal encryption types (e.g., RC4 instead of AES) or tickets for non-existent users

## Related concepts
[[Silver Ticket]] [[DCSync Attack]] [[Kerberos Authentication]] [[Pass-the-Hash]] [[Active Directory Privilege Escalation]]