# interpretation discrepancy

## What it is
Like two judges reading the same law and issuing opposite verdicts, an interpretation discrepancy occurs when two systems process identical input and arrive at different conclusions about its meaning. Precisely, it is a class of vulnerability where a security control (like a WAF or parser) interprets data one way, while the backend application interprets it another — and the attacker exploits the gap between those two readings.

## Why it matters
HTTP request smuggling is a textbook exploitation of interpretation discrepancy: a front-end proxy reads `Content-Length` to determine where a request ends, while the back-end server reads `Transfer-Encoding: chunked`, allowing an attacker to "smuggle" a malicious second request through the proxy invisibly. This can be used to bypass access controls, poison shared caches, or hijack other users' sessions — all without triggering WAF alerts because the WAF saw nothing malicious.

## Key facts
- **Parser differentials** between nginx and Apache on the same stack have been used to bypass authentication by crafting URLs that each server normalizes differently
- **Double URL encoding** exploits discrepancies where a WAF decodes once but the app server decodes twice, making `%2527` appear as a literal string to the WAF but as `'` to the app
- **MIME-type sniffing** is an interpretation discrepancy: a server labels a file `text/plain`, but the browser interprets the content as executable HTML/JS
- **SQL comment syntax** differs between MySQL (`#`) and ANSI SQL (`--`), creating discrepancies that allow filter bypasses on one database but not another
- Interpretation discrepancies underpin most **smuggling, injection bypass, and desync** attack families — understanding them is critical for both offensive and defensive analysis

## Related concepts
[[HTTP Request Smuggling]] [[WAF Bypass]] [[Parser Differential]] [[URL Encoding]] [[Content Sniffing]]