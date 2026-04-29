# Arbitrary File Write as SYSTEM

## What it is
Imagine a master locksmith who will engrave *any name you dictate* onto *any door* in the building — including the server room. An arbitrary file write as SYSTEM is a vulnerability where an attacker can create or overwrite any file on a Windows system using the highest-privilege local account (NT AUTHORITY\SYSTEM), bypassing normal access controls entirely.

## Why it matters
In the PrintNightmare exploit (CVE-2021-34527), attackers leveraged the Windows Print Spooler service — running as SYSTEM — to write a malicious DLL into a trusted directory, achieving immediate local privilege escalation or remote code execution. Defenders prioritize patching services that run as SYSTEM precisely because a write primitive in that context is effectively game over for the host.

## Key facts
- **Write + execute = RCE**: Dropping a malicious DLL into `C:\Windows\System32` or a startup path converts a write primitive into code execution at SYSTEM level.
- **DLL hijacking amplifier**: Arbitrary write as SYSTEM lets attackers plant DLLs in locations a privileged process will load before the legitimate one (search-order hijacking).
- **Symbolic link abuse**: Many arbitrary write vulnerabilities are triggered by creating NTFS junction points or symlinks that redirect a SYSTEM process's intended write to a sensitive target path.
- **Scheduled tasks / services as targets**: Overwriting executables or configs for services/tasks set to auto-run converts a one-time write into persistent, automatic SYSTEM execution.
- **Integrity levels matter**: Windows Mandatory Integrity Control (MIC) normally blocks low-integrity processes from writing to high-integrity locations — a SYSTEM write vulnerability bypasses this entirely.

## Related concepts
[[privilege escalation]] [[DLL hijacking]] [[NTFS symbolic link attacks]] [[Windows integrity levels]] [[PrintNightmare CVE-2021-34527]]