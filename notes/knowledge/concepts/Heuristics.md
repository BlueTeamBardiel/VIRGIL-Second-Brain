# Heuristics

## What it is
Like a seasoned chef who can smell that a dish is "off" without running a lab test, heuristics are rule-of-thumb detection methods that identify threats based on suspicious *behavior or characteristics* rather than known signatures. Precisely: heuristics are analytical techniques used by security tools to flag potentially malicious code or activity by evaluating structural patterns, behavioral anomalies, or scoring thresholds — without requiring a pre-existing definition of the threat.

## Why it matters
When the Stuxnet worm first appeared, no antivirus had a signature for it — but heuristic engines flagged it because it attempted unusual driver installations and injected code into system processes in ways that *looked* malicious even though they were unknown. This is the core defensive value: heuristics catch zero-day malware and novel variants that signature-based tools miss entirely, buying defenders critical detection time before formal signatures are published.

## Key facts
- **Two main types:** Static heuristics analyze code structure (e.g., suspicious API calls, entropy levels indicating packing); dynamic heuristics observe behavior in a sandbox at runtime.
- **False positive tradeoff:** Higher heuristic sensitivity catches more threats but also flags legitimate software — tuning this threshold is a core challenge in endpoint security.
- **Heuristic scoring:** Many AV engines assign a risk score; files exceeding a threshold are quarantined, rather than requiring an exact signature match.
- **Common triggers:** Code that disables security tools, modifies the registry at startup, or uses obfuscation/packing (high entropy) scores higher suspicion.
- **CySA+ relevance:** Heuristics are a key component of **next-generation antivirus (NGAV)** and **EDR** solutions; expect questions pairing heuristics with behavioral analysis and anomaly detection.

## Related concepts
[[Signature-Based Detection]] [[Behavioral Analysis]] [[Sandboxing]] [[Anomaly Detection]] [[Endpoint Detection and Response]]