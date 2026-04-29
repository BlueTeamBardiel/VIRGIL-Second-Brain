# percent-encoding

## What it is
Like a postal worker who can't deliver a package labeled "FRAGILE/HANDLE WITH CARE" because the slash breaks their sorting system — so they rewrite it as "FRAGILE%2FHANDLE WITH CARE" — percent-encoding substitutes reserved or unsafe characters in URLs with a `%` sign followed by the character's two-digit hex ASCII value. It ensures that special characters (like `/`, `?`, `=`, `#`) can travel safely through HTTP without being misinterpreted as URL syntax.

## Why it matters
Attackers use percent-encoding to bypass input validation filters and WAFs. A firewall blocking the string `../` for path traversal might not catch `%2e%2e%2f`, which decodes to the same thing before the web server processes it — granting access to files outside the web root. Double-encoding (`%252f`, where `%25` decodes to `%`, yielding `%2f` on a second pass) further evades naive defenses that only decode once.

## Key facts
- `%20` = space, `%2F` = `/`, `%3D` = `=`, `%3C` = `<`, `%3E` = `>` — memorize these for exam scenarios
- Percent-encoding is defined in **RFC 3986** as part of the URI specification
- **Double-encoding** (`%252F`) exploits servers that decode input in multiple stages, a classic WAF bypass technique
- Canonicalization errors — when a system compares an encoded string to a decoded one without normalizing first — are the root cause of most encoding-based bypasses
- Input validation must **decode first, then validate** (not validate then decode) to prevent bypass via encoded payloads

## Related concepts
[[path traversal]] [[input validation]] [[cross-site scripting]] [[canonicalization attacks]]