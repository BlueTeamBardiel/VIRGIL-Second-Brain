# Microsoft Windows

## What it is
Like a landlord managing an apartment complex, Windows controls who gets access to which rooms, allocates shared resources, and enforces house rules for every tenant (application) running on the hardware. Precisely, it is a proprietary operating system developed by Microsoft that manages hardware resources, provides a GUI, and enforces access controls through mechanisms like the Security Reference Monitor and Active Directory integration.

## Why it matters
In 2017, the WannaCry ransomware exploited **EternalBlue** (MS17-010), a critical flaw in Windows SMBv1, compromising over 200,000 systems across 150 countries — including hospitals that lost access to patient records mid-surgery. Organizations running unpatched Windows systems learned the hard way that delayed patching is a business continuity catastrophe, not just a technical inconvenience.

## Key facts
- Windows uses **Security Identifiers (SIDs)** to uniquely identify users and groups; ACLs reference SIDs, not usernames, making SID history a common lateral movement vector
- **NTLM and Kerberos** are the two primary authentication protocols; Kerberos is preferred in domain environments, but NTLM fallback creates Pass-the-Hash attack opportunities
- The **SAM (Security Accounts Manager)** database stores local credential hashes; attackers target it via tools like Mimikatz after gaining SYSTEM-level access
- Windows event logs (Security, System, Application) are primary forensic artifacts; **Event ID 4624** (successful logon) and **4625** (failed logon) are critical for CySA+ analysis
- **UAC (User Account Control)** enforces least privilege by requiring elevation approval, but numerous bypass techniques exist (e.g., fodhelper.exe abuse)

## Related concepts
[[Active Directory]] [[Kerberos Authentication]] [[Pass-the-Hash]] [[Privilege Escalation]] [[SMB Protocol]]