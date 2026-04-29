# NTLM Downgrade Attack

## What it is
Like a con artist convincing a bank teller to accept a photocopy of an ID instead of the real thing, an NTLM downgrade attack tricks systems into using weaker authentication versions (NTLMv1) instead of stronger ones (NTLMv2). Attackers manipulate negotiation messages between client and server to force the use of legacy NTLM protocols with known cryptographic weaknesses, making captured hashes far easier to crack offline.

## Why it matters
During a penetration test or real intrusion, an attacker running Responder on the local network can intercept NTLMv1 challenge-response exchanges and crack the resulting DES-based hashes in hours using rainbow tables or GPU cracking—something practically impossible with NTLMv2's per-session nonces. This technique was weaponized in many lateral movement chains, particularly in environments that still support Windows XP or legacy SMB configurations.

## Key facts
- NTLMv1 uses a static 8-byte server challenge with DES encryption; NTLMv2 uses an HMAC-MD5 with a client-side timestamp nonce, defeating precomputed attacks
- The downgrade is triggered by manipulating the `NTLMSSP_NEGOTIATE` flags in the authentication negotiation packet
- Tools like **Responder** and **ntlmrelayx** can force and capture downgraded NTLM hashes automatically
- Setting `LMCompatibilityLevel = 5` via Group Policy enforces NTLMv2 only and blocks downgrade attempts
- LM (LAN Manager) hashes split passwords into two 7-character chunks, making them trivially brute-forceable—NTLMv1 can still expose LM hashes in legacy configurations

## Related concepts
[[NTLM Relay Attack]] [[Pass-the-Hash]] [[Responder Tool]] [[SMB Signing]] [[Credential Capture]]