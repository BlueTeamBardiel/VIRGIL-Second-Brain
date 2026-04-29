# XML External Entity

## What it is
Imagine a document template that says "insert the contents of filing cabinet drawer 3 here" — and the filing cabinet happens to contain your server's `/etc/passwd` file. XML External Entity (XXE) is a vulnerability where an XML parser processes attacker-controlled entity declarations that reference external resources, causing the server to fetch and return sensitive files or make unintended network requests.

## Why it matters
In 2019, attackers exploited XXE in a widely-used SAML library to bypass authentication entirely — SAML uses XML, and the XXE payload caused the server to read a local file whose contents satisfied the signature check. Defenders patch this by disabling external entity processing in XML parsers, which is almost never needed in legitimate applications.

## Key facts
- **Attack vector**: Attacker submits crafted XML with `<!DOCTYPE foo [<!ENTITY xxe SYSTEM "file:///etc/passwd">]>` and references `&xxe;` in the document body
- **OWASP Top 10**: XXE was its own category (A4) in the 2017 list; merged into "Security Misconfiguration" in 2021, reflecting how common misconfigured parsers remain
- **Impact types**: Local file disclosure, Server-Side Request Forgery (SSRF), denial of service via "Billion Laughs" recursive entity expansion, and occasionally remote code execution
- **Root cause**: XML parsers that have external entity processing *enabled by default* — Java's older SAX/DOM parsers are historically notorious for this
- **Fix**: Set parser features to disable DTDs and external entities (e.g., `FEATURE_DISALLOW_DOCTYPE_DECL = true` in Java); input validation alone is insufficient

## Related concepts
[[Server-Side Request Forgery]] [[XML Injection]] [[SAML Vulnerabilities]]