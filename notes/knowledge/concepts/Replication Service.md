# Replication Service

## What it is
Like a photocopier that automatically duplicates every document in one office and sends it to another, a replication service synchronizes data across multiple systems or domain controllers to maintain consistency. In Active Directory environments, the Directory Replication Service (DRS) is the protocol responsible for propagating changes — such as new user accounts or password updates — across all domain controllers in a forest.

## Why it matters
Attackers abuse the replication service in a technique called **DCSync**, where a compromised account with replication privileges (e.g., `Replicating Directory Changes All`) impersonates a domain controller and requests credential data — including NTLM password hashes for every account, including `krbtgt` — directly from a legitimate DC without ever touching the DC's disk. This is how attackers silently dump the entire domain's credential store without triggering traditional file-access alerts.

## Key facts
- **DCSync** requires the `DS-Replication-Get-Changes` and `DS-Replication-Get-Changes-All` permissions; these are normally held only by Domain Admins, Enterprise Admins, and Domain Controllers.
- The attack uses Microsoft's legitimate `MS-DRSR` (Directory Replication Service Remote Protocol) over RPC, making it appear as normal DC-to-DC traffic.
- Stealing the `krbtgt` hash via DCSync enables a **Golden Ticket** attack, granting forged Kerberos tickets valid for up to 10 years by default.
- Detection relies on monitoring for `4662` Windows event log entries (object access with replication GUIDs) from non-DC machine accounts.
- Defenders mitigate exposure by auditing accounts with replication rights using tools like BloodHound and enforcing least privilege on AD delegation.

## Related concepts
[[DCSync Attack]] [[Active Directory]] [[Golden Ticket]] [[Kerberos]] [[Privilege Escalation]]