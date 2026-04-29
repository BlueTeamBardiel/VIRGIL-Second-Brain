# heuristic-based detection

## What it is
Like a seasoned customs officer who flags suspicious travelers not because they match a known criminal's photo, but because their behavior — nervous glances, inconsistent stories, unusual luggage — fits a pattern of concern. Heuristic-based detection identifies malware or threats by analyzing behavioral characteristics and code structure rather than matching against a known signature database. It uses rules and algorithms to score how "suspicious" something looks, triggering an alert when that score crosses a threshold.

## Why it matters
When the Conficker worm emerged in 2008, many signature-based tools missed early variants because the signatures hadn't been written yet. Heuristic engines caught behavioral red flags — the worm's attempts to disable Windows Update, enumerate network shares, and modify registry keys — even without a known fingerprint. This is the core value proposition: catching zero-days and polymorphic malware that signature databases haven't catalogued yet.

## Key facts
- Heuristic detection operates in two modes: **static** (analyzing code before execution) and **dynamic/behavioral** (monitoring actions during runtime in a sandbox)
- **False positive rate** is the critical tradeoff — aggressive heuristics catch more threats but also flag legitimate software, causing alert fatigue
- Polymorphic and metamorphic malware were specifically engineered to evade signature detection, making heuristics the primary countermeasure
- Security+ and CySA+ expect you to know that heuristics are a **next-generation AV** feature, contrasted against traditional signature-based AV
- A heuristic score threshold that is **too low** increases false negatives; **too high** increases false positives — tuning this balance is a core analyst task

## Related concepts
[[signature-based detection]] [[behavioral analysis]] [[sandboxing]] [[polymorphic malware]] [[false positive]]