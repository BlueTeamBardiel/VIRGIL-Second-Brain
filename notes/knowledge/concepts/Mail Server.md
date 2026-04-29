# Mail Server

## What it is
Think of a mail server like a post office with two departments: one that accepts and sorts incoming letters (the receiving desk), and one that routes outgoing mail to other post offices (the delivery truck). Precisely, a mail server is a system that sends, receives, and stores email using protocols like SMTP (outgoing), IMAP, and POP3 (incoming retrieval). It acts as both the origination point and destination for email communication across networks.

## Why it matters
In 2021, the ProxyLogon vulnerability in Microsoft Exchange Server allowed unauthenticated attackers to achieve remote code execution by chaining CVEs against the mail server — giving adversaries full network access through a single exposed port (443). Mail servers are high-value targets because they aggregate sensitive communications, credentials, and often have elevated privileges within Active Directory environments. Defenders must keep them patched, monitor for suspicious SMTP relay activity, and implement SPF, DKIM, and DMARC to prevent spoofing.

## Key facts
- **SMTP** operates on port 25 (server-to-server) and port 587 (client submission with authentication); port 465 is deprecated but still seen
- **Open relay** misconfiguration allows anyone to send email through your server, enabling spam and phishing campaigns — a common pentest finding
- **SPF, DKIM, and DMARC** are email authentication standards that collectively prevent domain spoofing; DMARC ties the other two together with a policy enforcement layer
- **POP3** (port 110) downloads and deletes mail from the server; **IMAP** (port 143) syncs mail while leaving it server-side — IMAP is more forensically significant
- Mail servers are frequent pivot points in attacks; compromised accounts can be used for **internal phishing** that bypasses perimeter email filters

## Related concepts
[[SMTP]] [[Phishing]] [[SPF DKIM DMARC]] [[Open Relay]] [[Email Spoofing]]