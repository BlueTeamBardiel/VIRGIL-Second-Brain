# OECH1

## What it is
Like a master key that opens every lock in a building — if you steal it once, you own everything. OECH1 (Oracle Enhanced Cryptographic Hash 1) is a legacy password hashing scheme used in older Oracle database versions that produces a deterministic, unsalted hash derived solely from the username and password concatenated together. This makes it trivially vulnerable to precomputed attacks because two users with identical passwords will always produce identical hashes.

## Why it matters
During a penetration test against a legacy Oracle 10g database, an attacker who dumps the SYS.USER$ table retrieves OECH1 hashes. Because the hash incorporates the username, an attacker can't use generic rainbow tables — but can quickly build username-specific tables or simply brute-force the short, case-insensitive hash space (uppercase normalization dramatically shrinks the keyspace). Cracking tools like **orabpf** or **Hashcat** (mode 3100) crack these hashes in minutes on modern hardware.

## Key facts
- OECH1 is the default hashing algorithm in **Oracle 10g and earlier**; Oracle 11g introduced SHA-1-based hashes (H type) alongside it
- The hash formula is essentially `DES(username+password)` — passwords are **uppercased** before hashing, cutting effective keyspace significantly
- **No salt** is used, making identical username+password combinations always produce the same hash
- Hashcat mode **3100** targets Oracle H: (OECH1) hashes specifically
- Oracle 12c deprecated OECH1 entirely; its presence in modern systems indicates misconfiguration or legacy compatibility mode enabled

## Related concepts
[[Rainbow Table Attack]] [[Password Salting]] [[Database Security Hardening]] [[Hashcat]] [[Credential Dumping]]