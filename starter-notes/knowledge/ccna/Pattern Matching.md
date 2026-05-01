# Pattern Matching

## What it is
Like a bouncer at a club checking faces against a "do not admit" photo album, pattern matching compares incoming data against a library of known signatures or behavioral templates to identify threats. Precisely, it is the process by which security tools scan network traffic, files, or logs for sequences of bytes, strings, or behaviors that correspond to pre-defined indicators of malicious activity.

## Why it matters
Snort, one of the most widely deployed IDS/IPS systems, uses pattern matching rules (e.g., `alert tcp any any -> any 80 (content:"cmd.exe"; msg:"Possible shell attempt";)`) to flag HTTP requests containing shell references. Without this mechanism, a web server receiving a command injection payload like `; cat /etc/passwd` would process it silently—pattern matching is what triggers the alert before execution.

## Key facts
- **Signature-based detection** is entirely dependent on pattern matching; if the signature doesn't exist in the database, the threat is invisible (zero-day blind spot).
- **False positives** occur when legitimate traffic matches a malicious pattern; tuning specificity is a core analyst task on the CySA+ exam.
- **YARA rules** are a standardized, portable pattern matching language used by malware analysts to describe and detect malicious files across multiple platforms.
- **Regex (Regular Expressions)** is the primary engine behind most pattern matching in SIEMs like Splunk—analysts use it to parse log fields and build correlation rules.
- **Obfuscation and encoding** (Base64, XOR) are attacker techniques specifically designed to evade pattern matching by making known strings unrecognizable to signature engines.

## Related concepts
[[Intrusion Detection System]] [[YARA Rules]] [[Signature-Based Detection]] [[Regular Expressions]] [[False Positive]]
