# impacket

## What it is
Think of it as a master skeleton key ring — each key crafted to speak the exact dialect of a different Windows network protocol. Impacket is an open-source Python library that provides low-level programmatic access to network protocols like SMB, Kerberos, LDAP, and MSRPC, allowing attackers (and defenders) to craft, send, and parse raw protocol packets without needing a full Windows environment.

## Why it matters
During a penetration test — or a real intrusion — an attacker on a Linux box can use Impacket's `secretsdump.py` to remotely dump NTLM password hashes and Kerberos tickets from a Windows domain controller over SMB without ever installing anything on the target. This exact technique is used in pass-the-hash and DCSync attacks and appears in incident reports from major ransomware groups like Conti and BlackCat.

## Key facts
- **secretsdump.py** performs remote SAM and NTDS.dit extraction by abusing the DRSUAPI replication protocol (DCSync) — no local access required
- **psexec.py** and **wmiexec.py** enable remote command execution over SMB and WMI, commonly flagged in EDR telemetry as lateral movement indicators
- **GetTGT.py / GetST.py** automate Kerberos ticket requests, enabling attacks like Kerberoasting and AS-REP Roasting from Linux
- Impacket traffic can be detected by monitoring for abnormal DRSUAPI replication requests originating from non-DC systems (key SIEM detection rule)
- Heavily leveraged in APT campaigns; its artifacts (Python process spawning SMB sessions, specific pipe names like `\PIPE\svcctl`) are known threat-hunting signatures

## Related concepts
[[Pass-the-Hash]] [[Kerberoasting]] [[DCSync]] [[SMB]] [[Lateral Movement]]