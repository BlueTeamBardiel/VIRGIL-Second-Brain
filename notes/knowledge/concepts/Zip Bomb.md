# zip bomb

## What it is
Imagine a clown car that, when opened, releases ten thousand more clown cars — each containing ten thousand more. A zip bomb (also called a decompression bomb) is a maliciously crafted archive file that contains heavily nested or recursive compressed data, designed to expand to an absurdly large size upon extraction and exhaust system resources like disk space, memory, or CPU. The classic example, `42.zip`, is only 42 kilobytes compressed but expands to approximately 4.5 petabytes.

## Why it matters
Attackers use zip bombs to neutralize antivirus scanners: when a security tool attempts to inspect the archive, the decompression process consumes all available resources and crashes or hangs the scanner — effectively blinding it. This technique appeared in early malware campaigns where attackers would email zip bombs to overwhelm mail server scanning engines, allowing subsequent malicious payloads to slip through undetected.

## Key facts
- `42.zip` is the canonical example: a 42 KB file with 5 layers of nesting, each level containing 16 files, ultimately expanding to ~4.5 PB
- Modern zip bombs use **non-recursive (overlapping) techniques** — a single-layer archive that achieves extreme ratios by referencing the same compressed data block repeatedly, making them harder to detect structurally
- **Compression ratio** is the key detection metric; most security tools flag archives exceeding a ratio of ~100:1 as suspicious
- Zip bombs target **availability** — they are a denial-of-service attack against the file system or scanning process, not confidentiality or integrity
- Defenses include setting **decompression depth limits**, **size thresholds before extraction**, and using streaming inspection rather than full extraction in AV engines

## Related concepts
[[denial of service]] [[antivirus evasion]] [[malicious file upload]] [[compression algorithms]] [[defense in depth]]