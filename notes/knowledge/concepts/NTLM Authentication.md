# NTLM Authentication

## What it is
Like proving you know a secret handshake by demonstrating it rather than saying it aloud — NTLM is a challenge-response authentication protocol where the server sends a random number, the client hashes it with their password, and the server verifies the result without the password ever crossing the wire. It's Microsoft's legacy authentication protocol, largely replaced by Kerberos but still widely present in Windows environments for backward compatibility and local account authentication.

## Why it matters
In a Pass-the-Hash attack, an attacker who compromises a Windows machine can extract NTLM hashes from memory using tools like Mimikatz, then use those raw hashes to authenticate to other systems — no password cracking required. This is why lateral movement in Windows networks is devastatingly effective: the hash *is* the credential. Defenders mitigate this by enabling Protected Users security groups, disabling NTLMv1, and enforcing Kerberos wherever possible.

## Key facts
- **NTLMv1** uses a weak 56-bit DES challenge-response and is considered completely broken; **NTLMv2** uses HMAC-MD5 and includes timestamps to resist replay attacks
- NTLM hashes are **unsalted MD4** hashes of the Unicode password, meaning identical passwords produce identical hashes across all machines
- **Pass-the-Hash** exploits NTLM directly; **NTLM Relay attacks** (e.g., via Responder) intercept and forward authentication to a target server without ever cracking the hash
- Microsoft recommends disabling NTLMv1 via Group Policy (`Network security: LAN Manager authentication level` → NTLMv2 only)
- NTLM is still used when Kerberos fails — during DNS resolution failures, IP-based connections, or workgroup (non-domain) authentication

## Related concepts
[[Kerberos Authentication]] [[Pass-the-Hash Attack]] [[Credential Dumping]] [[Lateral Movement]] [[NTLM Relay Attack]]