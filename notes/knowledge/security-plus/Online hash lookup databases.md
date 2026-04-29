# Online hash lookup databases

## What it is
Think of it like a giant reverse phone book — instead of looking up a name to get a number, you look up a hash to get the original password. An online hash lookup database (also called a "rainbow table as a service") stores precomputed mappings between plaintext values and their cryptographic hashes, allowing an attacker to reverse a hash instantly without cracking it locally.

## Why it matters
When an attacker dumps a database of unsalted MD5 password hashes, they don't need a GPU farm — they paste the hashes into a site like CrackStation or hashes.com and retrieve plaintext passwords in seconds. This is precisely why salting passwords is non-negotiable: a unique salt per user ensures even identical passwords produce different hashes, making precomputed lookup tables useless.

## Key facts
- Sites like **CrackStation** maintain databases exceeding 15 billion plaintext-hash pairs, covering MD5, SHA-1, SHA-256, NTLM, and more
- These databases defeat unsalted hashes instantly but are **completely ineffective against properly salted hashes**, since the salt forces unique hash outputs
- **NTLM hashes** (used in Windows environments) are particularly vulnerable because legacy implementations often skip salting
- Hash lookup attacks are **passive and fast** — no computational cracking occurs; it's purely a dictionary lookup
- Defenders use this offensively too: submitting hashes to lookup sites during incident response to quickly identify compromised credentials

## Related concepts
[[Password Salting]] [[Rainbow Tables]] [[NTLM Authentication]] [[Password Hashing Algorithms]] [[Credential Dumping]]