# Statistical Analysis

## What it is
Like a doctor who can diagnose disease by spotting that your heart rate is 40% above your personal baseline — not because they memorized every heartbeat, but because they know what *your* normal looks like — statistical analysis in security means using mathematical models to identify deviations from established behavioral patterns. Precisely: it is the application of quantitative methods to security data (logs, traffic, user behavior) to distinguish normal from anomalous activity without requiring prior knowledge of specific attack signatures.

## Why it matters
A compromised insider account might never trigger a signature-based rule, but statistical analysis will flag that the user downloaded 10GB of data at 2 AM when their 90-day baseline shows 200MB maximum during business hours. This is the core engine behind User and Entity Behavior Analytics (UEBA) tools like Splunk UBA or Microsoft Sentinel, which catch credential theft and data exfiltration that traditional AV completely misses.

## Key facts
- **Baseline establishment** is the prerequisite — you must define "normal" before deviation becomes meaningful; typically requires 30–90 days of data collection
- **False positive rate** is the critical tradeoff: tighter thresholds catch more attacks but generate alert fatigue; looser thresholds miss subtle intrusions
- **Mean and standard deviation** are the foundational metrics — events beyond 2–3 standard deviations from the mean trigger anomaly alerts
- **Trend analysis** detects slow-burn attacks (like a low-and-slow port scan) that individual-event thresholds would miss entirely
- On the **CySA+ exam**, statistical analysis is classified under *anomaly-based detection* and contrasted against *signature-based* and *heuristic-based* detection methods

## Related concepts
[[Anomaly Detection]] [[User and Entity Behavior Analytics]] [[Security Information and Event Management]] [[Baseline Configuration]] [[Behavioral Analysis]]