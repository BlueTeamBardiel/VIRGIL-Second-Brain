# Fancy Bear

## What it is
Think of a highly-trained intelligence officer who never wears a uniform — blending into civilian networks while stealing secrets for the Kremlin. Fancy Bear (APT28) is a Russian state-sponsored advanced persistent threat group attributed to Russian military intelligence (GRU), operating since at least 2004 and specializing in cyber espionage against government, military, and political targets.

## Why it matters
During the 2016 U.S. presidential election, Fancy Bear compromised the Democratic National Committee (DNC) using spear-phishing emails that harvested credentials through a fake Google login page — a textbook example of how nation-state actors blend social engineering with custom malware (X-Agent, Sofacy) to achieve long-dwell, low-noise intrusions. Defenders responding to this incident learned to prioritize email authentication controls (DMARC/DKIM) and privileged account monitoring as frontline mitigations.

## Key facts
- **Aliases:** APT28, Sofacy Group, Pawn Storm, Sednit — knowing multiple aliases is common in threat intelligence contexts
- **Attribution:** Linked to Russia's GRU Unit 26165 by the U.S. Intelligence Community and private vendors (CrowdStrike, Mandiant)
- **TTPs:** Spear-phishing, credential harvesting, use of zero-days, custom implants (X-Agent keylogger, Komplex macOS malware)
- **Notable targets:** NATO, WADA (World Anti-Doping Agency), German Bundestag, French TV5Monde, Ukrainian military
- **MITRE ATT&CK:** Extensively mapped; commonly referenced for techniques like T1566 (Phishing) and T1078 (Valid Accounts) in CySA+ threat-hunting scenarios

## Related concepts
[[Advanced Persistent Threat (APT)]] [[Spear Phishing]] [[Threat Intelligence]] [[MITRE ATT&CK Framework]] [[Nation-State Attacks]]