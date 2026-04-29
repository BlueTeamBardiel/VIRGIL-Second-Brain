# HEXANE

## What it is
Like a ghost oil rig inspector who gains the trust of engineers before quietly mapping every valve and pressure sensor in the facility, HEXANE is a cyberattack group that infiltrates industrial and critical infrastructure environments through patient, low-profile reconnaissance. Specifically, HEXANE is an Iranian-linked advanced persistent threat (APT) group targeting oil and gas companies, telecommunications providers, and internet service providers primarily in the Middle East, Africa, and Central Asia.

## Why it matters
In 2019, HEXANE was caught targeting ISPs and telecoms in Kuwait and Saudi Arabia — not to steal data from those companies directly, but to use them as launchpads to intercept or pivot into downstream oil and gas targets. This "watering hole through the supplier" approach demonstrates how critical infrastructure attackers exploit trusted third parties rather than attacking hardened targets head-on.

## Key facts
- HEXANE overlaps with threat groups **OilRig (APT34)** and **Lyceum**, sharing infrastructure and TTPs, but is tracked separately due to distinct targeting patterns
- Their primary initial access method is **spear-phishing with weaponized documents** containing macro-based malware
- HEXANE uses a custom implant called **Kaperagent** and a DNS tunneling tool called **DNSExfiltrator** for stealthy command-and-control
- They frequently **target IT/OT convergence zones** — the bridge between corporate IT networks and operational technology (SCADA/ICS) systems
- HEXANE is attributed to **Iranian state-sponsored interests**, making their activity geopolitically significant for energy sector threat intelligence

## Related concepts
[[Advanced Persistent Threat (APT)]] [[Spear Phishing]] [[DNS Tunneling]] [[ICS/SCADA Security]] [[Supply Chain Attack]]