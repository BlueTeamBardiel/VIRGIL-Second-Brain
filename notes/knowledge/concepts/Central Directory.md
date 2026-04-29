# Central Directory

## What it is
Think of it as the table of contents stapled to the *back* of a book — a ZIP archive stores a summary index of all its files at the very end of the file, not the beginning. The Central Directory (CD) is a data structure at the tail of a ZIP archive that catalogs every file's name, size, compression method, and offset pointer to its actual data earlier in the archive. Crucially, most ZIP parsers trust the Central Directory over the local file headers that precede each compressed chunk.

## Why it matters
Attackers exploit the trust gap between the Central Directory and local file headers to craft **ZIP polyglots** — files that appear to be valid images or PDFs to one parser while hiding malicious payloads that a ZIP extractor will faithfully unpack. This technique bypassed email attachment scanners and antivirus tools that inspected only local headers, allowing malware delivery through what appeared to be a harmless JPEG. Security tools must validate *both* structures match to catch this evasion.

## Key facts
- The Central Directory lives at the end of a ZIP file, located via the **End of Central Directory (EOCD)** signature: `PK\x05\x06`
- Each Central Directory entry contains: file name, compressed/uncompressed size, CRC-32 checksum, and a **relative offset** pointing back to the local file header
- ZIP64 format extends these fields for archives exceeding 4 GB, using a separate **EOCD64 locator** — a second parsing target for evasion
- Discrepancies between Central Directory metadata and local file headers are a red flag for **archive manipulation or ZIP bomb** construction
- Antivirus and DLP tools that only read the Central Directory can be fooled by prepending malicious content before the first local file header (the polyglot trick)

## Related concepts
[[ZIP Bomb]] [[Polyglot Files]] [[File Signature Analysis]] [[Archive Malware Evasion]]