# WAF evasion

## What it is
A WAF rule is like a bouncer checking IDs against a specific list — change your font or laminate, and the same fake ID might slip through. WAF evasion is the set of techniques attackers use to craft malicious payloads that bypass Web Application Firewall signature matching without losing their harmful functionality. The core exploit: WAFs parse input one way, while the backend application parses it differently.

## Why it matters
In 2021, attackers bypassed Cloudflare's WAF to exploit a SQL injection flaw in a major SaaS platform by URL-double-encoding their payload (`%2527` instead of `'`), which the WAF decoded once (to `%27`) and passed as safe, while the database decoded it again to a live single quote. This class of bypass demonstrates why WAF deployment alone is insufficient defense-in-depth.

## Key facts
- **Encoding tricks**: Double URL encoding, Unicode normalization (`ʼ` instead of `'`), and HTML entity encoding can disguise injection characters from WAF pattern matching
- **Case and comment obfuscation**: SQL keywords like `SeLeCt` or `SE/**/LECT` bypass case-sensitive or naive regex rules while remaining valid to the database engine
- **HTTP parameter pollution (HPP)**: Sending duplicate parameters (`?id=1&id=UNION SELECT`) confuses WAFs that only inspect the first value while the app processes the last
- **Chunked transfer encoding**: Breaking malicious payloads across HTTP chunked-transfer segments can defeat WAFs that don't fully reassemble streams before inspection
- **WAFs add attack surface too**: Misconfigured WAFs can be fingerprinted via error response differences, enabling targeted evasion crafted specifically for that vendor's rule set

## Related concepts
[[SQL Injection]] [[Cross-Site Scripting (XSS)]] [[HTTP Parameter Pollution]] [[Defense in Depth]] [[Input Validation]]