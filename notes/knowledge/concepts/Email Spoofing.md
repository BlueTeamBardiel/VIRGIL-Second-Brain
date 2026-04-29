# Email Spoofing

## What it is
Imagine mailing a letter with someone else's return address written on the envelope — the postal service delivers it without verifying you actually live there. Email spoofing works the same way: attackers forge the `From:` header field in an email to make it appear sent from a trusted source, exploiting the fact that SMTP was designed in 1982 with zero built-in authentication.

## Why it matters
In the 2016 Democratic National Committee breach, attackers sent spear-phishing emails spoofed to look like Google security alerts, successfully stealing credentials from campaign chairman John Podesta. This attack succeeded precisely because the recipient trusted the apparent sender identity without any technical verification layer in place.

## Key facts
- **SPF (Sender Policy Framework)** publishes a DNS record listing IP addresses authorized to send mail for a domain — receivers can reject mail from unlisted IPs
- **DKIM (DomainKeys Identified Mail)** cryptographically signs outgoing email headers; the receiving server validates the signature against a public key in DNS
- **DMARC** sits on top of SPF and DKIM, telling receivers what to do (quarantine, reject, or do nothing) when checks fail — and sends forensic reports back to the domain owner
- Spoofing the `Display Name` (e.g., "IT Support") while using a different actual address bypasses SPF/DKIM and still fools users who don't inspect raw headers
- Email clients showing only the friendly display name — not the actual `From:` address — is a primary reason spoofing remains effective despite technical controls

## Related concepts
[[Phishing]] [[SPF Records]] [[DKIM]] [[DMARC]] [[Social Engineering]]