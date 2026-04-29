# HTTP Basic Auth

## What it is
Imagine sliding your ID card and PIN under a glass window every single time you want to enter a building — and that card is written in crayon that anyone can read if they intercept it. HTTP Basic Authentication works exactly like that: the client encodes the username and password in Base64 and sends them in the `Authorization` header with every HTTP request, providing zero encryption on its own.

## Why it matters
In 2020, misconfigured internal dashboards (Kibana, Jenkins, router admin panels) exposed over a million systems using Basic Auth over plain HTTP — attackers on the same network simply ran Wireshark, captured the `Authorization` header, and Base64-decoded the credentials in seconds. This is why Basic Auth is only considered acceptable when layered over TLS (HTTPS), making transport encryption the single control standing between exposure and compromise.

## Key facts
- Credentials are **Base64-encoded, not encrypted** — Base64 is trivially reversible with any decoder; it provides encoding, not confidentiality
- The header format is: `Authorization: Basic dXNlcjpwYXNz` where `dXNlcjpwYXNz` decodes to `user:pass`
- Basic Auth has **no built-in session management** — credentials must be sent with every request, increasing the attack surface
- Vulnerable to **credential interception** (MitM), **brute-force attacks**, and **replay attacks** without additional controls
- RFC 7617 defines Basic Auth; RFC 7235 defines the broader HTTP authentication framework — expect HTTPS (`HSTS`) to be cited as the required countermeasure on exams

## Related concepts
[[TLS/HTTPS]] [[Base64 Encoding]] [[Digest Authentication]] [[Man-in-the-Middle Attack]] [[Credential Interception]]