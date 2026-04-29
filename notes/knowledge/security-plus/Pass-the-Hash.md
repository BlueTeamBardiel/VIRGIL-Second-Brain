# pass-the-hash

## What it is
Imagine getting into a nightclub not by knowing the password, but by stealing the bouncer's stamp impression and pressing it on your own hand — you never needed the original ink. Pass-the-hash is exactly that: an attacker captures the hashed version of a Windows credential from memory and replays it directly against authentication systems, bypassing the need to crack the actual plaintext password.

## Why it matters
In the 2017 NotPetya outbreak, attackers used pass-the-hash (via credential-harvesting tools like Mimikatz) to move laterally across corporate networks at devastating speed — once one machine was compromised, the hash from a domain admin account let them authenticate everywhere that account had access. Defenders counter this by enabling Windows Defender Credential Guard, which isolates credential hashes in a virtualized memory space that Mimikatz cannot reach.

## Key facts
- Pass-the-hash exploits NTLM authentication, which accepts a hash directly as proof of identity — NTLM never requires the plaintext password to be derived from the hash
- Mimikatz is the canonical tool for extracting NTLM hashes from the LSASS process in Windows memory
- Restricting or disabling NTLM in favor of Kerberos significantly reduces the attack surface, since Kerberos tickets are time-limited and tied to specific session contexts
- The attack is particularly dangerous in environments with shared local administrator passwords — one compromised machine exposes all machines (mitigated by Microsoft's LAPS tool)
- On Security+/CySA+ exams, pass-the-hash is classified as a **lateral movement** technique under credential-based attacks

## Related concepts
[[NTLM authentication]] [[Mimikatz]] [[lateral movement]] [[credential dumping]] [[Kerberos]]