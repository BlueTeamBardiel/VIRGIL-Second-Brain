# Email Collection

## What it is
Like a fisherman dragging a net across the ocean floor to scoop up everything indiscriminately, email collection is the systematic harvesting of email addresses and inbox contents to fuel further attacks. Precisely, it is a reconnaissance and credential-access technique (MITRE ATT&CK T1114) where adversaries gather email addresses from public sources or extract messages directly from compromised mail servers and clients.

## Why it matters
In the 2016 DNC breach, Fancy Bear operators used spearphishing to gain access to John Podesta's Gmail account and then exfiltrated thousands of emails — those collected messages were later weaponized for influence operations. Defenders monitoring for unusual IMAP/POP3 access patterns or unexpected mail-forwarding rules could have detected the exfiltration before it completed.

## Key facts
- **Three collection vectors**: local email client files (e.g., Outlook `.pst`/`.ost`), remote mail server access via IMAP/Exchange APIs, and OSINT harvesting from websites/LinkedIn/data breaches
- **Auto-forwarding abuse**: Attackers frequently create inbox rules to silently forward all incoming mail to an external address — a persistence mechanism that survives password resets
- **MITRE ATT&CK T1114** has three sub-techniques: Local Email Collection (T1114.001), Remote Email Collection (T1114.002), and Email Forwarding Rule (T1114.003)
- **Detection signal**: Unusual OAuth token grants to mail-reading permissions (e.g., `mail.read` scope in Microsoft 365) are a strong indicator of compromise
- **Phishing enablement**: Harvested email threads are used in "thread hijacking" attacks, where adversaries reply to existing conversations to add credibility to malicious links

## Related concepts
[[Spearphishing]] [[Credential Dumping]] [[OAuth Abuse]] [[OSINT]] [[Lateral Movement]]