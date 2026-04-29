# MITRE ATT&CK T1134

## What it is
Like a thief who steals a hotel master keycard and uses it to open rooms they were never authorized to enter, Access Token Manipulation is when an attacker forges or hijacks Windows security tokens to impersonate other users or escalate privileges. Windows uses access tokens to define the security context of every running process; attackers abuse this mechanism to make malicious code appear to run as SYSTEM, a domain admin, or any other trusted identity.

## Why it matters
During the SolarWinds campaign, threat actors used token impersonation techniques to move laterally through networks while appearing as legitimate service accounts, making detection extremely difficult. Defenders monitor for anomalous token creation events (Event ID 4674, 4675) and processes holding privileges inconsistent with their parent process lineage.

## Key facts
- **Sub-techniques include:** Token Impersonation/Theft (T1134.001), Create Process with Token (T1134.002), Make and Impersonate Token (T1134.003), Parent PID Spoofing (T1134.004), and SID-History Injection (T1134.005)
- `SeImpersonatePrivilege` and `SeAssignPrimaryTokenPrivilege` are the Windows privileges required for most token manipulation attacks
- Tools like **Incognito** (built into Meterpreter) and **Cobalt Strike** automate token stealing to impersonate logged-in users
- Parent PID spoofing tricks EDR/SIEM tools into believing a malicious process was spawned by a trusted parent (e.g., making malware look like it was launched by `explorer.exe`)
- SID-History Injection plants a privileged SID into an account's history, granting domain admin-level access without modifying group membership — a stealthy persistence method

## Related concepts
[[Privilege Escalation]] [[Windows Access Tokens]] [[Pass the Hash]] [[Lateral Movement]] [[SID-History Injection]]