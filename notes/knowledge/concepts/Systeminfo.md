# systeminfo

## What it is
Like reading the VIN plate, spec sheet, and service history of a car all at once, `systeminfo` is a Windows command-line utility that dumps a comprehensive snapshot of a host's configuration in a single command. It reveals OS version, patch level, hardware specs, hotfix history, and network adapter details in one shot.

## Why it matters
During post-exploitation, attackers run `systeminfo` within the first minutes of gaining a foothold to identify missing patches and plan privilege escalation — for example, confirming a system is missing MS17-010 (EternalBlue) before deploying a follow-on exploit. Defenders and incident responders use the same output to rapidly profile a compromised host and correlate its patch state against known CVEs during triage.

## Key facts
- Outputs the exact OS build number and installed hotfixes (`HotFix(s)` field), making it the fastest way to manually audit missing patches on a live system
- Commonly piped into `systeminfo | findstr /B /C:"OS"` or fed into tools like **Windows Exploit Suggester** to automate vulnerability identification
- The `wmic qfe list` command and PowerShell's `Get-HotFix` are functional equivalents that evade simple string-based detection of "systeminfo" in command logs
- Generating a `systeminfo` output and diffing it against a baseline is a core step in CIS Benchmark compliance verification
- Its execution is logged under **Event ID 4688** (Process Creation) when command-line auditing is enabled, making it detectable in a SIEM

## Related concepts
[[Windows Privilege Escalation]] [[Patch Management]] [[Post-Exploitation Enumeration]] [[Event ID 4688]] [[Windows Exploit Suggester]]