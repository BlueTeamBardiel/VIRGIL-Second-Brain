# zlib

## What it is
Think of zlib like a vacuum-seal bag for data — it squeezes out the empty air (redundant bytes) so information travels faster and takes up less space, then re-inflates perfectly on the other end. Technically, zlib is an open-source data compression library implementing the DEFLATE algorithm, providing lossless compression and decompression functions used by countless applications and protocols.

## Why it matters
The CRIME attack (2012) exploited zlib compression in TLS/SSL sessions to decrypt secret cookies. Because zlib compresses data *before* encryption, an attacker who can inject chosen plaintext alongside a secret (like a session cookie) can measure compressed size changes to guess the secret byte-by-byte — smaller output means the guess matched existing patterns. This is why TLS 1.3 disabled compression entirely.

## Key facts
- zlib uses the **DEFLATE algorithm**, which combines LZ77 (back-references to repeated sequences) and Huffman coding for compression
- CRIME (Compression Ratio Info-leak Made Easy) is the canonical attack exploiting zlib in TLS; BREACH is its HTTP-level cousin exploiting gzip (also DEFLATE-based)
- zlib is embedded in PNG images, ZIP/gzip files, HTTP content-encoding, PDF files, and the Git object store
- A **zlib bomb** (compression bomb) is a maliciously crafted file that decompresses to an enormous size (e.g., 42KB → 4.5 petabytes), causing DoS by exhausting memory or disk
- The library itself has had critical CVEs (e.g., **CVE-2022-37434**) involving heap buffer overflow during inflate — making it a supply-chain attack surface

## Related concepts
[[CRIME Attack]] [[Compression Bombs]] [[DEFLATE Algorithm]] [[TLS]] [[Supply Chain Vulnerabilities]]