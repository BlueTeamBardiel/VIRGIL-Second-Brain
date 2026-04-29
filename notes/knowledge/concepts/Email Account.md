# Email Account

## What it is
Like a physical mailbox with a combination lock, an email account is a personal communication endpoint that only the rightful owner (with correct credentials) should access. Precisely, it is a user-owned messaging service identity hosted on a mail server, identified by a unique address (user@domain.com), authenticated via credentials, and governed by protocols like IMAP, POP3, and SMTP.

## Why it matters
In a Business Email Compromise (BEC) attack, an adversary gains access to a CFO's email account through credential stuffing and silently monitors threads for weeks before injecting a fraudulent wire transfer request — costing organizations an average of $130,000 per incident according to the FBI. Defenders counter this by enforcing Multi-Factor Authentication (MFA) and monitoring for impossible travel login anomalies via SIEM tools.

## Key facts
- **Credential stuffing** exploits password reuse across breached databases — email accounts are primary targets because they serve as master recovery keys for other services.
- **SMTP (port 25/587)** handles outbound mail; **IMAP (port 143/993)** and **POP3 (port 110/995)** handle inbound retrieval — the TLS variants use the higher port numbers.
- Email account takeover enables **account chaining**: reset passwords for banking, cloud, and VPN services through the compromised inbox.
- **SPF, DKIM, and DMARC** are DNS-based controls that verify sending legitimacy — absence of these records is a red flag for phishing infrastructure.
- Mailbox access logs (OAuth token grants, login IPs, forwarding rules) are critical forensic artifacts during incident response — attackers commonly set silent forwarding rules to exfiltrate data invisibly.

## Related concepts
[[Phishing]] [[Multi-Factor Authentication]] [[Business Email Compromise]] [[SMTP]] [[Credential Stuffing]] [[DMARC]]