# PROMETHIUM

## What it is
Like a patient fisherman who baits hooks specifically for each fish rather than casting wide nets, PROMETHIUM is a highly targeted Advanced Persistent Threat (APT) group that crafts spear-phishing lures tailored precisely to individual victims. It is a Turkish-linked nation-state threat actor, active since at least 2012, known for deploying the StrongPity malware framework against political dissidents, journalists, and Kurdish populations primarily in Europe and the Middle East.

## Why it matters
In documented campaigns, PROMETHIUM compromised legitimate software download sites — particularly installers for tools like WinRAR and Firefox — injecting StrongPity into the legitimate binary so victims received both the real software and a backdoor simultaneously. This "trojanized installer" technique bypasses user suspicion because the expected application installs and runs perfectly, while the malware silently establishes persistence and exfiltrates documents. Defenders must implement file hash verification and code-signing validation to catch this class of attack.

## Key facts
- PROMETHIUM is tracked by Microsoft as NEODYMIUM and overlaps with the group Talos calls StrongPity (the malware shares the group's informal name)
- Primary initial access vector: watering hole attacks on software download pages combined with spear-phishing
- StrongPity malware capabilities include file collection, keylogging, and modular plugin delivery via encrypted C2 communications
- The group targets victims based on geopolitical and ethnic criteria — making attribution and motive unusually clear for a nation-state actor
- PROMETHIUM demonstrated operational resilience by rebuilding infrastructure and re-targeting the same victims after initial exposure — indicating a persistent, mission-driven mandate

## Related concepts
[[Watering Hole Attack]] [[Spear Phishing]] [[Supply Chain Attack]] [[Nation-State Threat Actors]] [[Trojanized Software]]