# Exchange

## What it is
Like a postal sorting facility that routes every letter through a central hub, Microsoft Exchange is a mail server platform that handles sending, receiving, storing, and organizing email for an organization. It operates as the backbone of enterprise email infrastructure, supporting protocols like SMTP, IMAP, POP3, and its native MAPI/RPC for Outlook clients.

## Why it matters
In March 2021, the **ProxyLogon** vulnerability chain (CVE-2021-26855) allowed unauthenticated attackers to perform server-side request forgery against on-premises Exchange servers, bypass authentication, and write web shells directly to disk — compromising over 250,000 organizations in days. This incident became a defining case study in patch urgency and the danger of internet-exposed management interfaces.

## Key facts
- **ProxyLogon/ProxyShell** vulnerabilities demonstrated that Exchange is a high-value target because it stores sensitive communications and runs with elevated privileges on the network
- Exchange operates on ports **25 (SMTP)**, **443 (HTTPS/OWA)**, **993 (IMAP over SSL)**, and **995 (POP3 over SSL)**
- **Outlook Web Access (OWA)** exposes Exchange to the internet by design, making it a common initial access vector for threat actors
- Exchange stores mailbox data in **.edb (Extensible Storage Engine)** database files — a goldmine for data exfiltration if an attacker gains file system access
- Microsoft recommends **Exchange Online (Microsoft 365)** over on-premises deployments partly to shift patching responsibility and reduce attack surface exposure

## Related concepts
[[SMTP]] [[Web Shell]] [[Privilege Escalation]] [[CVE]] [[Active Directory]]