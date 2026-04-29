# Navigation

## What it is
Like a ship's compass telling sailors where they are and where they're going, navigation in cybersecurity refers to the techniques attackers use to move through a target network or system after initial compromise — mapping the environment, locating valuable assets, and plotting paths to objectives. It encompasses both the attacker's reconnaissance of internal topology and the defender's ability to track and restrict that lateral movement.

## Why it matters
During the 2020 SolarWinds attack, threat actors spent weeks navigating silently through victim networks after initial access — enumerating Active Directory, identifying high-value targets, and moving laterally before deploying their final payload. Defenders who had implemented network segmentation and monitored east-west traffic (internal lateral movement) were able to detect anomalous navigation patterns that flat networks completely missed.

## Key facts
- **Lateral movement** is the MITRE ATT&CK tactic (TA0008) describing how attackers navigate between hosts after initial access, using techniques like Pass-the-Hash or RDP hijacking
- **Network segmentation** is the primary defensive control that restricts navigation by forcing traffic through chokepoints where it can be monitored or blocked
- **East-west traffic** refers to internal network communication between hosts — often unmonitored compared to north-south (in/out) traffic, making it the attacker's preferred navigation highway
- **Beaconing** — regular, timed callbacks to a C2 server — can reveal attacker navigation activity even when individual actions appear benign
- On Security+/CySA+ exams, "discovery" (TA0007) precedes navigation: attackers enumerate the environment *before* moving, so unusual internal port scans are an early navigation indicator

## Related concepts
[[Lateral Movement]] [[Network Segmentation]] [[MITRE ATT&CK Framework]]