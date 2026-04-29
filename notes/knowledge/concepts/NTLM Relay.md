# NTLM Relay

## What it is
Imagine a bouncer who stamps your hand based on someone else's ID — NTLM Relay works the same way. An attacker intercepts a victim's NTLM authentication challenge-response mid-transit and immediately "replays" it to a different server, impersonating the victim without ever cracking the password hash.

## Why it matters
In a classic internal pentest scenario, an attacker runs Responder to poison LLMNR/NBT-NS broadcasts, capturing NTLM authentication attempts from workstations searching for network resources. Those captured credentials are piped directly into ntlmrelayx, which relays them to a domain controller or file share — potentially granting full admin access or enabling secretsdump of the SAM database, all without a single cracked password.

## Key facts
- NTLM Relay exploits the **lack of mutual authentication** in NTLMv1/v2 — the client never verifies the server's identity before sending credentials
- **SMB Signing**, when enforced, defeats relay attacks because the signature binds authentication to that specific session cryptographically
- Tools like **Responder + ntlmrelayx** are the standard attacker combo; Responder poisons, ntlmrelayx weaponizes
- **CVE-2019-1040 (Drop the MIC)** demonstrated that even SMB Signing negotiation could be bypassed, extending relay viability
- Mitigations include: enforcing SMB Signing on all hosts, disabling NTLMv1, enabling **EPA (Extended Protection for Authentication)**, and blocking LLMNR/NBT-NS via Group Policy

## Related concepts
[[LLMNR Poisoning]] [[Pass-the-Hash]] [[SMB Signing]] [[Kerberos Authentication]] [[Credential Capture]]