# Office 365

## What it is
Think of it as a city that moved its entire infrastructure — power grid, post office, file archives, and conference rooms — to rented space in the cloud instead of owning the building. Microsoft Office 365 (now Microsoft 365) is a cloud-based subscription suite delivering productivity tools (Exchange Online, SharePoint, Teams, OneDrive) hosted on Microsoft's infrastructure rather than on-premises servers. Organizations authenticate users through Azure Active Directory and access services via browser, client apps, or APIs.

## Why it matters
In 2020, the SolarWinds attack chain demonstrated how threat actors used forged SAML tokens to authenticate directly into Office 365 environments, bypassing MFA entirely and exfiltrating emails without touching on-premises systems. Defenders must monitor Azure AD sign-in logs, enable Unified Audit Log, and configure Conditional Access Policies — because traditional perimeter defenses don't protect cloud-hosted mail and files.

## Key facts
- **Unified Audit Log (UAL)** must be explicitly enabled; it is *not* on by default in all tenants and is critical for forensic investigation of account compromise
- **OAuth app consent attacks** abuse delegated permissions to access O365 data without stealing credentials — attacker tricks user into granting a malicious app `Mail.Read` permission
- **Microsoft Secure Score** measures a tenant's security posture and maps directly to CIS/NIST controls — commonly referenced in CySA+ scenarios
- **Legacy authentication protocols** (IMAP, POP3, SMTP AUTH) bypass MFA and are a top attack vector; blocking them via Conditional Access is a foundational hardening step
- **Exchange Online Protection (EOP)** provides built-in anti-spam/anti-malware; Defender for Office 365 adds sandboxing (Safe Attachments) and URL detonation (Safe Links)

## Related concepts
[[Azure Active Directory]] [[SAML]] [[OAuth]] [[Multi-Factor Authentication]] [[Conditional Access]]