# Alert Tuning

## What it is
Like adjusting a car's motion-sensor alarm so it stops triggering every time a truck drives by — but still screams when someone actually breaks the window — alert tuning is the process of refining SIEM and IDS/IPS rules to reduce false positives and false negatives until alerts are actionable and accurate. It involves modifying thresholds, suppression rules, whitelists, and correlation logic to match the actual environment and threat profile.

## Why it matters
During the SolarWinds supply chain attack, defenders who had properly tuned their SIEM rules to baseline normal Orion platform behavior had a better chance of spotting anomalous outbound connections to attacker-controlled C2 infrastructure. Organizations drowning in thousands of daily false positives would have buried that critical signal in noise, delaying detection by weeks or months.

## Key facts
- **False Positive Rate** is the primary target of tuning — high false positive rates cause alert fatigue, where analysts begin ignoring or auto-dismissing alerts, including real ones
- **Suppression rules** silence known-benign events (e.g., scheduled vulnerability scans from a specific IP) without disabling the underlying detection logic entirely
- **Thresholds** define the trigger point — e.g., 5 failed logins in 60 seconds vs. 500 — and must be calibrated against environment-specific baseline behavior
- CySA+ exam expects candidates to understand the tuning cycle: **deploy → monitor → identify noise → adjust → re-evaluate**
- Tuning is **not a one-time task** — network changes, new software deployments, and evolving attacker TTPs require continuous re-calibration to maintain alert fidelity

## Related concepts
[[SIEM]] [[False Positive vs False Negative]] [[Threat Intelligence]] [[IDS/IPS]] [[Alert Fatigue]]