# XML parser

## What it is
Like a customs agent inspecting luggage according to a rulebook, an XML parser reads through structured XML documents and interprets their contents according to defined rules. It is a software component that processes XML data by reading tags, attributes, and values, converting raw markup text into usable data structures an application can act upon. Parsers enforce document syntax and can optionally validate content against a schema or DTD.

## Why it matters
In 2017, a misconfigured XML parser in a major financial application allowed attackers to submit a crafted document referencing the server's `/etc/passwd` file through an XXE (XML External Entity) injection attack, exposing sensitive system credentials. Because parsers by default often resolve external entity references, any application accepting user-supplied XML is a potential target. Disabling external entity processing is the primary defense.

## Key facts
- **XXE (XML External Entity) Injection** is the primary attack against XML parsers — malicious input defines a custom entity pointing to local files, internal network resources, or SSRF targets
- The attack payload looks like: `<!DOCTYPE foo [<!ENTITY xxe SYSTEM "file:///etc/passwd">]>`
- XXE can enable **Local File Inclusion (LFI)**, **Server-Side Request Forgery (SSRF)**, and in rare cases Remote Code Execution
- **Mitigation**: Disable DTD processing and external entity resolution entirely in the parser configuration (e.g., `FEATURE_EXTERNAL_GENERAL_ENTITIES = false` in Java's SAXParser)
- XML parsers appear in SOAP web services, file upload processors (DOCX, SVG, PDF), and API endpoints — attack surface is wider than developers expect
- OWASP lists XXE as a critical risk; it appears in the **OWASP Top 10** (formerly its own category A4:2017)

## Related concepts
[[XML External Entity (XXE)]] [[Server-Side Request Forgery (SSRF)]] [[Input Validation]] [[SOAP Web Services]] [[Local File Inclusion]]