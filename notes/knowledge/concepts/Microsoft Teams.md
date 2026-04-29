# Microsoft Teams

## What it is
Think of Microsoft Teams as a digital office building where every department has its own floor (channel), people can shout across floors (mentions), and the mailroom delivers files — except the whole building is exposed to the internet. Precisely, Microsoft Teams is a cloud-based collaboration platform integrated into Microsoft 365 that combines persistent chat, video conferencing, file sharing, and third-party app integration under a single identity-authenticated workspace.

## Why it matters
In 2023, a social engineering campaign dubbed **GIFShell** exploited Teams' external access feature to deliver malicious payloads by embedding commands inside GIF metadata, bypassing traditional email security controls entirely. Defenders must treat Teams as an attack surface equivalent to email — disabling anonymous external access, auditing guest accounts, and monitoring for unusual file sharing or OAuth app permissions granted within Teams environments.

## Key facts
- Teams uses **OAuth 2.0 and Azure Active Directory (AAD)** for authentication; compromised M365 credentials grant full Teams access including stored files and chat history
- **External Access vs. Guest Access**: External Access allows federation with other Teams orgs (higher risk); Guest Access grants scoped access to specific teams (more controlled)
- Teams stores data in **SharePoint Online** (files) and **Exchange Online** (chat logs) — both are forensic gold mines during incident response
- Attackers can abuse the **Teams API and webhooks** to exfiltrate data or establish C2 channels that blend into normal HTTPS traffic
- **MFA bypass via session token theft** (pass-the-cookie attacks) is a primary threat vector since Teams is browser and app accessible

## Related concepts
[[OAuth 2.0]] [[Azure Active Directory]] [[Phishing]] [[Social Engineering]] [[Data Loss Prevention]]