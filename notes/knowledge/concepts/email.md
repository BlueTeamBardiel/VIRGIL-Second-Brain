# email

## What it is
Like a postcard sent through a series of post offices — anyone handling it can read it unless you seal it in an envelope (encryption). Email is an asynchronous messaging protocol built on SMTP (sending), IMAP/POP3 (receiving), where messages traverse multiple servers before reaching their destination with no built-in authentication or confidentiality by default.

## Why it matters
In the 2016 Democratic National Committee breach, spear-phishing emails impersonating Google security alerts tricked staff into surrendering credentials — a textbook case of how email's lack of native sender verification makes it the #1 delivery vector for attacks. Defenses like SPF, DKIM, and DMARC exist specifically to close this authentication gap by letting receiving servers verify a sender's legitimacy.

## Key facts
- **SMTP** operates on port 25 (server-to-server) and 587 (client submission with STARTTLS); port 465 uses implicit TLS
- **SPF** (Sender Policy Framework) publishes authorized sending IPs in DNS; **DKIM** cryptographically signs message headers; **DMARC** enforces policy when both fail
- **S/MIME** and **PGP** provide end-to-end encryption and digital signatures for email content — something SPF/DKIM/DMARC do *not* provide
- Email headers reveal full relay path (Received: fields) and are critical forensic artifacts when investigating phishing or spoofing incidents
- **Business Email Compromise (BEC)** costs organizations billions annually — often requires zero malware, relying purely on spoofed or look-alike domains to impersonate executives

## Related concepts
[[phishing]] [[DMARC]] [[S/MIME]] [[social engineering]] [[spoofing]]