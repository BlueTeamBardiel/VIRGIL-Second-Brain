# Woodstox

## What it is
Think of Woodstox as a high-performance assembly line reader for XML documents — instead of building the whole factory floor in memory, it reads the conveyor belt one piece at a time. Woodstox is an open-source Java XML processor implementing the StAX (Streaming API for XML) and SAX standards, known for its speed and strict XML parsing validation. It serves as the XML backbone for major frameworks including Jackson and Apache CXF.

## Why it matters
Woodstox has been directly implicated in XML External Entity (XXE) injection vulnerabilities — for example, CVE-2022-40152 allowed attackers to trigger a stack overflow via deeply nested XML structures, enabling Denial of Service against applications using Jackson's XML dataformat (which delegates to Woodstox under the hood). Any Java web service accepting XML input and running an unpatched Woodstox version was exposed to application crashes without authentication.

## Key facts
- **CVE-2022-40152**: Stack overflow DoS via deeply nested XML in Woodstox versions before 6.4.0; CVSS score 7.5 (High)
- Woodstox is a **transitive dependency** — developers often don't know they're running it, making patch management difficult and supply chain risk significant
- XXE attacks against Woodstox can lead to **SSRF, local file disclosure, and DoS** depending on parser configuration
- Disabling DTD processing (`IS_SUPPORTING_EXTERNAL_ENTITIES = false`) is the primary defensive configuration to prevent XXE exploitation
- Woodstox implements **strict well-formedness checking** by default, which can itself be weaponized via malformed XML to crash parsers in older versions

## Related concepts
[[XML External Entity (XXE)]] [[Supply Chain Attack]] [[Denial of Service]] [[SSRF]] [[Dependency Management]]