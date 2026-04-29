# PrintSpoofer

## What it is
Like a backstage pass that lets a janitor walk into the director's booth by impersonating a VIP through a walkie-talkie channel, PrintSpoofer exploits the Windows Print Spooler named pipe to trick the SYSTEM account into authenticating to an attacker-controlled endpoint. It is a local privilege escalation tool that abuses `SeImpersonatePrivilege` to impersonate a SYSTEM-level token and spawn a high-privileged shell.

## Why it matters
In a real-world penetration test, an attacker who compromises an IIS web server or SQL Server service account (both commonly granted `SeImpersonatePrivilege`) can immediately run PrintSpoofer to escalate to full SYSTEM access — turning a limited foothold into complete machine control. Defenders must audit service accounts for unnecessary privileges and monitor for suspicious named pipe creation events (`\\.\pipe\`) to detect this technique.

## Key facts
- Exploits `SeImpersonatePrivilege`, a privilege commonly assigned to service accounts like `NT AUTHORITY\NETWORK SERVICE` and `IIS APPPOOL\*`
- Triggers the Print Spooler service (`spoolsv.exe`) to connect back to a fake named pipe controlled by the attacker, then steals its SYSTEM token
- Works on Windows 10 and Windows Server 2019 — not limited to legacy systems like older potato attacks
- Functionally similar to the "Potato" family (RottenPotato, JuicyPotato), but bypasses mitigations Microsoft applied against those earlier tools
- Can be detected via Sysmon Event ID 17/18 (named pipe creation/connection) and anomalous `CreateProcessWithTokenW` API calls

## Related concepts
[[Privilege Escalation]] [[SeImpersonatePrivilege]] [[Named Pipes]] [[JuicyPotato]] [[Access Tokens]]