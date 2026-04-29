# SMTP

## What it is
Think of SMTP as the postal worker who only *delivers* mail — they drop letters off at the post office but never hand them directly to you at home. Simple Mail Transfer Protocol (SMTP) is the application-layer protocol (TCP port 25) used to send and relay email between mail servers. It handles outbound transmission only; retrieval uses separate protocols like IMAP or POP3.

## Why it matters
SMTP's original design had zero authentication — any server could claim to be anyone, which is exactly how phishing campaigns spoof "ceo@yourcompany.com" to trick employees into wiring money. Defenders counter this with a layered stack of DNS-based controls: SPF records define authorized sending IPs, DKIM cryptographically signs message headers, and DMARC enforces policy when those checks fail. If any of these are misconfigured, attackers walk right through.

## Key facts
- **Default ports:** 25 (server-to-server relay), 587 (authenticated client submission), 465 (SMTPS — SSL-wrapped, legacy)
- **Open relay** is a misconfigured SMTP server that forwards mail for any sender to any recipient — a classic spam and spoofing amplifier
- **STARTTLS** upgrades a plaintext SMTP connection to TLS in-transit; without it, email content is exposed to on-path attackers
- **SMTP commands to know:** `EHLO` (extended greeting), `MAIL FROM`, `RCPT TO`, `DATA`, `QUIT` — understanding these helps recognize header injection attacks
- **Email header injection** occurs when unvalidated user input inserts extra SMTP headers (like `BCC:`), allowing attackers to hijack contact forms for spam delivery

## Related concepts
[[Email Spoofing]] [[SPF DKIM DMARC]] [[Phishing]] [[Open Relay]] [[STARTTLS]]