# Detection methods

## What it is
Like a doctor choosing between an X-ray, blood test, or MRI depending on what disease they're hunting, security detection methods are the specific techniques used to identify threats based on different diagnostic logic. Precisely: detection methods are the analytical approaches—signature-based, anomaly-based, behavior-based, and heuristic—used by security tools to identify malicious activity within systems or networks.

## Why it matters
In 2017, the NotPetya attack evaded signature-based detection because it used novel malware with no prior fingerprint in databases. Organizations running purely signature-based AV were blind to it; those with anomaly-based detection flagged the unusual lateral movement and MBR overwriting behavior, buying critical response time before catastrophic data destruction.

## Key facts
- **Signature-based detection** matches known threat fingerprints—low false positive rate but completely blind to zero-days
- **Anomaly-based detection** establishes a behavioral baseline then alerts on deviations—higher false positive rate but catches novel threats
- **Heuristic detection** uses rules and scoring to evaluate suspicious *characteristics* of code without needing an exact signature match
- **Behavior-based detection** monitors runtime actions (e.g., a PDF spawning cmd.exe) rather than static file properties—highly effective against fileless malware
- **False positive vs. false negative tradeoff** is the core tension: anomaly-based methods increase false positives; signature-based methods increase false negatives against new threats

## Related concepts
[[Intrusion Detection Systems]] [[SIEM]] [[Indicators of Compromise]] [[Threat Intelligence]] [[Zero-day vulnerabilities]]