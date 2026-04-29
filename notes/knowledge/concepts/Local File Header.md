# Local File Header

## What it is
Like a label on a shipping box that lists contents, weight, and destination *before* you open it, a Local File Header is the metadata record that precedes each compressed file entry inside a ZIP archive. It stores the filename, compression method, file size, CRC-32 checksum, and timestamp for that specific entry — repeated locally even though a central directory exists at the end of the archive.

## Why it matters
Attackers exploit inconsistencies between the Local File Header and the ZIP Central Directory Header in a technique called a **ZIP file smuggling** or **zip of death** attack. Security scanners that read only the Central Directory may report a file as benign, while extraction tools that trust the Local File Header unpack malicious payloads — this mismatch is how malware bypasses antivirus inspection at email gateways and web proxies.

## Key facts
- **Signature**: Every Local File Header begins with the magic bytes `50 4B 03 04` (PK♥♦), making it identifiable in hex forensics
- **Fields include**: version needed to extract, general purpose bit flag, last-modified time/date, CRC-32, compressed size, uncompressed size, and filename length
- **Dual-directory design**: ZIP archives contain *both* Local File Headers (before each entry) and a Central Directory (at end of file) — discrepancies between them are a red flag for tampering
- **CRC-32 weakness**: The checksum is not a cryptographic hash; it detects corruption but cannot verify integrity against deliberate modification
- **Forensic pivot point**: Malware embedded in ZIP archives often manipulates filename fields in the Local File Header to exploit path-traversal vulnerabilities (e.g., `../../etc/passwd`)

## Related concepts
[[ZIP Central Directory]] [[Magic Bytes]] [[Path Traversal]] [[CRC Checksum]] [[Polyglot Files]]