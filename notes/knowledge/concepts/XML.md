# XML

## What it is
Think of XML like a labeled filing cabinet where every drawer (tag) has a matching label on both sides — you open `<name>` and must close `</name>`. XML (eXtensible Markup Language) is a text-based data serialization format that uses nested, self-describing tags to structure and transport data between systems. Unlike HTML, XML defines no fixed tags — developers invent their own to fit their data.

## Why it matters
XML External Entity (XXE) injection is a critical attack where a malicious XML document references an external entity — for example, `<!ENTITY xxe SYSTEM "file:///etc/passwd">` — tricking the server's XML parser into reading sensitive local files and returning them in the response. This attack has compromised major platforms and ranks in the OWASP Top 10. Defense involves disabling external entity processing in XML parsers entirely, since the feature is rarely needed in production.

## Key facts
- **XXE (XML External Entity)** attacks exploit how XML parsers resolve `ENTITY` declarations, enabling file disclosure, SSRF, or denial of service
- XML is used heavily in **SOAP web services**, Office documents (.docx, .xlsx are zipped XML), and configuration files — making parser vulnerabilities widespread
- **Billion Laughs attack** (XML bomb) is a DoS technique using nested entity expansion to exhaust server memory with a tiny input file
- Disabling DTD (Document Type Definition) processing is the primary mitigation for XXE, since entities are declared within DTDs
- XML differs from JSON in verbosity and strict tag-matching rules; JSON has largely replaced XML in REST APIs, but XML persists in legacy enterprise systems

## Related concepts
[[XXE Injection]] [[SOAP Web Services]] [[Input Validation]] [[SSRF]] [[Denial of Service]]