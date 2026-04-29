# Credential Dumping T1003

## What it is
Imagine a thief who doesn't pick every lock individually — instead, they steal the master key cabinet from the security office. Credential dumping is the post-exploitation technique where attackers extract authentication credentials (password hashes, plaintext passwords, Kerberos tickets) directly from OS memory, registry hives, or credential stores rather than brute-forcing them one at a time.

## Why it matters
In the 2020 SolarWinds attack, threat actors used credential dumping via tools like Mimikatz to harvest domain credentials from LSASS memory, allowing lateral movement across victim networks without triggering brute-force alerts. Defenders who implemented Credential Guard and monitored for LSASS process access caught variants of this behavior before full domain compromise occurred.

## Key facts
- **Primary target is LSASS.exe** — the Windows Local Security Authority Subsystem Service holds credential material in memory; Mimikatz's `sekurlsa::logonpasswords` directly reads it
- **Sub-techniques matter for exams**: T1003.001 (LSASS Memory), T1003.002 (SAM registry hive), T1003.003 (NTDS.dit — Active Directory database), T1003.006 (DCSync attack)
- **Pass-the-Hash (PtH)** attacks are the common follow-on: NTLM hashes can be used directly for authentication without cracking them
- **Detection signatures**: unusual processes opening LSASS with `PROCESS_VM_READ` access, VSS shadow copy access to NTDS.dit, or `reg save HKLM\SAM` commands
- **Mitigations**: Windows Credential Guard (isolates LSASS in a hypervisor-protected container), Protected Users security group, and disabling WDigest authentication (prevents plaintext caching)

## Related concepts
[[Pass-the-Hash]] [[Mimikatz]] [[Lateral Movement]] [[LSASS Protection]] [[Kerberoasting]]