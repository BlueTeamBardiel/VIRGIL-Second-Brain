# Base64

## What it is
Like translating a foreign manuscript into Morse code so it can travel over a telegraph line that only understands dots and dashes — Base64 is an encoding scheme that converts arbitrary binary data into a 64-character ASCII alphabet (A–Z, a–z, 0–9, +, /) so it can safely traverse systems that only handle text. It is *not* encryption; it's a reversible translation with zero secrecy.

## Why it matters
Attackers routinely use Base64 to obfuscate malicious PowerShell payloads — a command like `IEX (New-Object Net.WebClient).DownloadString(...)` becomes an unreadable blob that slips past naive keyword-based detection. SOC analysts hunting for this will grep logs for `powershell -EncodedCommand` or `-enc`, which is Windows' built-in flag for Base64-encoded commands — a near-universal red flag in incident response.

## Key facts
- Base64 increases data size by approximately **33%** — every 3 bytes of input become 4 ASCII characters of output
- The `=` or `==` padding characters at the end are a reliable visual signature that something is Base64-encoded
- Base64 is **encoding, not encryption** — it provides zero confidentiality and is trivially reversible with any decoder
- Malware frequently chains Base64 with actual encryption (e.g., XOR or AES) to both obfuscate and protect payloads
- Base64 is standard in **MIME email attachments**, **JWTs (JSON Web Tokens)**, and embedding binary data in HTML/CSS (`data:` URIs)

## Related concepts
[[Obfuscation]] [[PowerShell Attacks]] [[Encoding vs Encryption]] [[JWT Security]] [[Malware Analysis]]