# Email Security

## What it is
Email is like sending a postcard through a series of post offices — anyone handling it along the route can read it, forge the return address, or swap the contents. Email security is the collection of protocols, policies, and controls that authenticate senders, encrypt content, and filter malicious messages traversing SMTP-based mail infrastructure.

## Why it matters
In a Business Email Compromise (BEC) attack, an adversary spoofs the CFO's email address and instructs the finance team to wire $2.3 million to a fraudulent account. A properly configured DMARC policy set to `p=reject` would have caused the receiving mail server to silently drop that spoofed message before it ever reached the inbox, because the spoofed domain failed both SPF and DKIM alignment checks.

## Key facts
- **SPF (Sender Policy Framework)** is a DNS TXT record listing IP addresses authorized to send mail for a domain; it validates the *envelope sender*, not the visible "From" header.
- **DKIM (DomainKeys Identified Mail)** attaches a cryptographic signature to the message headers, allowing the receiving server to verify the message wasn't tampered with in transit.
- **DMARC** ties SPF and DKIM together and tells receivers what to do on failure: `none` (monitor), `quarantine` (spam folder), or `reject` (block entirely).
- **S/MIME and PGP** provide end-to-end encryption and digital signing of *message content*, unlike SPF/DKIM which operate at the infrastructure layer.
- Email is transmitted in cleartext over port 25 by default; **STARTTLS** upgrades the connection opportunistically, while **port 587** (submission) with mandatory TLS is preferred for authenticated client sends.

## Related concepts
[[Phishing]] [[DNS Security]] [[Public Key Infrastructure]] [[Man-in-the-Middle Attack]] [[DMARC]]