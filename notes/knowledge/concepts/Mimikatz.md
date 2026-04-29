# Mimikatz

## What it is
Think of Windows memory as a hotel safe where the front desk keeps master key copies "just in case" — Mimikatz is the crowbar that pops that safe open. It is an open-source credential-harvesting tool that extracts plaintext passwords, NTLM hashes, Kerberos tickets, and PIN codes directly from Windows memory (specifically the LSASS process).

## Why it matters
In the 2017 NotPetya attack, credential-dumping techniques mirroring Mimikatz functionality allowed the malware to harvest admin credentials from memory and use them to spread laterally across entire corporate networks within minutes — turning a single infected workstation into a full domain compromise. Defenders counter this by enabling Windows Credential Guard, which moves credential secrets into a virtualization-based isolated enclave that LSASS can no longer directly access.

## Key facts
- **Primary target:** LSASS.exe (Local Security Authority Subsystem Service) — the Windows process responsible for authentication that caches credentials in memory
- **Requires SYSTEM or local admin privileges** to access LSASS memory; privilege escalation typically precedes its use
- **Pass-the-Hash (PtH)** attacks are enabled by Mimikatz — attackers reuse harvested NTLM hashes without ever cracking the plaintext password
- **Key modules:** `sekurlsa::logonpasswords` (dump credentials), `lsadump::dcsync` (simulate a Domain Controller to pull password hashes), `kerberos::golden` (craft Golden Tickets)
- **Mitigations:** Enable Windows Credential Guard, disable WDigest authentication (prevents plaintext storage), apply Protected Users security group, and monitor for suspicious LSASS memory access via EDR tools

## Related concepts
[[Pass-the-Hash]] [[Kerberos]] [[LSASS]] [[Credential Guard]] [[Lateral Movement]]