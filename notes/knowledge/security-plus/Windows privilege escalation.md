# Windows privilege escalation

## What it is
Like a hotel guest who finds a master keycard left in a housekeeping cart and uses it to access every room — Windows privilege escalation is the technique attackers use to move from a low-privileged account (e.g., a standard user) to a higher-privileged one (e.g., SYSTEM or Administrator) by exploiting misconfigurations, vulnerable services, or unpatched flaws.

## Why it matters
In the 2020 SolarWinds attack, once adversaries established an initial foothold via malicious DLL injection, they leveraged privilege escalation techniques to gain SYSTEM-level access on compromised Windows hosts — enabling lateral movement and persistent access across thousands of networks. Defenders who had enforced least privilege and monitored for token manipulation would have significantly raised the cost of that escalation.

## Key facts
- **Unquoted service paths** allow attackers to plant a malicious executable in a directory Windows searches before reaching the real binary — a classic misconfiguration caught by tools like WinPEAS
- **Token impersonation attacks** (e.g., Juicy Potato, PrintSpoofer) abuse Windows tokens to impersonate SYSTEM by exploiting SeImpersonatePrivilege, commonly held by service accounts
- **AlwaysInstallElevated** is a Group Policy misconfiguration that lets any user install MSI packages as SYSTEM — detectable via registry keys `HKLM\SOFTWARE\Policies\Microsoft\Windows\Installer`
- **DLL hijacking** exploits Windows' DLL search order; a writable directory earlier in the path allows an attacker to substitute a malicious DLL for a legitimate one loaded by a privileged process
- **Scheduled Tasks and weak ACLs** on service binaries are the most commonly exploited misconfiguration categories in CTF and real-world engagements alike

## Related concepts
[[Access Control Lists]] [[Lateral Movement]] [[Token Impersonation]] [[Least Privilege]] [[DLL Hijacking]]