# credential dumping

## What it is
Think of Windows memory like a hotel's master key cabinet left unlocked — an attacker who gets inside can photograph every key at once. Credential dumping is the post-exploitation technique of extracting authentication credentials (passwords, hashes, Kerberos tickets) from operating system memory, registry hives, or credential stores after gaining initial access. Tools like Mimikatz exploit how Windows caches plaintext passwords or NTLM hashes in the LSASS process.

## Why it matters
In the 2020 SolarWinds attack, threat actors used credential dumping to harvest service account credentials after initial compromise, enabling lateral movement across thousands of networks without triggering password-spray alerts. Defenders counter this by enabling Credential Guard (which isolates LSASS in a virtualization-based security container) and monitoring for suspicious access to the LSASS process via Sysmon Event ID 10.

## Key facts
- **MITRE ATT&CK T1003** catalogs credential dumping under the Credential Access tactic, with sub-techniques for SAM, LSASS Memory, NTDS.dit, and DCSync
- **LSASS (Local Security Authority Subsystem Service)** is the primary target because Windows caches credentials there to support single sign-on
- **Pass-the-Hash (PtH)** attacks often follow dumping — attackers reuse NTLM hashes without ever cracking them
- The **Windows SAM database** stores local account hashes, but is locked while the OS runs; attackers use Volume Shadow Copies to read it offline
- **DCSync** is a stealthy variant where an attacker mimics a domain controller replication request to pull password hashes from Active Directory without touching disk

## Related concepts
[[Pass-the-Hash]] [[Lateral Movement]] [[Kerberoasting]] [[LSASS]] [[Mimikatz]]