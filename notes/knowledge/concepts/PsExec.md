# PsExec

## What it is
Think of PsExec as a remote control for Windows machines — like having a keyboard and terminal plugged directly into another computer across the network without physically touching it. Precisely, PsExec is a legitimate Sysinternals command-line tool that allows administrators to execute processes on remote Windows systems using SMB (port 445), passing credentials to spawn interactive sessions without needing pre-installed client software.

## Why it matters
In the 2017 NotPetya attack and countless ransomware campaigns since, attackers used PsExec to laterally move through corporate networks after obtaining a single set of valid credentials — executing malicious payloads on dozens of machines within minutes. Defenders watch for PsExec activity in SIEM alerts because even legitimate use is rare enough that it warrants investigation; its presence often signals an active intrusion or red team operation.

## Key facts
- PsExec operates over **SMB (TCP 445)** and authenticates using Windows credentials, including pass-the-hash techniques with NTLM hashes
- It works by copying a small service binary (`PSEXESVC.exe`) to the target's `ADMIN$` share, then creating a temporary Windows service to execute commands — leaving artifacts in the Windows Event Log (Event ID **7045** = new service installed)
- Commonly flagged by EDR tools because the PSEXESVC service creation pattern is a well-known **Indicator of Compromise (IoC)**
- Falls under **MITRE ATT&CK T1569.002** (System Services: Service Execution) and **T1021.002** (SMB/Windows Admin Shares)
- Blocking **ADMIN$** share access and enforcing **network segmentation** are primary defensive controls against PsExec-style lateral movement

## Related concepts
[[Lateral Movement]] [[Pass-the-Hash]] [[SMB Protocol]] [[MITRE ATT&CK]] [[Windows Admin Shares]]