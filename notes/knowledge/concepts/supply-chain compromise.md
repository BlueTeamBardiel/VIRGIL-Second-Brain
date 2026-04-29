# supply-chain compromise

## What it is
Imagine poisoning a city's water supply at the reservoir instead of attacking each household individually — you compromise one upstream source and infect everyone downstream automatically. A supply-chain compromise occurs when an attacker infiltrates a trusted third-party vendor, software library, or hardware manufacturer to inject malicious code or components into a product before it reaches the end target, bypassing that target's own defenses entirely.

## Why it matters
In the 2020 SolarWinds attack, threat actors (attributed to Russian SVR) inserted a backdoor called SUNBURST into a legitimate software update for the Orion IT monitoring platform. Because organizations trusted the digitally signed update from a known vendor, roughly 18,000 organizations — including U.S. federal agencies — installed the malware themselves, making traditional perimeter defenses irrelevant.

## Key facts
- Classified under MITRE ATT&CK as **T1195**, with sub-techniques covering software, hardware, and dependency injection
- **Trusted relationships** are the core exploit vector — attackers abuse the implicit trust organizations extend to vendors and update mechanisms
- **Software Bill of Materials (SBOM)** is a key defensive countermeasure; it inventories all components in a software product to detect unauthorized changes
- Code signing alone is insufficient defense if the signing keys or build pipeline itself are compromised, as SolarWinds demonstrated
- The 2021 **Codecov** breach and the **XZ Utils backdoor (2024)** show that even open-source packages and CI/CD pipelines are viable attack surfaces

## Related concepts
[[trusted third-party risk]] [[code signing]] [[SBOM]] [[CI/CD pipeline security]] [[watering hole attack]]