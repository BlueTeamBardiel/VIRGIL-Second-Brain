# LSASS Credential Dumping

## What it is
Think of LSASS like a hotel concierge holding a master keycard log — it knows every guest's credentials so it can let them through doors automatically. The Local Security Authority Subsystem Service (LSASS) is a Windows process that stores authentication credentials (password hashes, Kerberos tickets, NTLM tokens) in memory to support seamless single sign-on. Attackers who access LSASS memory can extract those credentials and use them to move laterally across an entire network.

## Why it matters
In the 2020 SolarWinds attack, threat actors used credential dumping techniques — including LSASS access — to harvest credentials and pivot through victim networks undetected for months. Defenders respond by enabling Windows Credential Guard, which moves LSASS secrets into a virtualization-based isolated environment that even a SYSTEM-level attacker cannot directly read.

## Key facts
- **Primary tool:** Mimikatz's `sekurlsa::logonpasswords` command is the canonical LSASS dumping method, extracting plaintext passwords when WDigest authentication is enabled
- **MITRE ATT&CK:** Mapped to T1003.001 (OS Credential Dumping: LSASS Memory)
- **Detection signal:** Unexpected processes (e.g., `cmd.exe`, `procdump.exe`) opening a handle to `lsass.exe` with `PROCESS_VM_READ` access rights triggers alerts in EDR tools
- **Windows defense:** Enabling PPL (Protected Process Light) for LSASS prevents non-kernel-signed processes from reading its memory — configured via `RunAsPPL` registry key
- **WDigest risk:** On Windows 7/Server 2008 R2, WDigest stores plaintext passwords in LSASS by default; modern systems have it disabled but it can be re-enabled by attackers via registry modification

## Related concepts
[[Pass-the-Hash Attack]] [[Mimikatz]] [[Credential Guard]] [[Kerberos Ticket Attacks]] [[Lateral Movement]]