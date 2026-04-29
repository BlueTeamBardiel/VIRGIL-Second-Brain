# gzip

## What it is
Like vacuum-sealing a bag of clothes to shrink it for travel, gzip squeezes files down by finding and replacing repetitive patterns with shorter references. Technically, it is a file compression utility and format using the DEFLATE algorithm (a combination of LZ77 and Huffman coding) that reduces file size while preserving data integrity via a CRC-32 checksum.

## Why it matters
Attackers exploit gzip compression in the **CRIME attack** (Compression Ratio Info-leak Made Easy), which targets HTTPS connections where request headers are compressed before encryption. Because compression ratios leak information about repeated content, an attacker who can inject known plaintext and observe ciphertext length can iteratively guess session cookies or tokens character by character — a critical lesson in why compression and encryption should not be naively combined.

## Key facts
- **Magic bytes:** gzip files always begin with `1F 8B` — a reliable signature for file identification and forensic analysis
- **DEFLATE algorithm:** combines LZ77 (sliding window back-references) and Huffman coding; gzip adds a header/trailer around DEFLATE output
- **CRC-32 checksum** is stored in the file footer, enabling integrity verification of decompressed data
- **CRIME and BREACH attacks** both abuse HTTP/TLS compression; CRIME targets header compression (SPDY/TLS), BREACH targets HTTP body compression — mitigated by disabling compression on sensitive responses
- **Web servers** (Apache, nginx) serve `.gz` pre-compressed assets; misconfigured servers accidentally compressing authentication responses create BREACH exposure

## Related concepts
[[CRIME Attack]] [[BREACH Attack]] [[TLS]] [[Steganography]] [[File Signatures]]