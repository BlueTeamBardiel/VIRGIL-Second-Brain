# MITRE ATT&CK T1112

## What it is
Think of the Windows Registry as a city's zoning records — if you can quietly alter the permits, you can make illegal structures look official. T1112 (Modify Registry) describes adversaries reading, creating, modifying, or deleting Registry keys and values to achieve persistence, privilege escalation, defense evasion, or configuration changes — all without touching the filesystem in obvious ways.

## Why it matters
During the SolarWinds SUNBURST attack, the malware modified Registry values to store encoded configuration data and beacon timing, blending into normal Windows behavior. Defenders monitoring only file-based indicators completely missed these changes, demonstrating why Registry auditing via Sysmon Event ID 13 (RegistryValueSet) is critical for detection.

## Key facts
- Common persistence location: `HKCU\Software\Microsoft\Windows\CurrentVersion\Run` — entries here auto-execute on user login without requiring elevated privileges
- Attackers use `reg.exe`, `regedit.exe`, PowerShell's `Set-ItemProperty`, or direct Windows API calls (`RegSetValueEx`) to make changes
- Defense evasion use case: disabling security tools by setting `HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\DisableAntiSpyware = 1`
- Detection data sources: Windows Security Event ID 4657 (Registry value modified) and Sysmon Event IDs 12–14 provide the most granular Registry telemetry
- Mitigation includes restricting Registry permissions via ACLs and enabling audit policies under **Object Access → Audit Registry**

## Related concepts
[[Windows Registry]] [[T1547.001 Registry Run Keys Persistence]] [[Defense Evasion]] [[Sysmon]] [[T1562.001 Disable Security Tools]]