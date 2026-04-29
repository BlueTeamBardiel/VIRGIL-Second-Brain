# SolarWinds Supply Chain Attack

## What it is
Imagine a trusted bakery secretly lacing every loaf of bread with a slow-acting poison before distribution — customers never suspect the source because they trust the baker. The SolarWinds attack worked identically: threat actors (APT29/Cozy Bear) compromised the build pipeline of SolarWinds' Orion IT monitoring software, injecting the SUNBURST backdoor into legitimate, digitally signed software updates distributed to ~18,000 organizations worldwide in 2020.

## Why it matters
Because the malicious code arrived via a trusted, signed update from a legitimate vendor, traditional perimeter defenses and antivirus tools failed to detect it. Attackers then used SUNBURST to establish persistent access inside victim networks — including the U.S. Treasury, DHS, and DOD — for months before discovery, demonstrating that trusting a vendor's signature is not the same as trusting their security posture.

## Key facts
- **Initial access vector**: Compromise of the SolarWinds Orion software build environment (CI/CD pipeline poisoning), not a direct victim network breach
- **Dwell time**: Attackers remained undetected for approximately 8–9 months (March–December 2020)
- **SUNBURST behavior**: The backdoor lay dormant for ~14 days after installation before beaconing to C2 infrastructure via DNS to evade sandbox analysis
- **Attribution**: Attributed to Russia's SVR (APT29/Cozy Bear) with high confidence by the U.S. government
- **Detection**: FireEye discovered the attack while investigating theft of their own red team tools, not through government monitoring systems

## Related concepts
[[Supply Chain Attack]] [[Advanced Persistent Threat (APT)]] [[Code Signing]] [[CI/CD Pipeline Security]] [[Lateral Movement]]