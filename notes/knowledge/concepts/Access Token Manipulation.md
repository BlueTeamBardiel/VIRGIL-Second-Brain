# Access Token Manipulation

## What it is
Think of a Windows access token like a wristband at a concert — it proves who you are and what areas you're allowed into, and if you can steal or forge someone else's wristband, you go wherever they go. Precisely, an access token is a Windows OS object that describes the security context of a process or thread, containing a user's identity and privileges. Attackers manipulate these tokens to impersonate higher-privileged users without needing their credentials.

## Why it matters
During the SolarWinds breach, attackers used token impersonation techniques post-compromise to move laterally across networks by hijacking the security context of privileged service accounts already running on compromised systems. Defenders counter this by monitoring for unusual calls to Windows API functions like `ImpersonateLoggedOnUser()` or `DuplicateTokenEx()`, which are strong indicators of in-memory privilege escalation with no malware dropped to disk.

## Key facts
- **MITRE ATT&CK T1134** covers Access Token Manipulation with five sub-techniques: Token Impersonation/Theft, Create Process with Token, Make and Impersonate Token, Parent PID Spoofing, and SID-History Injection.
- **SeImpersonatePrivilege** and **SeAssignPrimaryTokenPrivilege** are the Windows privileges that make token manipulation possible — service accounts commonly hold these.
- Token manipulation is a **fileless technique**, making it largely invisible to signature-based AV tools; detection requires behavioral analysis or EDR solutions.
- **Incognito** (Metasploit module) and **Mimikatz** are common tools attackers use to list and steal available tokens on a compromised host.
- Tokens have **two types**: primary tokens (assigned to processes) and impersonation tokens (used by threads to temporarily act as another user).

## Related concepts
[[Privilege Escalation]] [[Pass the Hash]] [[Windows Security Subsystem]] [[Lateral Movement]] [[Mimikatz]]