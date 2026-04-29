# LOLBins

## What it is
Like a burglar using your own house keys, ladder, and crowbar to rob you — LOLBins (Living Off the Land Binaries) are legitimate, pre-installed system tools that attackers repurpose to execute malicious actions without dropping custom malware. These are trusted executables (e.g., `certutil.exe`, `powershell.exe`, `mshta.exe`) that are signed by the OS vendor and already present on the target machine.

## Why it matters
In the 2020 SolarWinds attack, threat actors used `rundll32.exe` and PowerShell — both native Windows tools — to execute payloads and move laterally, making detection extremely difficult because no foreign binaries touched disk. Defenders must tune SIEMs to flag *abnormal usage* of trusted binaries rather than just blocking unknown executables.

## Key facts
- **Bypass allowlisting**: Because LOLBins are signed and trusted, application whitelisting controls like AppLocker often fail to block them by default.
- **Common examples**: `certutil.exe` (download files), `wmic.exe` (execute commands remotely), `regsvr32.exe` (load COM scriptlets), `mshta.exe` (run HTA files).
- **Fileless malware overlap**: LOLBins often enable fileless attacks — payloads run in memory via PowerShell without writing to disk, evading traditional AV.
- **Detection strategy**: Behavioral analytics (UEBA) and Sysmon logging of process creation, parent-child relationships, and command-line arguments are the primary detection controls.
- **MITRE ATT&CK mapping**: LOLBins appear prominently under **T1218** (System Binary Proxy Execution) and **T1059** (Command and Scripting Interpreter).

## Related concepts
[[Fileless Malware]] [[Application Whitelisting]] [[MITRE ATT&CK]] [[Defense Evasion]] [[PowerShell Attack Techniques]]