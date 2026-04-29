# false positive

## What it is
Like a smoke detector that screams every time you make toast — it's technically "working," but it's crying wolf. A false positive occurs when a security system flags legitimate, benign activity as malicious, generating an alert that does not correspond to an actual threat.

## Why it matters
In a SOC environment, an IDS tuned too aggressively may generate thousands of false positive alerts per day — for example, flagging normal port scans from an internal vulnerability scanner as reconnaissance attacks. Analysts overwhelmed by this noise experience "alert fatigue," causing them to dismiss or ignore alerts wholesale, which is exactly the condition that allows a real attack to slip through undetected during the chaos.

## Key facts
- A false positive is a **Type I error** in detection logic: the system incorrectly rejects the null hypothesis that traffic is benign.
- High false positive rates are a primary driver of **alert fatigue**, which directly contributed to failures in real breaches like the 2013 Target attack (where valid alerts were dismissed).
- The **detection rate vs. false positive rate tradeoff** is captured in ROC curves; lowering the detection threshold reduces false negatives but increases false positives.
- Tuning signatures, whitelisting known-good behavior, and implementing **baseline behavioral analysis** are standard methods for reducing false positive rates in SIEM and IDS systems.
- On Security+/CySA+ exams, false positives are contrasted against **false negatives** (missed real threats) — false negatives are generally considered *more dangerous* from a security standpoint.

## Related concepts
[[false negative]] [[alert fatigue]] [[intrusion detection system]] [[SIEM]] [[tuning]]