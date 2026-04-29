# decompression bomb

## What it is
Imagine handing someone a tiny origami swan and telling them to unfold it — except each fold reveals ten more folds, and unfolding the whole thing would fill a football stadium. A decompression bomb (also called a "zip bomb") is a maliciously crafted compressed file that appears small but expands to a catastrophically large size when decompressed, exhausting system memory, disk space, or CPU and causing denial of service.

## Why it matters
Antivirus scanners and email gateways that automatically decompress attachments for inspection are prime targets — a classic example is `42.zip`, a 42-kilobyte file that recursively expands to 4.5 petabytes. An attacker can use a decompression bomb to crash or disable a security tool, effectively blinding it before delivering the actual malicious payload in a follow-up file.

## Key facts
- The classic `42.zip` achieves its size through nested compression layers: 16 files × 16 files × ... reaching petabyte scale while remaining kilobytes on disk
- A decompression bomb is categorized as a **Denial of Service (DoS)** attack vector, not a code execution exploit
- Defense requires scanners to enforce **decompression ratio limits** and **maximum output size thresholds** before fully extracting content
- MIME type and magic byte validation alone do **not** protect against decompression bombs — the file is a legitimate archive
- Modern variants called **"single-layer" zip bombs** (e.g., David Fifield's 2019 design) achieve millions-to-one expansion ratios without recursive nesting, evading naive depth-limit defenses

## Related concepts
[[denial of service]] [[malware analysis]] [[antivirus evasion]] [[file upload vulnerabilities]] [[input validation]]