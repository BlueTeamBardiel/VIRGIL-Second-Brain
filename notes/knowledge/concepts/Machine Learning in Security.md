# Machine Learning in Security

## What it is
Like a sommelier who learns to detect counterfeit wine not from a rulebook but from tasting thousands of bottles, ML systems learn to identify threats by ingesting massive datasets of known-good and known-malicious behavior. Machine learning in security applies statistical algorithms that train on labeled data to automatically classify, detect, and predict threats without requiring manually written signatures. Unlike traditional rule-based detection, ML models generalize from patterns to catch novel variants.

## Why it matters
In 2023, attackers began using polymorphic malware that changes its bytecode signature on every execution, defeating hash-based AV entirely. ML-based endpoint detection platforms like CrowdStrike Falcon analyze behavioral features — system call sequences, memory allocation patterns, network beaconing intervals — to flag the malware despite having never seen that exact binary before. This behavioral modeling catches zero-day variants that signature databases cannot.

## Key facts
- **Supervised learning** trains on labeled datasets (malicious/benign); **unsupervised learning** finds anomalies without labels — both are used in UEBA (User and Entity Behavior Analytics)
- **False positive rate is critical**: a model tuned too aggressively will generate alert fatigue, causing analysts to miss real incidents buried in noise
- **Adversarial ML** is an active attack vector — attackers craft inputs (adversarial examples) specifically designed to fool ML classifiers into misclassifying malware as benign
- **Training data poisoning** is a supply-chain attack where adversaries inject malicious samples into the training dataset to corrupt the model's future decisions
- ML underpins **SIEM anomaly detection**, **spam filtering**, **DLP classification**, and **network traffic analysis** — all testable CySA+ domains

## Related concepts
[[Behavioral Analysis]] [[UEBA]] [[Anomaly-Based Detection]] [[Adversarial Attacks]] [[SIEM]]