# signature-based detection

## What it is
Like a TSA agent checking passports against a watchlist of known criminals, signature-based detection compares incoming data against a database of pre-defined patterns tied to known threats. Precisely: it is a detection method where files, network traffic, or behaviors are scanned for exact or near-exact matches to documented malicious patterns (signatures) stored in a regularly updated database. If the fingerprint matches, an alert fires; if it doesn't, the traffic passes.

## Why it matters
In 2017, the WannaCry ransomware outbreak infected hundreds of thousands of machines globally — but organizations with updated antivirus signatures were protected within hours of WannaCry's initial analysis, because vendors pushed signature updates once the malware's byte patterns were extracted. However, machines that were offline or had stale definitions remained vulnerable, illustrating both the strength and the critical dependency of this approach: freshness of the signature database determines effectiveness.

## Key facts
- Signatures are typically stored as hash values (MD5, SHA-256) or byte-sequence patterns (e.g., YARA rules) matched against files or packet payloads
- **Zero-day attacks bypass signature-based detection by definition** — no signature exists for previously unseen malware
- Detection is fast and produces low false-positive rates for known threats, making it computationally cheap compared to heuristic or behavioral analysis
- Antivirus vendors like CrowdStrike and Symantec push signature updates multiple times per day to close the window of exposure
- Polymorphic malware deliberately mutates its code to evade signature matching while preserving malicious functionality — a direct countermeasure to this method

## Related concepts
[[heuristic-based detection]] [[anomaly-based detection]] [[YARA rules]] [[polymorphic malware]] [[intrusion detection system]]