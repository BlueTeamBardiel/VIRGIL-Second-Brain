# alert fatigue

## What it is
Like a car alarm that goes off so often in your neighborhood that everyone ignores it — including the night it signals an actual theft — alert fatigue occurs when security analysts become desensitized to warnings due to overwhelming volume of false positives. Technically, it is the cognitive and operational state where SOC analysts begin ignoring, dismissing, or inadequately investigating security alerts because the sheer quantity of notifications exceeds human processing capacity.

## Why it matters
During the 2013 Target breach, the FireEye security system flagged the Citadel malware intrusion multiple times with high-severity alerts — and analysts in the Bangalore SOC dismissed them as false positives among thousands of daily notifications. Attackers exfiltrated 40 million credit card records precisely because the signal was buried in noise, demonstrating that alert fatigue can be as damaging as having no detection capability at all.

## Key facts
- Studies show SOC analysts can receive **10,000+ alerts per day**, with false positive rates sometimes exceeding 80%, making triage statistically overwhelming
- Alert fatigue is a **human factors / organizational risk**, not a technical vulnerability — it exploits analyst cognition, not system architecture
- Mitigation strategies include **SIEM tuning**, alert prioritization, automated triage (SOAR platforms), and establishing baseline thresholds to suppress known-good behavior
- **Alarm tuning** (reducing false positives) is a core CySA+ objective — over-sensitive rules are considered a security control failure, not a safety net
- Attackers can **deliberately trigger low-severity alerts** to train analysts to ignore a particular pattern before launching the real attack (a form of conditioning)

## Related concepts
[[false positive]] [[SIEM]] [[SOAR]] [[incident response]] [[threat intelligence]]