# Supply Chain Attacks

## What it is
Imagine poisoning a town's water supply at the reservoir instead of attacking each house individually — you compromise one upstream source and infect everyone downstream automatically. A supply chain attack targets a trusted vendor, software library, or hardware manufacturer *before* the product reaches the end organization, weaponizing the trust relationship between supplier and customer to bypass traditional perimeter defenses.

## Why it matters
In 2020, attackers compromised SolarWinds' build pipeline and injected malicious code into the Orion software update, which was then digitally signed and distributed to roughly 18,000 organizations — including US government agencies — who installed it willingly because it appeared legitimate. Defenders now use software composition analysis (SCA), software bills of materials (SBOMs), and strict vendor risk management programs to verify the integrity of third-party components before deployment.

## Key facts
- **SolarWinds (2020)** and **3CX (2023)** are canonical supply chain examples referenced on Security+/CySA+ exams; know them by name
- Attackers target the **build/CI-CD pipeline**, code repositories, or update mechanisms — not the final product directly
- **Code signing** is a mitigation, but only if the signing key itself is uncompromised (SolarWinds' signed malware proves signing alone is insufficient)
- **SBOM (Software Bill of Materials)** is a key defensive countermeasure — it catalogs every component in software so organizations can identify vulnerable dependencies quickly
- The **NIST SP 800-161** framework specifically addresses Cyber Supply Chain Risk Management (C-SCRM) for federal agencies
- Hardware supply chain attacks (e.g., counterfeit Cisco equipment, implanted chips) target physical components and are significantly harder to detect than software-based attacks

## Related concepts
[[Code Signing]] [[Software Composition Analysis]] [[Third-Party Risk Management]] [[Zero Trust Architecture]] [[CI/CD Pipeline Security]]