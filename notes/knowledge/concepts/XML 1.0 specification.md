# XML 1.0 specification

## What it is
Like a strict grammar rulebook for a language everyone agreed to speak in 1998, XML 1.0 is the W3C standard that defines how data must be structured using nested tags, attributes, and entities. It specifies legal character sets, document well-formedness rules, and a processing model that parsers must follow — including how to resolve special constructs like external entities and DTDs.

## Why it matters
The XML 1.0 entity resolution mechanism is the root cause of XXE (XML External Entity) injection attacks. When a vulnerable parser faithfully follows the spec and resolves an attacker-supplied external entity like `<!ENTITY xxe SYSTEM "file:///etc/passwd">`, it reads local files or makes server-side requests — turning strict spec compliance into a critical vulnerability exploited against major platforms including PayPal and Facebook.

## Key facts
- XML 1.0 defines **five predefined entities**: `&amp;`, `&lt;`, `&gt;`, `&apos;`, `&quot;` — parsers must support these by default
- **External entity declarations** (SYSTEM/PUBLIC keywords) instruct parsers to fetch resources from URIs, including `file://`, `http://`, and `ftp://` schemes — the core of XXE exploitation
- A document is **well-formed** (syntactically valid) vs. **valid** (matches a DTD/schema) — attackers exploit well-formed but malicious documents
- **DOCTYPE declarations** enable DTD processing; disabling DTD processing entirely is the primary XXE mitigation recommended by OWASP
- XML 1.0 does not support certain Unicode control characters — differences in how parsers handle edge-case characters can cause **parser differential attacks** used to bypass WAFs

## Related concepts
[[XXE Injection]] [[Document Type Definition (DTD)]] [[SSRF (Server-Side Request Forgery)]] [[Input Validation]] [[XML Bomb (Billion Laughs Attack)]]