# False Negative

## What it is
Like a metal detector at an airport that waves through a passenger carrying a hidden ceramic knife — it scanned, it beeped nothing, and the threat passed undetected. In security, a **false negative** occurs when a detection system fails to flag a genuine threat, classifying malicious activity as benign. It is the silent killer of security postures: the alert that never fires.

## Why it matters
In 2017, the Equifax breach persisted for 78 days partly because their SSL inspection tool had been misconfigured, generating false negatives that allowed malicious traffic to blend into normal network flow undetected. A high false negative rate means attackers are operating inside your environment while your SIEM reports a clean bill of health — arguably more dangerous than a noisy false positive environment.

## Key facts
- False negative rate is calculated as: **FN / (FN + TP)** — also called the **Miss Rate**
- On Security+/CySA+, false negatives are considered **more dangerous** than false positives in most threat scenarios because attackers go undetected
- IDS/IPS tuned too loosely (permissive thresholds) produce high false negatives; tuned too strictly produces high false positives — this is the **detection tuning tradeoff**
- Signature-based detection systems are especially prone to false negatives against **zero-day exploits** and **polymorphic malware** because no matching signature exists
- Penetration testers deliberately trigger false negatives by using **evasion techniques** (fragmentation, encoding, living-off-the-land binaries) to test detection gaps

## Related concepts
[[False Positive]] [[Intrusion Detection System]] [[True Positive Rate]] [[SIEM]] [[Evasion Techniques]]