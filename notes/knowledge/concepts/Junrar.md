# Junrar

## What it is
Like a locksmith that can open RAR safes but has no tools to pick locks or plant bugs, Junrar is a read-only Java library purpose-built to extract and inspect RAR archive files. It is an open-source, pure-Java implementation that parses RAR 4.x and RAR 5.x formats without wrapping native binaries like UnRAR.

## Why it matters
Security tools and antivirus engines that scan compressed files for malware must decompress archives before inspecting their contents — a threat actor who embeds a malicious payload inside a RAR archive is betting that the scanning engine either skips RAR files or uses a vulnerable decompressor. Junrar is commonly integrated into malware analysis pipelines (e.g., Apache Tika, VirusTotal-style sandboxes) to safely unpack and inspect RAR contents in a controlled Java environment, reducing the attack surface compared to invoking native binaries with elevated privileges.

## Key facts
- Junrar is **read-only** — it cannot create or modify RAR archives, only extract and inspect them, limiting its exploit surface.
- It supports **RAR 4.x and RAR 5.x** formats; confusingly, RAR 5 uses a completely different header structure than RAR 4, requiring separate parsing logic.
- Malicious actors use **RAR polyglots** (files valid as both a RAR and another format) to evade scanners — Junrar's strict parsing can help detect format anomalies.
- **Archive bombs** (deeply nested or highly compressed archives) are a known DoS vector against decompression libraries, including Junrar; depth and size limits must be enforced externally.
- Junrar is used by **Apache Tika**, a widely deployed content-detection library, making Junrar vulnerabilities potentially high-impact across enterprise data pipelines.

## Related concepts
[[Archive Malware]] [[Malicious File Upload]] [[Content Disarm and Reconstruction]] [[Apache Tika]] [[Zip Bomb]]