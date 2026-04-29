# PowerUp

## What it is
Like a building inspector who checks every door, window, and utility closet for code violations, PowerUp systematically audits a Windows system for misconfigured services and weak permissions. It is a PowerShell script (part of the PowerSploit framework) designed to enumerate common Windows privilege escalation vectors — finding paths that let a low-privileged user gain SYSTEM or administrator access.

## Why it matters
During a penetration test, an attacker lands on a workstation with a standard domain user account. Running PowerUp reveals that a third-party antivirus service has an unquoted service path with a space in it — meaning a malicious executable planted at `C:\Program Files\Vendor\Evil.exe` will execute as SYSTEM when the service restarts. Without PowerUp-style checks, defenders wouldn't know this misconfiguration existed.

## Key facts
- **Unquoted service paths** are PowerUp's most famous check — if a service path contains spaces and isn't quoted, Windows resolves the path ambiguously, allowing executable hijacking.
- PowerUp checks **weak service permissions**, **AlwaysInstallElevated** registry keys, **weak registry ACLs**, **DLL hijacking** opportunities, and **writable scheduled task paths**.
- `AlwaysInstallElevated` (both HKCU and HKLM set to 1) allows any `.msi` package to run with SYSTEM privileges — a critical misconfiguration PowerUp detects.
- PowerUp is invoked with `Invoke-AllChecks` to run its full suite; individual functions like `Get-UnquotedService` can be called in isolation.
- Defenders use PowerUp offensively (in assessments) and defensively — running it on gold images to catch misconfigurations before attackers do.

## Related concepts
[[Privilege Escalation]] [[Unquoted Service Path]] [[PowerSploit]] [[AlwaysInstallElevated]] [[Windows Service Misconfigurations]]