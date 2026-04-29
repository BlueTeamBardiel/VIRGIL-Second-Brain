# MITRE ATT&CK T1068

## What it is
Like a janitor who finds a master key hidden in a maintenance closet, an attacker exploiting T1068 uses a software vulnerability to upgrade their access from "nobody" to "system owner." Privilege Escalation: Exploitation for Privilege Escalation describes the technique of exploiting programming flaws in the OS kernel, drivers, or privileged applications to gain higher-level permissions than originally granted.

## Why it matters
In the 2021 PrintNightmare (CVE-2021-34527) attacks, threat actors exploited a flaw in the Windows Print Spooler service to escalate from a standard domain user to SYSTEM-level access, then deployed ransomware across entire networks. Defenders who had disabled the Print Spooler service on non-printing servers were completely immune, illustrating how attack surface reduction neutralizes this technique before it starts.

## Key facts
- T1068 is classified under the **Privilege Escalation** tactic (TA0004) in the ATT&CK framework
- Commonly targets **kernel drivers, SUID binaries (Linux), and privileged Windows services** — wherever code runs at elevated context
- Differs from T1548 (Abuse Elevation Control Mechanism) — T1068 exploits a *vulnerability*, not a *design feature* like sudo or UAC
- Detection signals include **unexpected parent-child process relationships** (e.g., spoolsv.exe spawning cmd.exe) and anomalous privilege tokens
- Patching cadence directly counters T1068; unpatched systems are the primary attack surface

## Related concepts
[[Kernel Exploitation]] [[Privilege Escalation]] [[CVE Vulnerability Management]] [[Attack Surface Reduction]] [[Mandatory Access Control]]