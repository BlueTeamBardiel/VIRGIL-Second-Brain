# AID

## What it is
Think of AID like a security camera that only works when someone's actually breaking in—it detects attacks *as they happen*, not before. Anomaly-based Intrusion Detection (AID) is a network security system that learns what "normal" traffic looks like, then flags deviations as potential threats. Unlike signature-based detection (which matches known attack patterns), AID identifies novel, zero-day attacks by spotting behavioral oddities.

## Why it matters
A targeted attack using a never-before-seen malware payload won't match any signature database, making signature-based IDS useless. But AID would catch the same attack by noticing unusual network flows—a workstation suddenly exfiltrating gigabytes of data at 3 AM, or a server making connections to blacklisted IP ranges. This detection method is critical for defending against advanced persistent threats (APTs) where attackers deliberately avoid known signatures.

## Key facts
- Builds statistical models of baseline behavior (packet sizes, protocol distributions, timing patterns)
- Generates false positives when legitimate activity deviates from baseline (requires tuning)
- Cannot determine *why* anomalies occurred—only that they deviate from normal
- Computationally expensive compared to signature matching; requires significant training data
- Works best in controlled environments with stable, predictable network behavior

## Related concepts
[[IDS/IPS]] [[Signature-based Detection]] [[Behavioral Analysis]] [[Zero-day Attacks]] [[Network Baseline]]