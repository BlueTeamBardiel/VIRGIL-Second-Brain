# OilRig

## What it is
Like a long-term corporate spy who infiltrates a company, learns its secrets over months, and quietly exfiltrates data while appearing to be a trusted vendor, OilRig is an Iranian state-sponsored Advanced Persistent Threat (APT) group (also tracked as APT34 or Helix Kitten) that conducts long-term espionage campaigns. They specialize in credential harvesting and persistent access against government, financial, and critical infrastructure targets — primarily in the Middle East.

## Why it matters
In 2019, a disgruntled OilRig member leaked the group's tools and victim data on Telegram, accidentally exposing their entire malware arsenal including the DNSpionage campaign infrastructure. This breach-within-a-breach revealed how OilRig used DNS hijacking to intercept credentials from Middle Eastern government agencies — demonstrating that even threat actors have insider threat problems.

## Key facts
- **Attribution:** Linked to Iranian intelligence (MOIS); active since approximately 2014; primarily targets Saudi Arabia, UAE, and US-aligned Middle Eastern organizations
- **TTPs:** Uses spear-phishing with malicious macro-embedded documents, custom backdoors (POWRUNER, BONDUPDATER), and DNS tunneling for command-and-control (C2) communications
- **DNS Tunneling:** OilRig encodes stolen data inside DNS queries to bypass firewall inspection — traffic looks like legitimate name resolution but carries exfiltrated credentials
- **MITRE ATT&CK:** Maps to T1071.004 (DNS Application Layer Protocol), T1566.001 (Spearphishing Attachment), and T1078 (Valid Accounts) for persistence
- **2019 Leak:** Their toolset was publicly dumped, allowing defenders to build detection signatures directly from actual nation-state malware — a rare intelligence windfall

## Related concepts
[[Advanced Persistent Threat]] [[DNS Tunneling]] [[Spear Phishing]] [[MITRE ATT&CK Framework]] [[Command and Control]]