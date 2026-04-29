# Diamond Model of Intrusion Analysis

## What it is
Like a crime scene investigator who refuses to focus only on the weapon while ignoring the criminal, the victim, and the motive, the Diamond Model forces analysts to examine all four corners of an attack simultaneously. It is a structured framework for analyzing intrusions using four core features — **Adversary**, **Capability**, **Infrastructure**, and **Victim** — connected at the corners of a diamond, with relationships and metadata binding them together.

## Why it matters
During the APT1 campaign analysis, investigators used relationship mapping (core to the Diamond Model) to pivot from a single malware sample to identifying entire C2 infrastructure clusters, ultimately attributing the campaign to a specific Chinese military unit. Without this relational thinking, defenders would have patched one hole while the adversary simply shifted to another IP in the same infrastructure web.

## Key facts
- The **four core features**: Adversary (who), Capability (how/what tool), Infrastructure (where — IPs, domains), and Victim (target)
- **Meta-features** extend the model: timestamp, phase, result, direction, methodology, and resources — providing operational context
- Supports **activity threading**: linking multiple Diamond events into a chain to reconstruct a full attack campaign timeline
- Enables **pivoting**: if you know one node (e.g., a malware hash), you can infer or hunt for the other three nodes
- Complements the **Cyber Kill Chain** — Kill Chain shows *sequence*, Diamond Model shows *relationships and attribution* per event

## Related concepts
[[Cyber Kill Chain]] [[MITRE ATT&CK Framework]] [[Threat Intelligence]] [[Indicator of Compromise]] [[Attribution Analysis]]