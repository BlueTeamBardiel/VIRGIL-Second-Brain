# Outlook

## What it is
Think of Outlook like a postal sorting office built directly into your office building — it receives, stores, and routes messages, but also runs macros and renders previews, making it a processing engine, not just a mailbox. Microsoft Outlook is an email client and personal information manager that handles email, calendars, and contacts, deeply integrated with Exchange Server and Microsoft 365 environments.

## Why it matters
In the 2023 NTLM credential leak vulnerability (CVE-2023-23397), attackers sent a specially crafted Outlook meeting invite containing a UNC path to an attacker-controlled SMB server. When Outlook processed the invite automatically — *before the user even opened it* — Windows leaked the victim's Net-NTLMv2 hash, enabling pass-the-hash attacks against corporate networks without any user interaction.

## Key facts
- **CVE-2023-23397** is a critical zero-click Outlook privilege escalation bug (CVSS 9.8) exploiting the `PidLidReminderFileParameter` property in calendar items
- Outlook supports **VBA macros** in `.DOTM`/email-attached Office files, historically a top malware delivery vector used in phishing campaigns
- **Outlook rules and forms** (Home Page, custom forms) can persist malicious code even after malware removal — a common post-exploitation persistence technique
- Outlook stores local mail in **OST** (offline) and **PST** (personal archive) files, which attackers target for offline credential and data harvesting
- The **Preview Pane** has historically triggered vulnerabilities, allowing code execution without fully opening a message

## Related concepts
[[Phishing]] [[NTLM Relay Attack]] [[Macro Malware]] [[Exchange Server]] [[Credential Harvesting]]