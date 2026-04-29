# APT33

## What it is
Like a nation-state's intelligence agency that moonlights as a saboteur — gathering secrets one day and cutting power lines the next — APT33 is an Iranian-linked threat actor that combines espionage with destructive capabilities. Tracked by FireEye, APT33 (also known as Elfin or Refined Kitten) is a state-sponsored advanced persistent threat group active since at least 2013, targeting aerospace, defense, and energy sectors primarily in the U.S., Saudi Arabia, and South Korea.

## Why it matters
In 2017–2018, APT33 conducted spear-phishing campaigns against aviation and petrochemical companies, luring employees with fake job postings to deploy the DROPSHOT dropper and SHAPESHIFT wiper malware. Defenders watching for destructive payload staging — not just data exfiltration — learned from APT33 that espionage actors can pivot to infrastructure destruction, requiring detection controls beyond traditional DLP.

## Key facts
- **Attribution**: Linked to Iranian government interests; believed to operate on behalf of the Iranian Revolutionary Guard Corps (IRGC)
- **Primary TTPs**: Spear-phishing with credential harvesting, custom malware (TURNEDUP backdoor, DROPSHOT dropper, SHAPESHIFT wiper), and exploitation of public-facing applications
- **Target sectors**: Aerospace, defense, energy/petrochemical — industries with national security and economic leverage
- **Destructive capability**: Use of wiper malware places APT33 alongside APT34 and Shamoon-linked actors in the "destroy, not just steal" category
- **MITRE ATT&CK**: Maps heavily to Initial Access via Phishing (T1566), Command and Control via encrypted channels, and Impact via Data Destruction (T1485)

## Related concepts
[[Advanced Persistent Threat]] [[Spear Phishing]] [[Wiper Malware]] [[MITRE ATT&CK Framework]] [[Threat Intelligence]]