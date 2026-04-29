# behavioral analytics

## What it is
Like a casino pit boss who doesn't memorize every rule violation but instead *knows* when a player's betting pattern suddenly shifts, behavioral analytics monitors deviations from established normal activity rather than matching against known bad signatures. It establishes a baseline of typical user or entity behavior, then alerts when statistical anomalies emerge — a core function of User and Entity Behavior Analytics (UEBA) platforms.

## Why it matters
In the 2020 SolarWinds breach, attackers used legitimate credentials to move laterally across networks for months undetected by signature-based tools. Behavioral analytics could have flagged that the compromised service account was suddenly accessing Active Directory objects it had never touched before, generating alerts on *anomalous access patterns* rather than waiting for a known malware signature to trip a rule.

## Key facts
- **UEBA** (User and Entity Behavior Analytics) is the formalized discipline combining behavioral analytics for both human users and non-human entities like servers and IoT devices
- Behavioral analytics relies on **machine learning models** to calculate risk scores based on deviations from a rolling baseline, not static rule sets
- It is particularly effective against **insider threats and credential-based attacks** where no malware is present — the adversary "looks" like a legitimate user
- A key metric is **time-to-detect (TTD)**; behavioral analytics reduces dwell time by catching anomalies that would otherwise persist for weeks or months
- False positive rates are a critical weakness — overly sensitive baselines cause **alert fatigue**, which is why tuning the sensitivity window is an essential operational task

## Related concepts
[[UEBA]] [[insider threat]] [[anomaly detection]] [[SIEM]] [[threat hunting]]