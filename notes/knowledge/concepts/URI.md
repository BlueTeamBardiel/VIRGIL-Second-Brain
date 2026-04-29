# URI

## What it is
Like a postal address that tells you both *where* someone lives and *how to reach them* (by road, by courier, by carrier pigeon), a URI (Uniform Resource Identifier) is a standardized string that identifies a resource and optionally specifies how to access it. It's the superset that encompasses both URLs (which locate resources) and URNs (which name them persistently). Every URL is a URI, but not every URI is a URL.

## Why it matters
URI manipulation is a core attack vector in web exploitation — attackers craft malicious URIs using techniques like path traversal (`../../etc/passwd`), scheme injection (`javascript:alert(1)`), or parameter tampering to bypass access controls or trigger unintended server behavior. Proper URI validation and encoding are foundational defenses in secure web application development. Unvalidated redirects using attacker-controlled URI parameters also enable phishing by bouncing victims through trusted domains.

## Key facts
- A URI has five components: **scheme**, **authority**, **path**, **query**, and **fragment** (e.g., `https://example.com/page?id=1#section`)
- **Percent-encoding** (URL encoding) converts unsafe characters to `%HH` hex format — attackers use double-encoding (`%252F` → `%2F` → `/`) to bypass naive input filters
- The `javascript:` scheme in a URI can execute code in browsers — a key vector for DOM-based XSS
- **SSRF (Server-Side Request Forgery)** exploits URI handling to make servers fetch internal resources using schemes like `file://`, `gopher://`, or `dict://`
- URI normalization inconsistencies between components (WAF vs. application server) are exploited in **HTTP desync** and **WAF bypass** attacks

## Related concepts
[[URL Encoding]] [[SSRF]] [[Open Redirect]] [[Cross-Site Scripting (XSS)]] [[Path Traversal]]