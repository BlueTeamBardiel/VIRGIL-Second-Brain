# email header injection

## What it is
Imagine a postal worker who follows instructions written *on the envelope itself* — if you scribble "also deliver 1,000 copies to this address" on the envelope, they comply blindly. Email header injection works the same way: when a web application naively embeds user-supplied input into outgoing email headers (like `To:`, `CC:`, or `Subject:`), an attacker can inject newline characters (`\r\n`) to insert entirely new headers, turning the application's mail server into their personal spam cannon.

## Why it matters
A classic attack scenario involves a "Contact Us" form where the user's name gets embedded into the email's `From:` field. An attacker enters `victim@example.com\r\nCC: spam1@evil.com\r\nBCC: spam2@evil.com` as their name, and suddenly the server blasts spam to thousands of addresses — all originating from a legitimate domain, bypassing many spam filters and damaging the organization's email reputation.

## Key facts
- The injection vector is the **CRLF sequence** (`\r\n`, ASCII 0x0D 0x0A), which separates email headers in SMTP; a second CRLF pair ends headers and begins the message body
- Attackers can inject `CC:`, `BCC:`, `Reply-To:`, and even `Content-Type:` headers to manipulate message routing or encoding
- It is categorized as an **injection vulnerability** (CWE-93) and closely related to CRLF injection
- **Mitigation**: sanitize user input by stripping or rejecting any `\r` or `\n` characters before embedding in headers; use libraries that handle header encoding safely
- Often used for **phishing and spam amplification** because the malicious email originates from a trusted server with valid SPF/DKIM records

## Related concepts
[[CRLF injection]] [[SMTP relay abuse]] [[input validation]] [[phishing]] [[SPF and DKIM]]