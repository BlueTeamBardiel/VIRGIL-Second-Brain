# LSASS

## What it is
Think of LSASS as the bouncer at a nightclub who holds a master list of every valid ID — except this bouncer also keeps photocopies of those IDs in his pocket at all times. LSASS (Local Security Authority Subsystem Service) is a Windows process (`lsass.exe`) responsible for enforcing security policy, handling authentication, and storing credential material — including plaintext passwords, NTLM hashes, and Kerberos tickets — in memory during an active session.

## Why it matters
In the 2020 SolarWinds breach and countless ransomware intrusions, attackers used tools like **Mimikatz** to dump LSASS memory and harvest credentials for lateral movement — a technique so prevalent it earned its own MITRE ATT&CK entry (T1003.001). Defenders counter this by enabling **Credential Guard**, which isolates LSASS secrets in a virtualization-based secure enclave that Mimikatz cannot reach.

## Key facts
- LSASS runs as `lsass.exe` under SYSTEM privileges; a process pretending to be LSASS in a different location is a red flag for masquerading attacks
- Dumping LSASS memory can be done via Task Manager, ProcDump, or direct API calls — all produce a `.dmp` file containing harvestable credentials
- **Windows Defender Credential Guard** (requires UEFI + Virtualization) moves credential storage to an isolated `LSAIso.exe` process, defeating traditional dump attacks
- Enabling **Protected Process Light (PPL)** for LSASS prevents standard user-mode processes from opening a handle to it with `PROCESS_VM_READ` access
- Event ID **4624** (logon success) and **10** in Sysmon (process access to lsass.exe) are critical detection signals for credential dumping activity

## Related concepts
[[Mimikatz]] [[Credential Guard]] [[Pass-the-Hash]] [[Kerberos]] [[NTLM Authentication]]