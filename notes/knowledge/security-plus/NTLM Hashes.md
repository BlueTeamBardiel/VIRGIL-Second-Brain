# NTLM Hashes

## What it is
Like a wax seal on a medieval letter — it proves identity without revealing the original secret, but anyone who steals the seal can forge documents without ever knowing what the original stamp looked like. NTLM (NT LAN Manager) hashes are fixed-length cryptographic representations of Windows user passwords, stored locally in the SAM database or Active Directory. Unlike true salted hashes, they are deterministic — the same password always produces the same hash.

## Why it matters
In a Pass-the-Hash (PtH) attack, an adversary dumps NTLM hashes from memory using tools like Mimikatz, then authenticates directly to network resources by *presenting the hash itself* rather than the plaintext password — no cracking required. This is why credential hygiene and tools like Windows Credential Guard exist: to prevent hash extraction from LSASS process memory before an attacker can weaponize them laterally across a domain.

## Key facts
- NTLM hashes use the **MD4 algorithm** applied to the Unicode password — no salt, making them vulnerable to rainbow table attacks
- Stored in two formats historically: **LM hash** (legacy, broken) and **NT hash** (current); modern systems disable LM but may still negotiate it
- NTLM hashes can be captured **over the network** via poisoning attacks (LLMNR/NBT-NS spoofing with Responder) and cracked offline
- **Pass-the-Hash** exploits NTLM's challenge-response protocol, allowing hash reuse without plaintext recovery
- Mitigations include enforcing **Kerberos authentication**, enabling **Protected Users security group**, and deploying **Local Administrator Password Solution (LAPS)** to prevent hash reuse across machines

## Related concepts
[[Pass-the-Hash]] [[Credential Dumping]] [[Kerberos Authentication]] [[LSASS Memory]] [[Rainbow Tables]]