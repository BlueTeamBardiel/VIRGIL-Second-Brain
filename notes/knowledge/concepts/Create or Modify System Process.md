# Create or Modify System Process

## What it is
Like a forger slipping a fake employee onto the payroll so they collect paychecks unnoticed, attackers plant or alter system-level processes to run malicious code under the operating system's own authority. Precisely, this is MITRE ATT&CK Technique T1543, where adversaries create, modify, or hijack processes that execute with elevated privileges and persist across reboots — such as Windows services, launchd jobs on macOS, or systemd units on Linux.

## Why it matters
The 2020 SolarWinds breach used a modified Windows service (SolarWinds.BusinessLayerHost.exe) to load the SUNBURST backdoor, disguising malicious activity as a trusted, signed process. Because the malicious code ran inside a legitimate service context, EDR tools relying on process reputation had to look at behavioral anomalies rather than simply blocking an unknown executable.

## Key facts
- **Sub-techniques include:** Windows Services (T1543.003), Systemd Service (T1543.002), Launch Agent/Daemon (T1543.001/004), and RC Scripts (T1543.005)
- **Persistence + Privilege Escalation in one move:** Services often run as SYSTEM or root, granting attackers high-privilege execution that survives reboots automatically
- **Detection signal:** Unexpected service creation events appear in Windows Event ID **7045** (new service installed) and **4697** (service installed in security audit log)
- **Common masquerade tactic:** Adversaries name malicious services after legitimate ones (e.g., "svchost32.exe") to blend into process lists during casual inspection
- **Defense:** Application whitelisting, monitoring service control manager (SCM) changes, and integrity checks on service binaries catch unauthorized modifications before execution

## Related concepts
[[Persistence]] [[Privilege Escalation]] [[Masquerading]] [[Windows Event Log Monitoring]] [[Defense Evasion]]