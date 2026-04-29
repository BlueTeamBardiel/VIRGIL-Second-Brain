# percent-encoded

## What it is
Like substituting a secret code word for a forbidden phrase to slip past a bouncer, percent-encoding replaces characters with a `%` sign followed by their two-digit hexadecimal ASCII value. It is the URL encoding standard (RFC 3986) that allows special characters—spaces, slashes, ampersands—to be safely transmitted in HTTP requests without breaking URL syntax. For example, a space becomes `%20` and a forward slash becomes `%2F`.

## Why it matters
Attackers exploit percent-encoding to bypass input validation and web application firewalls (WAFs) by disguising malicious payloads. A classic path traversal attack might encode `../` as `%2E%2E%2F`, causing a WAF to see harmless bytes while the back-end server decodes and executes the directory traversal, exposing files outside the web root. Defenders must ensure validation occurs *after* decoding, not before.

## Key facts
- Characters are encoded as `%XX` where `XX` is the uppercase hexadecimal value of the ASCII byte (e.g., `A` = `%41`)
- Double encoding (`%252F` decodes first to `%2F`, then to `/`) is a common WAF-bypass technique because some systems decode only once
- Reserved characters that *must* be percent-encoded in query strings include `& # = + space / ? : @ ! $ , ; [ ]`
- URL decoding is performed by web servers, browsers, and application frameworks — inconsistencies between layers create security gaps
- Both SQL injection and XSS payloads are routinely percent-encoded to evade signature-based detection; Security+ exams frequently test this evasion technique

## Related concepts
[[path traversal]] [[input validation]] [[cross-site scripting]] [[SQL injection]] [[web application firewall]]