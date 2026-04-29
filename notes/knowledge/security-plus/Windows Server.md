# Windows Server

## What it is
Think of it as the backstage crew of a theater — invisible to the audience but controlling lighting, sound, and doors for every performer. Windows Server is Microsoft's line of operating systems designed to manage centralized network services: user authentication, file sharing, DNS, DHCP, and application hosting across enterprise environments.

## Why it matters
In the 2021 Microsoft Exchange Server attacks (HAFNIUM), threat actors exploited ProxyLogon vulnerabilities to bypass authentication and deploy web shells on unpatched Windows Servers, compromising tens of thousands of organizations worldwide. Defenders must prioritize patch management and monitor for anomalous IIS process spawning — a classic indicator of web shell execution on Windows Server environments.

## Key facts
- **Active Directory Domain Services (AD DS)** runs on Windows Server and is the primary target in lateral movement attacks — compromise a Domain Controller and you own the domain
- **SMB (Server Message Block)** protocol, native to Windows Server, was weaponized by EternalBlue (MS17-010), enabling WannaCry ransomware to spread without user interaction
- Windows Server uses **NTLM and Kerberos** for authentication; NTLM is legacy and vulnerable to pass-the-hash attacks, while Kerberos is vulnerable to Kerberoasting
- **Security baseline GPOs (Group Policy Objects)** are the primary hardening mechanism — CIS Benchmarks provide specific settings for Windows Server hardening
- Windows Server **Event Log IDs** are exam-critical: 4624 (successful logon), 4625 (failed logon), 4648 (explicit credential use), and 7045 (new service installed — common persistence indicator)

## Related concepts
[[Active Directory]] [[Kerberos Authentication]] [[SMB Protocol]] [[Pass-the-Hash Attack]] [[Group Policy]]