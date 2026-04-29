# NTLM

## What it is
Imagine proving your identity to a bouncer not by showing your ID, but by solving a puzzle only someone who knows your password could solve — without ever handing over the password itself. NTLM (NT LAN Manager) is a Microsoft challenge-response authentication protocol where the server sends a random challenge, the client hashes it with the user's password-derived key, and returns the result for verification. It replaced the older LM protocol but has itself been superseded by Kerberos in modern Active Directory environments.

## Why it matters
NTLM is the engine behind **Pass-the-Hash** attacks: once an attacker extracts an NTLM hash from memory using a tool like Mimikatz, they can authenticate to other systems on the network *without ever cracking the password*. This lateral movement technique is a cornerstone of real-world breaches, including the 2017 NotPetya attack, making NTLM a prime target for detection rules in SIEMs like Splunk or Microsoft Sentinel.

## Key facts
- NTLM uses a **three-step handshake**: Negotiate → Challenge → Authenticate
- The **NT hash** is an unsalted MD4 hash of the Unicode password — making identical passwords produce identical hashes across every machine
- NTLM is vulnerable to **relay attacks** (NTLM Relay): an attacker intercepts and forwards authentication to a different target without needing the hash itself
- Microsoft recommends **disabling NTLMv1** entirely; NTLMv2 adds a client-side challenge, reducing replay attack risk
- NTLM authentication still falls back automatically in environments where Kerberos fails (e.g., IP-based access instead of hostname), creating hidden attack surfaces

## Related concepts
[[Kerberos]] [[Pass-the-Hash]] [[Credential Dumping]] [[Active Directory]] [[Lateral Movement]]