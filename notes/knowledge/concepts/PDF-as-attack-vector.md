# PDF-as-attack-vector

## What it is
Like a Trojan horse disguised as a gift basket, a PDF file appears as a harmless document while concealing executable logic, malicious scripts, or exploit payloads within its structure. PDFs are attack vectors because the format supports JavaScript execution, embedded objects, and URI actions — features legitimate enough to ship in the spec, dangerous enough to weaponize.

## Why it matters
In 2009–2010, Operation Aurora exploited Adobe Reader vulnerabilities to compromise Google, Adobe, and dozens of other organizations — attackers emailed PDFs containing heap-spray JavaScript that executed shellcode upon opening. Defenders today use sandboxed PDF readers and static analysis tools (like PeePDF or PDF-parser) to inspect object streams before execution ever occurs.

## Key facts
- PDFs can contain **JavaScript via /JS and /OpenAction dictionary keys**, which execute automatically when the document opens — no click required
- **CVE-2010-0188** (Adobe Reader) and similar flaws allow malformed PDFs to trigger buffer overflows via crafted TIFF or image data embedded in the file
- Attackers use **PDF obfuscation techniques** — hex encoding, object stream compression, and name obfuscation — to evade signature-based AV detection
- The **EICAR test file** can be embedded in a PDF as a payload carrier, making it a common sandbox-evasion test case
- For Security+/CySA+: PDF attacks fall under **client-side exploitation** and are a primary delivery mechanism in **spear-phishing** campaigns, often paired with pretexting (fake invoices, legal notices)

## Related concepts
[[Client-side exploitation]] [[Spear phishing]] [[Malicious macros]] [[Drive-by download]] [[Sandbox evasion]]