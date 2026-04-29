# XML 1.0

## What it is
Like a set of nested Russian dolls where every doll must be perfectly closed before the next one opens, XML 1.0 is a strict hierarchical markup language where every opening tag requires a matching closing tag. Formally, it is a W3C-standardized text format for encoding structured data using customizable tags, attributes, and a tree-based document object model. It became the backbone of web services, configuration files, and data interchange protocols throughout the 2000s.

## Why it matters
XML parsers are notoriously exploitable through **XXE (XML External Entity) injection**, where an attacker embeds a malicious `DOCTYPE` declaration referencing an external entity like `file:///etc/passwd`. When the server-side parser faithfully processes the document, it reads and returns sensitive local files — effectively turning a document parser into an unintentional file-reading service. This vulnerability has compromised major platforms including PayPal and Facebook's internal systems.

## Key facts
- XML 1.0 supports **external entity declarations** (`<!ENTITY xxe SYSTEM "file:///etc/passwd">`), which are the root cause of XXE vulnerabilities
- **Well-formed** vs. **valid**: a well-formed document follows syntax rules; a valid document also conforms to a DTD or schema — parsers may accept malformed inputs differently
- Disabling DTD processing entirely is the **primary mitigation** for XXE attacks in most parser libraries (e.g., setting `FEATURE_EXTERNAL_GENERAL_ENTITIES` to false in Java)
- XML is used in **SAML assertions**, meaning XXE flaws in identity providers can lead to authentication bypass or credential theft
- **Billion Laughs Attack** (XML bomb) is a DoS technique using nested entity expansion that exponentially inflates memory consumption from a tiny XML document

## Related concepts
[[XXE Injection]] [[SAML]] [[DTD (Document Type Definition)]] [[XML Bomb]] [[Input Validation]]