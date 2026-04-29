# NTLM and Pass-the-Hash

## What it is
Imagine a bouncer who never checks your face — only your wristband. If you steal someone's wristband, you *are* them, no questions asked. NTLM (NT LAN Manager) is a Windows challenge-response authentication protocol that verifies identity using a hashed password rather than the plaintext credential. Pass-the-Hash exploits this by stealing the stored hash from memory and replaying it directly, bypassing the need to crack it.

## Why it matters
In the 2017 NotPetya attack, the malware harvested NTLM hashes from LSASS memory using Mimikatz-style techniques and used Pass-the-Hash to move laterally across networks, authenticating to share after share without ever knowing a single plaintext password. Organizations with flat network architectures and no credential tiering were devastated within hours.

## Key facts
- NTLM hashes are stored in the **SAM database** (local) or extracted from **LSASS process memory** at runtime — both are prime targets
- The attack requires **local admin rights** to dump LSASS; tools like Mimikatz use `sekurlsa::logonpasswords` to harvest hashes
- **NTLMv1 is critically weak** (56-bit DES-based); NTLMv2 adds a timestamp and client challenge but is still vulnerable to relay attacks
- Defenses include enabling **Protected Users security group**, deploying **Credential Guard** (virtualizes LSASS), and enforcing **SMB signing** to block relay variants
- Microsoft recommends migrating to **Kerberos** wherever possible; NTLM should be disabled or restricted via Group Policy in modern environments

## Related concepts
[[Kerberos Authentication]] [[Lateral Movement]] [[Credential Dumping]] [[LSASS Memory]] [[SMB Relay Attack]]