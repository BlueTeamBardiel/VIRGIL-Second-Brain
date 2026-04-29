# Sofacy

## What it is
Think of Sofacy as a ghost that breaks into embassies and defense ministries while leaving barely any fingerprints. Sofacy (also known as APT28, Fancy Bear, or STRONTIUM) is a Russian state-sponsored advanced persistent threat group attributed to Russian military intelligence (GRU), known for long-term espionage campaigns targeting governments, militaries, and political organizations worldwide.

## Why it matters
In 2016, Sofacy compromised the Democratic National Committee (DNC) using spearphishing emails containing malicious links that deployed their custom malware tools, X-Agent and X-Tunnel, to exfiltrate gigabytes of sensitive communications. Defenders analyzing the incident identified the group through distinctive malware code reuse and command-and-control infrastructure patterns previously attributed to the same actors — demonstrating how threat attribution works in practice.

## Key facts
- **Attribution**: Linked to Russia's GRU Unit 26165; consistently attributed by US-CERT, CrowdStrike, and multiple Western intelligence agencies
- **Primary TTPs**: Spearphishing with credential harvesting, zero-day exploitation, and custom malware families including X-Agent (cross-platform keylogger/data exfiltrator) and Sofacy/SPLM implants
- **Targeting profile**: NATO member governments, military organizations, defense contractors, political parties, and journalists — classic intelligence collection targets
- **MITRE ATT&CK**: Heavily documented framework actor; exhibits techniques across nearly every tactic including T1566 (Phishing), T1078 (Valid Accounts), and T1027 (Obfuscated Files)
- **Living off the land**: Increasingly uses legitimate tools like PowerShell and WMI alongside custom malware to blend into normal network activity and evade detection

## Related concepts
[[APT (Advanced Persistent Threat)]] [[Spearphishing]] [[MITRE ATT&CK Framework]] [[Threat Intelligence]] [[Indicators of Compromise]]