# Email Hiding Rules

## What it is
Like a corrupt mail carrier who secretly diverts certain envelopes to a dumpster before you ever see them, email hiding rules are inbox configurations that automatically redirect, delete, or forward messages without the account owner's knowledge. Precisely, they are malicious mailbox rules created by an attacker after gaining access to an email account, designed to suppress security alerts, forwarding credentials, or concealing ongoing compromise from the victim.

## Why it matters
In Business Email Compromise (BEC) attacks, threat actors authenticate to a victim's Office 365 or Gmail account, then immediately create a rule that forwards all emails to an external attacker-controlled address *and* deletes the forwarded copies from the inbox. The victim continues using their account normally, unaware that weeks of sensitive financial communications, invoice details, and MFA reset emails are silently being exfiltrated — a technique observed extensively in FBI IC3-reported BEC losses exceeding $2.9 billion annually.

## Key facts
- Attackers commonly target the "Inbox Rules" or "Transport Rules" functionality in Microsoft Exchange/Office 365 and Google Workspace after credential theft
- Rules can be configured to forward externally, mark messages as read, move to obscure folders, or permanently delete — making detection difficult without audit log review
- Microsoft Secure Score and Defender for Office 365 flag suspicious forwarding rules as a key detection signal; CISA has issued specific advisories on this technique
- Mapped to MITRE ATT&CK technique **T1564.008** (Hide Artifacts: Email Hiding Rules)
- Detection involves auditing `New-InboxRule` and `Set-InboxRule` PowerShell commands in Exchange audit logs or reviewing unified audit logs in Microsoft Purview

## Related concepts
[[Business Email Compromise]] [[Credential Stuffing]] [[MITRE ATT&CK]] [[Email Forwarding Exfiltration]] [[Audit Log Analysis]]