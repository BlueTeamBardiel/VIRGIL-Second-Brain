# Heuristic Analysis

## What it is
Like a seasoned customs officer who flags a traveler not because they match a known smuggler's photo, but because their behavior — nervous glances, inconsistent story, sweating in December — fits a suspicious *pattern*, heuristic analysis detects malware by examining behavioral and structural characteristics rather than matching known signatures. It assigns a risk score based on code properties (self-replication routines, API call sequences, encrypted payloads) and flags samples that cross a suspicion threshold, even if never seen before.

## Why it matters
In 2017, many antivirus engines missed early WannaCry samples because no signature existed yet. Heuristic engines that flagged EternalBlue exploitation behavior — specifically, unusual SMB traffic combined with rapid file encryption API calls — provided a detection window that pure signature-based tools did not. This is exactly the scenario heuristics were built for: zero-day and polymorphic threats.

## Key facts
- **Two primary types**: static heuristics (analyzing code structure without execution) and dynamic/behavioral heuristics (monitoring actions during sandbox execution)
- **False positive trade-off**: raising the sensitivity threshold catches more threats but flags more legitimate software — a core tuning challenge for CySA+ analysts
- **Polymorphic malware** is specifically designed to defeat signatures, making heuristics the primary detection layer for variants that mutate their code on each infection
- **Heuristic scoring** assigns weighted values to suspicious indicators; a sample exceeding a vendor-defined score triggers an alert or quarantine
- On Security+ and CySA+, heuristic analysis is contrasted with **signature-based detection** and **anomaly-based detection** — know when each applies

## Related concepts
[[Signature-Based Detection]] [[Behavioral Analysis]] [[Sandboxing]] [[Polymorphic Malware]] [[Anomaly Detection]]