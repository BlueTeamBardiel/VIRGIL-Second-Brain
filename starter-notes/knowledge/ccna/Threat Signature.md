# Threat Signature

## What it is
Like a criminal's fingerprint left at a crime scene, a threat signature is a unique, identifiable pattern extracted from malicious activity. Precisely defined, it is a set of distinguishing characteristics — byte sequences, behavioral patterns, registry changes, or network traffic anomalies — used by security tools to detect known malware, exploits, or attack techniques.

## Why it matters
In 2017, the WannaCry ransomware outbreak was slowed significantly when security vendors pushed signature updates identifying its distinctive SMB exploit payload (EternalBlue) and file encryption patterns. Organizations with up-to-date signature databases could block execution before detonation, while those running stale signatures were compromised within minutes of network exposure.

## Key facts
- **Signature-based detection** compares file hashes, byte strings, or traffic patterns against a known-bad database; it produces low false positives but fails entirely against zero-day threats.
- **YARA rules** are the industry-standard format for writing custom threat signatures, allowing analysts to describe malware families using string patterns and logical conditions.
- **Indicators of Compromise (IoCs)** — including file hashes (MD5/SHA-256), IP addresses, and domain names — are operationalized forms of threat signatures shared via feeds like STIX/TAXII.
- Signature databases must be **continuously updated**; AV vendors typically release updates multiple times daily to keep pace with new variants.
- **Polymorphic and metamorphic malware** deliberately mutate their code to evade static signatures, which is why behavioral/heuristic detection is needed as a complementary layer.

## Related concepts
[[Indicators of Compromise (IoC)]] [[YARA Rules]] [[Intrusion Detection System (IDS)]] [[Heuristic Analysis]] [[2.3 - Zero-day Vulnerabilities]]
