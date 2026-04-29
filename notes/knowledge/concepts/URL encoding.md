# URL encoding

## What it is
Like a postal service that only accepts letters and numbers, web servers need a standardized way to ship special characters — so spaces become `%20` and ampersands become `%26`. URL encoding (percent-encoding) converts characters outside the safe ASCII set into a `%` followed by their two-digit hexadecimal value, making them safe to transmit in a URL.

## Why it matters
Attackers exploit inconsistent URL decoding to bypass security filters — a technique called double encoding. If a WAF blocks `../` (path traversal), an attacker might submit `%252e%252e%252f`, where `%25` is the encoding for `%` itself; a server that decodes twice will reconstruct the original `../` after the WAF has already passed the request through.

## Key facts
- The space character has two valid encodings: `%20` (standard) and `+` (in form data / `application/x-www-form-urlencoded`)
- **Double encoding** encodes the `%` sign itself (`%` → `%25`), so `%2F` becomes `%252F` — a common WAF/IDS evasion technique
- Characters that *must* be encoded in URLs include: space, `<`, `>`, `"`, `#`, `%`, `{`, `}`, `|`, `\`, `^`, `~`
- **Path traversal attacks** frequently rely on URL-encoded variants like `%2e%2e%2f` (../), `%2e%2e/`, or mixed encodings to evade input validation
- RFC 3986 defines the standard; unreserved characters (A–Z, 0–9, `-`, `_`, `.`, `~`) never need encoding

## Related concepts
[[Path Traversal]] [[Input Validation]] [[Cross-Site Scripting (XSS)]] [[Web Application Firewall (WAF)]]