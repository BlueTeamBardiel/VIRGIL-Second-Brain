# APT-C-36

## What it is
Like a con artist who mails fake utility bills to Colombian households, this group sends weaponized documents disguised as legitimate government and financial communications. APT-C-36 (also known as Blind Eagle) is a South American threat actor believed to operate out of Colombia, primarily targeting Colombian government institutions, financial sector organizations, and infrastructure using spear-phishing campaigns and commercially available RATs.

## Why it matters
In documented campaigns, APT-C-36 sent phishing emails impersonating Colombia's tax authority (DIAN) containing malicious links that delivered AsyncRAT or Imminent Monitor — both off-the-shelf remote access trojans. This demonstrates that sophisticated, persistent threat actors don't always require custom malware; defenders must monitor for commodity tools used in targeted, contextually convincing delivery chains, not just exotic zero-days.

## Key facts
- **Targeting profile**: Colombian and Ecuadorian government, financial, oil/energy, and law enforcement sectors — a rare Latin American-focused APT
- **TTPs**: Heavy reliance on spear-phishing with Spanish-language lures; uses legitimate file-sharing services (Google Drive, OneDrive) to host payloads, bypassing URL reputation filters
- **Preferred tools**: AsyncRAT, Imminent Monitor RAT, LimeRAT, BitRAT — all commercially available or leaked crimeware repurposed for espionage
- **Persistence mechanism**: Uses scheduled tasks and Windows Registry run keys to maintain foothold after initial RAT deployment
- **MITRE ATT&CK alignment**: Prominently maps to T1566 (Phishing), T1105 (Ingress Tool Transfer), and T1053 (Scheduled Task/Job)

## Related concepts
[[Spear Phishing]] [[Remote Access Trojan]] [[Living off Trusted Sites (LOTS)]] [[MITRE ATT&CK Framework]] [[Scheduled Task Persistence]]