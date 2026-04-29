# PDF

## What it is
Think of PDF like a sealed glass display case for a document — it preserves the exact layout regardless of who opens it, but the glass itself can hide razor blades. Portable Document Format (PDF) is a file format developed by Adobe that encapsulates text, fonts, graphics, and embedded content into a single self-contained file. Critically, it supports active features like JavaScript execution, hyperlinks, and embedded files that transform it from passive display into an attack surface.

## Why it matters
PDF files are one of the most common malware delivery vectors in phishing campaigns because they are universally trusted by end users and mail filters. Attackers embed malicious JavaScript or exploit vulnerabilities in PDF readers (historically Adobe Reader buffer overflows like CVE-2010-0188) to achieve remote code execution when the victim simply opens the file. Defenders use sandboxing and PDF content inspection tools to detonate suspicious files before they reach endpoints.

## Key facts
- PDFs can execute **JavaScript** natively, enabling drive-by attacks without any macro warnings like those shown in Office documents
- **Embedded files and streams** inside PDFs can conceal executables, shellcode, or secondary payloads obscured via encoding (e.g., FlateDecode, ASCIIHexDecode)
- The ***/Launch*** action in PDF spec can execute system commands — a legitimate feature weaponized by attackers
- PDF phishing attacks frequently use **URI actions** to redirect victims to credential-harvesting pages disguised as document previews
- Security tools use **YARA rules** and static analysis tools like `peepdf` or `pdf-parser` to extract and analyze suspicious PDF objects

## Related concepts
[[Phishing]] [[Malicious Macros]] [[Drive-By Download]] [[Sandbox Analysis]] [[Social Engineering]]