# URL validation

## What it is
Think of URL validation like a bouncer checking IDs at a club — not just glancing at the card, but verifying the format, the issuer, and whether the person matches the photo. URL validation is the process of inspecting and sanitizing URLs submitted to an application to ensure they conform to expected structure, schemes, and destinations before the application acts on them. It prevents attackers from smuggling malicious addresses through inputs that the application trusts.

## Why it matters
In a Server-Side Request Forgery (SSRF) attack, an attacker submits a crafted URL like `http://169.254.169.254/latest/meta-data/` to a vulnerable web application, causing the server to fetch AWS instance metadata and leak credentials. Proper URL validation — whitelisting allowed schemes (only `https://`), domains, and blocking private IP ranges — directly prevents this class of attack. The 2019 Capital One breach was triggered by an SSRF vulnerability exploiting exactly this metadata endpoint.

## Key facts
- **Allowlist over blocklist**: Blocking `http://` while allowing `https://` is safer than trying to enumerate all malicious patterns — attackers use encoding tricks like `http://①②③.com` to bypass blocklists.
- **Scheme validation**: Applications should explicitly permit only necessary schemes (e.g., `https`); leaving `file://`, `gopher://`, or `dict://` accessible enables local file reads or port scanning.
- **IP address normalization**: Attackers bypass naive filters using decimal (`http://2130706433` = 127.0.0.1), octal, or IPv6 representations; validators must normalize before checking.
- **Open redirect risk**: Insufficient URL validation enables open redirects, where `?next=https://evil.com` hijacks post-login flows for phishing — tested on Security+/CySA+ as an injection-adjacent weakness.
- **RFC 3986 compliance**: A correct parser follows RFC 3986 to split URLs into scheme, authority, path, query, and fragment — ad hoc string matching routinely fails edge cases.

## Related concepts
[[Server-Side Request Forgery (SSRF)]] [[Open Redirect]] [[Input Validation]] [[Injection Attacks]]