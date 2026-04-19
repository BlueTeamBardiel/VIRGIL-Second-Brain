# Threat Actors — Who Is Actually Attacking You
> TTPs matter more than IOCs. An IP address expires in 24 hours. A technique lasts years.

Understanding *who* is attacking you changes how you defend. Nation-states don't care about your firewall rules — they'll 0-day right through. Ransomware gangs care about ROI — make recovery easy and they move on.

---

## Threat Actor Categories

### Nation-State APTs
**Motivation:** Espionage, sabotage, geopolitical leverage
**Resources:** Unlimited budget, zero-days, full-time operators
**Targets:** Government, defense contractors, critical infrastructure, elections
**TTPs:** Long dwell time (months), low-and-slow, custom malware, supply chain attacks
**What makes them hard to catch:** They *want* to stay hidden. Average dwell time before detection: 197 days.

### Cybercriminal Groups
**Motivation:** Money — ransomware, fraud, data brokering
**Resources:** Well-funded via RaaS economies, buy-in-bulk exploit kits
**Targets:** Healthcare, finance, education, SMBs (easy money, weak defenses)
**TTPs:** Phishing → loader → ransomware, automated scanning for known vulns
**What makes them hard to catch:** Operating from permissive jurisdictions (RU, CN, KP, IR)

### Hacktivists
**Motivation:** Political/ideological — DDoS, defacement, data leaks
**Resources:** Variable — sometimes coordinated (Anonymous), sometimes solo
**Targets:** Governments, corporations, media
**TTPs:** DDoS, website defacement, leaking embarrassing data
**What makes them hard to catch:** Loose organization, distributed, politically protected

### Insider Threats
**Motivation:** Greed, grievance, coercion, accidental
**Resources:** Already have access — bypasses perimeter entirely
**Targets:** Their own employer's data/systems
**TTPs:** Data exfil to personal cloud/USB, sabotage, credential theft
**What makes them hard to catch:** Legitimate access, behavioral detection is hard

---

## Major Threat Actors

### APT28 — Fancy Bear (Russia)
- **Attribution:** Russian GRU (Military Intelligence), Unit 26165
- **Since:** ~2004, well documented since 2014
- **Targets:** NATO governments, military, political parties, elections, aerospace
- **Signature ops:** DNC hack (2016), German Bundestag (2015), French election (2017), WADA data leaks
- **Tools:** X-Agent (cross-platform implant), Sofacy/Zebrocy (downloader), X-Tunnel (C2), Mimikatz
- **TTPs:** Spearphishing → credential harvesting → network traversal. Heavy use of [[Living Off the Land]] after initial access.
- **Why they matter for CySA+:** Canonical example of nation-state TTPs. Know their [[MITRE ATT&CK]] profile cold.
- Related: [[MITRE ATT&CK]] G0007, G0016

### Lazarus Group (North Korea)
- **Attribution:** North Korean Reconnaissance General Bureau (RGB)
- **Motivation:** Dual — espionage AND financial (sanctions evasion through crypto theft)
- **Targets:** Financial institutions, crypto exchanges, defense contractors, media (Sony)
- **Signature ops:** Sony Pictures hack (2014), SWIFT banking attacks ($81M Bangladesh Bank 2016), WannaCry (2017), $1.7B in crypto theft 2022
- **Tools:** RATANKBA, HOPLIGHT, custom loaders, supply chain implants
- **TTPs:** Custom malware, false flag operations, watering hole attacks, supply chain compromise
- **Why unique:** Only major APT that's actively *robbing banks* to fund state operations
- Related: [[MITRE ATT&CK]] G0032

### Sandworm — Unit 74455 (Russia)
- **Attribution:** Russian GRU Unit 74455
- **Specialization:** Destructive attacks — the most dangerous APT for critical infrastructure
- **Signature ops:** Ukrainian power grid (2015, 2016 — first confirmed cyber → physical attack), NotPetya (2017, $10B damage), Olympic Destroyer (2018), Industroyer/Crashoverride (ICS malware)
- **Tools:** BlackEnergy, Industroyer, Cyclops Blink, Olympic Destroyer, NotPetya
- **TTPs:** ICS/SCADA targeting, wiper malware disguised as ransomware, false flags
- **Why they matter:** They've actually turned off the lights. NotPetya caused more damage than any prior cyberattack.
- Related: [[MITRE ATT&CK]] G0034

### APT41 (China)
- **Attribution:** Chinese MSS-affiliated, with criminal freelancing
- **Unique trait:** Dual-mission — state espionage AND personal financial crime (unusual)
- **Targets:** Healthcare, telecom, technology, gaming (financial), government, supply chain
- **Signature ops:** Nexus Guard (gaming fraud), SolarWinds-adjacent, supply chain via software updates
- **Tools:** HIGHNOON, POISONPLUG, MESSAGETAP, supply chain implants in legitimate software
- **TTPs:** Supply chain compromise ([[T1195]]), valid accounts ([[T1078]]), watering holes
- **Why unique:** Will hack a hospital for China and then hack a video game company for themselves
- Related: [[MITRE ATT&CK]] G0096

---

## How to Use Threat Intelligence

### TTPs Over IOCs
**IOCs (Indicators of Compromise):** IP addresses, domains, file hashes, email addresses
**TTPs (Tactics, Techniques, Procedures):** How they operate — the behavioral fingerprint

Why IOCs are mostly useless:
- IP addresses: burned in 24-48 hours, shared with innocent parties, VPN/Tor
- Domains: registered fresh for each campaign, fast-flux DNS
- File hashes: trivially changed — one byte modification = different hash

Why TTPs persist:
- Changing *how* you operate is expensive and requires retraining
- APT28 has used spearphish → credential harvest → lateral movement for 10+ years
- Defense based on TTPs survives adversary retooling

### Diamond Model
Four vertices: Adversary → Infrastructure → Capability → Victim
Use it to pivot: if you know their infrastructure, find other victims. If you find their capability, find other infrastructure.

### Intelligence-Driven Defense
1. Identify which threat actors target your sector
2. Map their TTPs to [[MITRE ATT&CK]]
3. Test your controls against those specific TTPs (purple team)
4. Build detection rules for their behavioral patterns, not their current tools

---

## Tags
`#threat-intelligence` `#apt` `#nation-state` `#adversary-tracking`

[[MITRE ATT&CK]] [[Incident Response]] [[CySA+]] [[Splunk]] [[Blue Team]] [[DFIR]]
