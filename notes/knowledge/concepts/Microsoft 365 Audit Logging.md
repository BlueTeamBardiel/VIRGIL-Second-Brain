# Microsoft 365 Audit Logging

## What it is
Think of it as a hotel's key-card access system that records every door opened, every minibar raided, and every time someone tried the wrong room — except for your entire cloud tenant. Microsoft 365 Unified Audit Log (UAL) captures user and admin activities across Exchange Online, SharePoint, Teams, Azure AD, and other M365 services into a single searchable record of "who did what, when, and from where."

## Why it matters
During the 2023 Storm-0558 breach, Microsoft's audit logs were central to the investigation — but organizations without the premium **Microsoft Purview Audit (Premium)** license couldn't access the MailItemsAccessed events needed to determine exactly which emails Chinese threat actors had read. This gap directly led CISA to recommend Microsoft expand default logging, illustrating how licensing tiers can create blind spots during incident response.

## Key facts
- **Audit logging is not enabled by default** for all services; administrators must explicitly enable it in the Microsoft Purview compliance portal
- Log retention defaults to **90 days** for standard (E3) licenses; **Microsoft Purview Audit Premium** (E5) extends retention to **1 year** (expandable to 10 years with add-on)
- Logs are queryable via the **Search-UnifiedAuditLog** PowerShell cmdlet or the compliance portal UI
- Critical events to monitor include **MaliciousFileDeleted**, **FileDownloaded**, **Add member to role**, and **MailItemsAccessed**
- There is a ingestion **delay of up to 30 minutes** before events appear searchable — forensic timelines must account for this lag

## Related concepts
[[Cloud SIEM Integration]] [[Azure Active Directory Sign-In Logs]] [[MITRE ATT&CK Defense Evasion]] [[Incident Response Logging]] [[Data Loss Prevention Policies]]