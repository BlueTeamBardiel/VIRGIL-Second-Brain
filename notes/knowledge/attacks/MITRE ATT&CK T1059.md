# MITRE ATT&CK T1059

## What it is
Like a locksmith who breaks in not by picking the lock but by *calling the building manager and talking them into opening the door*, Command and Scripting Interpreter abuse turns a system's own legitimate tools against it. T1059 covers adversaries who execute malicious commands through built-in interpreters — PowerShell, Bash, Python, cmd.exe — rather than dropping suspicious executables that AV will flag.

## Why it matters
During the SolarWinds Orion breach, threat actors used PowerShell (T1059.001) to run encoded, obfuscated commands in memory — leaving minimal disk artifacts and bypassing traditional signature-based detection. Defenders who monitored only file creation missed the attack entirely; those logging PowerShell ScriptBlock events caught the encoded payloads and traced lateral movement before exfiltration completed.

## Key facts
- T1059 is consistently the **#1 most observed technique** across ATT&CK enterprise detections year over year
- Sub-techniques include: **.001 PowerShell**, .002 AppleScript, .003 Windows Command Shell, .004 Unix Shell, .006 Python, .007 JavaScript
- PowerShell **Constrained Language Mode** and **AMSI (Anti-Malware Scan Interface)** are primary mitigations for .001
- **Script block logging** (Windows Event ID 4104) captures decoded PowerShell at runtime — critical for forensics even when attackers use `-EncodedCommand`
- Living-off-the-land (LotL) attacks rely heavily on T1059 because interpreters are **signed, whitelisted, and trusted** by default application control policies

## Related concepts
[[Living-Off-the-Land Attacks]] [[PowerShell Logging and AMSI]] [[MITRE ATT&CK Defense Evasion]] [[Application Whitelisting]] [[Fileless Malware]]