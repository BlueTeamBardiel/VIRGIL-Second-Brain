# Boot or Logon Initialization Scripts

## What it is
Like a restaurant prep cook who arrives before anyone else and sets up the kitchen before service begins, initialization scripts run automatically before — or as — a user logs in, executing whatever instructions are baked into them. These are scripts (batch files, shell scripts, PowerShell, etc.) that operating systems execute during the boot sequence or logon process, typically with elevated privileges or in a high-trust context.

## Why it matters
APT groups like APT29 have embedded malicious PowerShell scripts into Windows Group Policy logon scripts, ensuring every domain user who logs in silently executes attacker code — giving the adversary persistent, widespread footholds without touching disk in obvious ways. Defenders hunt for unexpected entries in Group Policy Objects (GPOs) and `/etc/profile.d/` directories specifically because these locations are prime persistence real estate.

## Key facts
- **MITRE ATT&CK T1037** covers this technique, with sub-techniques including Logon Scripts (Windows), Logon Scripts (Mac), Network Logon Scripts, RC Scripts, and Startup Items
- Windows logon scripts can be deployed via Group Policy under `User Configuration → Windows Settings → Scripts`
- On Linux/macOS, common persistence locations include `/etc/rc.local`, `/etc/profile`, `/etc/profile.d/`, and user-level `~/.bash_profile` or `~/.zshrc`
- Scripts run in the security context of the user logging in — or SYSTEM if configured at boot — making privilege level highly dependent on *when* the script fires
- Detection focus: monitor `HKLM\Software\Microsoft\Windows\CurrentVersion\Group Policy\Scripts` and audit GPO changes via Windows Event ID 4657

## Related concepts
[[Persistence Mechanisms]] [[Group Policy Objects]] [[Privilege Escalation]] [[Registry Run Keys]] [[Living Off the Land Binaries]]