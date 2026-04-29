# BlackEnergy

## What it is
Think of BlackEnergy like a Swiss Army knife that started life as a simple pocketknife for hire — originally a basic DDoS-for-rent tool that criminal developers kept upgrading until it became a full espionage and sabotage platform. BlackEnergy is a modular malware framework first documented in 2007, evolving through multiple versions to support espionage, credential theft, and destructive ICS/SCADA attacks via a plugin-based architecture.

## Why it matters
In December 2015, BlackEnergy (specifically the BlackEnergy 3 variant paired with KillDisk) was used to attack Ukrainian power grid operators, causing roughly 230,000 people to lose electricity — the first confirmed malware-induced power outage in history. Defenders studying this incident learned that air-gapping OT networks from corporate IT networks is insufficient if operators can receive spear-phishing emails that bridge the gap through human interaction.

## Key facts
- **Three major versions exist:** BlackEnergy 1 (2007, DDoS botnet), BlackEnergy 2 (rootkit, kernel-mode driver), BlackEnergy 3 (2014+, lighter footprint, no kernel driver, ICS targeting)
- **Attribution:** Linked to Sandworm Team (APT44), a Russian GRU-affiliated threat actor also responsible for NotPetya and Olympic Destroyer
- **Initial access vector:** Primarily spear-phishing with malicious Microsoft Word/Excel documents exploiting macros or known Office vulnerabilities
- **Plugin architecture:** Core malware is a loader; destructive capabilities (KillDisk, screen scrapers, SSH backdoors) are delivered as separate encrypted plugins
- **ICS relevance:** BlackEnergy specifically targeted GE Cimplicity, Advantech/WebAccess, and Siemens WinCC SCADA software — making it a critical case study for industrial control system security

## Related concepts
[[Advanced Persistent Threat]] [[ICS/SCADA Security]] [[Spear Phishing]] [[KillDisk]] [[Sandworm]]