# Record-level Encryption

## What it is
Imagine a filing cabinet where every individual folder is locked with its own unique padlock — even if someone breaks into the cabinet, each folder still requires its own key. Record-level encryption works the same way: individual rows or entries within a database are encrypted independently, so that compromising the database engine or storage layer doesn't expose all data simultaneously.

## Why it matters
In the 2013 Adobe breach, attackers exfiltrated an entire database because data was encrypted at the column level with a single shared key — once that key was obtained, all 153 million records were readable. Record-level encryption with per-user or per-record keys would have forced attackers to compromise each key individually, dramatically limiting blast radius even after initial database access was achieved.

## Key facts
- Record-level encryption operates *above* the storage layer — the database engine itself may not be trusted, distinguishing it from Transparent Data Encryption (TDE), which only protects data at rest on disk.
- Each record can use a unique encryption key, often derived from a master key via Key Derivation Functions (KDFs) combined with a record-specific salt or identifier.
- It protects against **insider threats** and **SQL injection** attacks where an attacker gains query-level access but cannot retrieve plaintext without the individual record keys.
- Key management complexity scales with the number of records — poor key lifecycle management is the most common implementation failure.
- Querying encrypted records is significantly harder; techniques like **searchable encryption** or **homomorphic encryption** exist but introduce performance trade-offs.

## Related concepts
[[Transparent Data Encryption]] [[Column-level Encryption]] [[Key Management]]