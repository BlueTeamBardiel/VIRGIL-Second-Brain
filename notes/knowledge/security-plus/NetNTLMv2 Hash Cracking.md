# NetNTLMv2 Hash Cracking

## What it is
Imagine someone shouts a secret password across a crowded room, but scrambled — an attacker records the scramble and later tries every possible unscrambling at home. NetNTLMv2 hash cracking works the same way: an attacker captures the challenge-response authentication exchange from Windows network logins, then runs offline dictionary or brute-force attacks against the captured hash to recover the original plaintext password. Critically, the hash itself cannot be used for Pass-the-Hash attacks — the plaintext password must be recovered.

## Why it matters
In a real-world penetration test, a tester running Responder on a corporate network can poison LLMNR/NBT-NS queries, tricking Windows machines into sending NetNTLMv2 hashes to a rogue listener. Those captured hashes are then fed into Hashcat with a rockyou.txt wordlist, potentially cracking weak passwords in minutes and granting full domain access — a complete network compromise from a single misconfigured broadcast protocol.

## Key facts
- NetNTLMv2 uses a three-step process: server sends a random **challenge**, client encrypts it with an NTLM hash of the user's password, server verifies the **response**
- Captured with tools like **Responder**, **Impacket's ntlmrelayx**, or via packet capture on the wire
- Cracked offline using **Hashcat** (mode `-m 5600`) or **John the Ripper** — no network interaction required after capture
- Unlike NTLM hashes, NetNTLMv2 hashes **cannot** be directly used in Pass-the-Hash attacks; plaintext must be recovered
- Defenses include disabling LLMNR/NBT-NS via Group Policy, enforcing SMB signing, and requiring strong, complex passwords that resist dictionary attacks

## Related concepts
[[LLMNR Poisoning]] [[Pass-the-Hash]] [[Responder Tool]] [[Hashcat]] [[NTLM Authentication]]