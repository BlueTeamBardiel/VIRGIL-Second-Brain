# HTTP Response Splitting

## What it is
Imagine slipping a fake page into a book by inserting an extra chapter divider — the reader thinks they're reading one book, but you've secretly started a second. HTTP Response Splitting works the same way: an attacker injects carriage return (`\r\n`) characters into HTTP response headers, causing the server to interpret a single response as two separate responses, with the attacker controlling the content of the second.

## Why it matters
An attacker targeting a vulnerable login portal could inject crafted `Location:` or `Set-Cookie:` headers containing `\r\n\r\n` sequences followed by a fake HTTP response body. This enables **cache poisoning** — a downstream proxy caches the attacker's forged response and serves it to legitimate users, effectively defacing the site or stealing session cookies without ever touching the server directly.

## Key facts
- **Root cause:** Insufficient validation of user-supplied input that gets reflected into HTTP response headers (e.g., redirect URLs, cookie values)
- **Attack vector:** Injecting `%0d%0a` (URL-encoded CRLF) sequences into header fields to terminate one response and begin another
- **Downstream effects:** Enables cross-site scripting (XSS), cache poisoning, session fixation, and cross-user defacement
- **Primary defense:** Strip or reject CRLF characters from any user input that flows into HTTP headers; use security-aware frameworks that encode header values automatically
- **Distinct from CRLF Injection:** HTTP Response Splitting is the *specific exploitation* of CRLF injection within the HTTP response context — all response splitting is CRLF injection, but not vice versa

## Related concepts
[[CRLF Injection]] [[HTTP Header Injection]] [[Cache Poisoning]] [[Session Fixation]] [[Cross-Site Scripting]]