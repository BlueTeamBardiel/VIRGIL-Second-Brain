# apt

## What it is
Like a master burglar who picks the lock, lives in your walls for months, and only steals one document at a time to avoid detection — an Advanced Persistent Threat (APT) is a prolonged, targeted cyberattack where a skilled adversary (typically nation-state or state-sponsored) maintains covert, long-term access to a specific target's network to achieve strategic objectives.

## Why it matters
APT29 (Cozy Bear), linked to Russian intelligence, compromised SolarWinds' build pipeline in 2020, inserting malicious code into software updates that reached 18,000+ organizations including U.S. government agencies — remaining undetected for months. This attack exemplifies APT hallmarks: supply chain exploitation, living-off-the-land techniques, and slow, deliberate data exfiltration designed to avoid triggering alerts.

## Key facts
- APTs follow a lifecycle: **Reconnaissance → Initial Compromise → Establish Foothold → Escalate Privileges → Internal Recon → Move Laterally → Exfiltrate → Maintain Persistence**
- Nation-state APT groups are tracked with naming conventions: MITRE uses numbered groups (APT1, APT28), while vendors use themed names (Fancy Bear, Lazarus Group)
- APTs favor **spear phishing** as the most common initial access vector, often using zero-days or living-off-the-land binaries (LOLBins) to avoid AV detection
- **Dwell time** — the period between initial compromise and detection — historically averages 200+ days for APT intrusions
- Indicators of APT activity include beaconing traffic, unusual privileged account usage, and large compressed archives staged before exfiltration (MITRE ATT&CK T1560)

## Related concepts
[[spear phishing]] [[lateral movement]] [[indicators of compromise]] [[MITRE ATT&CK]] [[supply chain attack]]