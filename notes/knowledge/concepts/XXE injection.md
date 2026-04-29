# XXE injection

## What it is
Imagine handing a librarian a book request slip that secretly says "also fetch me the contents of the vault in the back room" — that's XXE. XML External Entity (XXE) injection is an attack where a malicious XML payload defines an external entity reference that tricks the XML parser into reading local files, making network requests, or executing server-side actions the application never intended to allow.

## Why it matters
In 2019, a bug bounty hunter discovered an XXE vulnerability in a major cloud provider's document-upload feature — by uploading a crafted XML file, they read `/etc/passwd` and internal AWS metadata endpoint credentials. This illustrates the classic XXE kill chain: upload XML → parser resolves external entity → attacker receives sensitive data via out-of-band callback or direct response reflection.

## Key facts
- XXE targets **XML parsers**, not the application logic itself — the vulnerability lives in how the parser handles DOCTYPE declarations and `SYSTEM` or `PUBLIC` entity definitions
- **Blind XXE** uses out-of-band (OOB) techniques (DNS callbacks, HTTP requests to attacker-controlled servers) when results aren't reflected in the response
- Primary impacts include **Local File Inclusion (LFI)**, **SSRF**, and in rare cases **Remote Code Execution** via parser-specific features
- Mitigation: **disable external entity processing** in the XML parser configuration (e.g., set `FEATURE_EXTERNAL_GENERAL_ENTITIES` to false in Java's SAXParserFactory)
- XXE is listed in the **OWASP Top 10** (formerly its own entry, now folded under **Security Misconfiguration** in 2021) — expect Security+/CySA+ questions linking XXE to improper parser configuration

## Related concepts
[[XML Injection]] [[Server-Side Request Forgery]] [[Local File Inclusion]] [[Input Validation]]