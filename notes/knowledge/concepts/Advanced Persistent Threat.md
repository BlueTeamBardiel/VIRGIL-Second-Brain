# Advanced Persistent Threat

## What it is
Imagine a skilled burglar who doesn't smash your window and grab the TV — instead, they make a copy of your key, move in quietly, and steal one document per night for three years. An Advanced Persistent Threat (APT) is a prolonged, stealthy cyberattack campaign where a well-resourced adversary (typically nation-state or state-sponsored) gains unauthorized access to a network and maintains that presence undetected to achieve strategic objectives like espionage, sabotage, or intellectual property theft.

## Why it matters
Operation Aurora (2009) demonstrated APT tactics precisely: attackers attributed to Chinese state actors exploited a zero-day in Internet Explorer to compromise Google, Adobe, and 30+ other companies, exfiltrating source code and surveillance data over months before discovery. Defenders responding to APTs must focus on lateral movement detection and anomalous outbound traffic, not just perimeter blocking, because the initial breach is often the least dangerous phase.

## Key facts
- APTs follow a lifecycle: **Reconnaissance → Initial Compromise → Establish Foothold → Escalate Privileges → Lateral Movement → Exfiltration → Maintain Persistence**
- Attributed to nation-state actors and tracked by vendor designations: APT28 (Fancy Bear/Russia), APT41 (China), Lazarus Group (North Korea)
- Primary initial access vectors include spear phishing, watering hole attacks, and supply chain compromise — not brute force
- Dwell time (time between initial compromise and detection) historically averaged **197 days** before FireEye's 2020 M-Trends report showed improvement to ~56 days
- Detection relies heavily on **behavioral indicators** (unusual lateral movement, beaconing traffic) rather than signature-based tools alone

## Related concepts
[[Lateral Movement]] [[Indicators of Compromise]] [[Threat Intelligence]] [[Kill Chain]] [[Spear Phishing]]