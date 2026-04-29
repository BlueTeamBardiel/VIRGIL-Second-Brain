# GCMP

## What it is
Like a Swiss Army knife that both locks your data AND verifies nobody tampered with it — in a single tool — GCMP (Galois/Counter Mode Protocol) is a wireless encryption protocol used in WPA3 and 802.11ad/ay that combines AES-GCM encryption with built-in authentication. It provides both confidentiality and integrity simultaneously, replacing the older CCMP used in WPA2.

## Why it matters
GCMP is critical to WPA3 security because its underlying AES-GCM construction is resistant to the KRACK (Key Reinstallation Attack) vulnerabilities that devastated WPA2/CCMP networks. However, GCMP is uniquely dangerous if a nonce is ever reused — unlike CCMP, nonce reuse in GCMP allows an attacker to forge authentication tags and decrypt traffic entirely, meaning implementation errors carry catastrophic consequences.

## Key facts
- GCMP uses **AES in Galois/Counter Mode (GCM)**, providing both encryption and a **GHASH-based authentication tag** (GMAC) in one pass
- Supports **128-bit and 256-bit key lengths** (GCMP-128 and GCMP-256), whereas CCMP is limited to 128-bit
- **Mandatory in WPA3** and used in 802.11ad (WiGig) due to its higher throughput efficiency compared to CCMP
- **Nonce reuse is catastrophic**: reusing a nonce with the same key allows full message forgery and plaintext recovery — this is the Forbidden Attack against WPA2-Enterprise GCMP deployments
- The authentication tag in GCMP is **128 bits**, compared to CCMP's 64-bit MIC, providing stronger integrity protection

## Related concepts
[[WPA3]] [[CCMP]] [[AES-GCM]] [[KRACK Attack]] [[802.11 Security]]