# PowerSploit

## What it is
Think of it like a Swiss Army knife left inside the house after a locksmith visit — it's already past the door and ready to do serious work. PowerSploit is an open-source, PowerShell-based post-exploitation framework that provides attackers (and red teamers) with a collection of modules for privilege escalation, code execution, persistence, reconnaissance, and credential harvesting after initial access is achieved.

## Why it matters
During a red team engagement or a real APT intrusion, attackers who land on a Windows machine without admin rights can use PowerSploit's `Invoke-PrivescAudit` to automatically identify misconfigured services, unquoted paths, and weak registry permissions — then exploit them to escalate to SYSTEM. Defenders analyzing endpoint logs frequently see PowerSploit's fingerprints in the form of obfuscated PowerShell execution with `-EncodedCommand` flags and suspicious `Invoke-*` function calls in Windows Event ID 4104 logs.

## Key facts
- PowerSploit is hosted on GitHub and consists of discrete modules organized into categories: **Recon**, **Exfiltration**, **Privesc**, **Persistence**, **CodeExecution**, and **AntivirusBypass**
- The `Invoke-Mimikatz` module wraps Mimikatz functionality entirely within PowerShell memory, enabling credential dumping without dropping a binary to disk (fileless technique)
- `Get-GPPPassword` was a heavily used module that extracted plaintext credentials stored in Group Policy Preference XML files before MS14-025 patched this behavior
- PowerSploit executes largely **in-memory**, bypassing traditional signature-based AV — detection relies on behavioral analysis, AMSI (Antimalware Scan Interface), and PowerShell Script Block Logging
- It is now considered **deprecated/unmaintained** by its original authors, but its modules were absorbed into frameworks like **PowerSharpPack** and **Empire**

## Related concepts
[[PowerShell Empire]] [[Mimikatz]] [[Living off the Land (LotL)]] [[AMSI]] [[Privilege Escalation]]