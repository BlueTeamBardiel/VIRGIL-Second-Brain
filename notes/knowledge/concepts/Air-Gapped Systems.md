# Air-Gapped Systems

## What it is
Like a medieval castle that pulled up its drawbridge and filled the moat — no roads in, no roads out — an air-gapped system is physically isolated from all external networks, including the internet and local intranets. The "air gap" refers to the literal absence of any wired or wireless connection between the isolated system and outside networks.

## Why it matters
In 2010, the Stuxnet worm famously defeated an air gap at Iranian nuclear facilities by spreading via infected USB drives carried by unsuspecting contractors. This attack demonstrated that air gaps are a physical control, not an impenetrable barrier — human behavior and removable media remain critical attack vectors even when no network connection exists.

## Key facts
- Air-gapped systems are considered a **physical security control**, complementing administrative and technical controls in a defense-in-depth strategy
- Common deployment environments include **industrial control systems (ICS/SCADA)**, nuclear facilities, military classified networks, and financial clearing systems
- Primary attack vectors against air-gapped systems: **infected USB drives, malicious insiders, compromised supply chain hardware**, and exotic covert channels (acoustic, thermal, RF emissions)
- Researchers have demonstrated data exfiltration from air-gapped machines using **fan noise (Fansmitter), hard drive LEDs, and heat emissions** — proof that "no network" ≠ "no data leakage"
- **TEMPEST** is the NSA/NATO standard addressing electromagnetic emanation leakage from air-gapped systems, a threat class distinct from network-based attacks

## Related concepts
[[SCADA and ICS Security]] [[USB Drop Attacks]] [[TEMPEST]] [[Defense in Depth]] [[Physical Security Controls]]