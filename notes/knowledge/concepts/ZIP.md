# ZIP

## What it is
Like a vacuum-seal bag that compresses and bundles multiple items into one package, ZIP is a lossless archive format that compresses and combines files into a single `.zip` container using DEFLATE compression. It supports optional password-based encryption (ZipCrypto or AES-256) to protect contents from unauthorized access.

## Why it matters
Attackers routinely deliver malware inside password-protected ZIP files to bypass email gateway scanning — the scanner can't inspect encrypted contents, so the payload lands in the victim's inbox untouched. The attacker includes the password in the same email body, knowing the human will open it while the security tool cannot. This technique is a staple of phishing campaigns distributing ransomware and infostealers.

## Key facts
- **ZIP bomb** (decompression bomb): a tiny `.zip` file (e.g., 42 KB) that expands to petabytes of data, designed to crash or disable antivirus scanners that try to decompress before scanning.
- **ZipCrypto** (legacy ZIP encryption) is cryptographically weak and vulnerable to **known-plaintext attacks** — if any portion of plaintext is known, the key can be recovered; AES-256 ZIP encryption is significantly stronger.
- ZIP files support **comment fields** in their local and central directory headers, which attackers can use to hide metadata or bypass naive signature detection.
- The **magic bytes** for a ZIP file are `PK` (hex: `50 4B`) — named after Phil Katz, the format's creator — used in file carving and forensic identification.
- Many modern formats are secretly ZIPs: `.docx`, `.xlsx`, `.jar`, `.apk`, and `.odt` are all ZIP archives, making ZIP analysis essential for malware reverse engineering.

## Related concepts
[[Malware Delivery]] [[Decompression Bomb]] [[File Carving]] [[Steganography]] [[Antivirus Evasion]]