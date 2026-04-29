# Active Directory Replication Concepts

## What it is
Think of it like a chain of post offices: when one office receives an address change, it passes that update along to neighboring offices until every branch has the same current record. Active Directory replication is the process by which changes made to directory objects (users, passwords, group policies, etc.) on one Domain Controller (DC) are synchronized across all other DCs in the domain or forest. It uses a pull-based model over the **DSRepl** protocol, with replication topology managed automatically by the **Knowledge Consistency Checker (KCC)**.

## Why it matters
Attackers exploit replication to execute **DCSync attacks**, where a compromised account with `Replicating Directory Changes All` permissions impersonates a Domain Controller and requests credential data — including NTLM hashes and Kerberos keys — from a legitimate DC without ever touching the DC's file system. This is how tools like Mimikatz steal the `krbtgt` hash to forge Golden Tickets, making replication permission auditing critical for defense.

## Key facts
- Replication occurs within a **site** (intrasite) every **15 seconds** by default; between sites (intersite) defaults to **180 minutes** via site links
- The **USN (Update Sequence Number)** is a per-DC counter that tracks changes; replication partners compare USNs to determine what needs syncing
- **Lingering objects** occur when a DC is offline longer than the tombstone lifetime (default 60–180 days) and can cause replication inconsistencies
- DCSync requires: `Replicating Directory Changes` + `Replicating Directory Changes All` — these are the exact permissions to audit and restrict
- The **SYSVOL** folder (containing Group Policy Objects) replicates separately via **DFSR** (DFS Replication), not standard AD replication

## Related concepts
[[DCSync Attack]] [[Kerberos Golden Ticket]] [[NTLM Hash Harvesting]] [[Privileged Access Management]] [[Group Policy Security]]