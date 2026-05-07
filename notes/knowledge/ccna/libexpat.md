# libexpat

## What it is
Like a translator hired to read foreign-language contracts aloud — if the translator has a bug, every contract they touch becomes a liability. libexpat is a widely-deployed C library for parsing XML documents, used internally by hundreds of applications including Python, PHP, Firefox, and Apache to interpret XML data.

## Why it matters
In 2022, CVE-2022-25236 and related vulnerabilities in libexpat allowed attackers to craft malicious XML input that triggered heap buffer overflows, enabling remote code execution. Because libexpat is a shared dependency baked into so many runtimes, a single unpatched version of the library exposed entire software ecosystems simultaneously — a textbook example of supply chain risk.

## Key facts
- libexpat is an **open-source, event-driven (SAX-style) XML parser** written in C, originally developed by James Clark
- It has been repeatedly targeted with **XML Entity Expansion (billion laughs) attacks** and **buffer overflow vulnerabilities** due to its C memory management
- CVE-2021-45960 and CVE-2022-25235/25236/25315 were critical flaws (CVSS 9.8) patched in version 2.4.5 — frequently cited in patch management exam scenarios
- Because libexpat is a **transitive dependency**, many software vendors ship it without explicitly listing it — making vulnerability tracking via SBOM (Software Bill of Materials) essential
- Exploitation typically requires an attacker to **supply malformed XML input** to an application that passes it to libexpat — common in web services, document parsers, and protocol handlers

## Related concepts
[[XML External Entity (XXE) Injection]] [[Supply Chain Attack]] [[Buffer Overflow]] [[Software Bill of Materials (SBOM)]] [[Dependency Confusion]]