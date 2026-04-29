# SolarWinds Orion Incident

## What it is
Imagine a trusted locksmith secretly copying every key they cut for you — that's what happened here. In 2020, nation-state attackers (APT29/Cozy Bear) compromised SolarWinds' build pipeline and injected malicious code into legitimate software updates for Orion, an IT monitoring platform, turning the update itself into a delivery vehicle for the SUNBURST backdoor.

## Why it matters
Because Orion had privileged access to monitor networks, the backdoor inherited those same rights — giving attackers silent visibility into victim environments for months. Roughly 18,000 organizations downloaded the trojanized update, including the U.S. Treasury, DHS, and FireEye, before detection in December 2020. Defenders learned that monitoring *outbound* traffic from trusted management tools is just as critical as monitoring inbound threats.

## Key facts
- **Supply chain attack**: Malicious code was injected into `SolarWinds.Orion.Core.BusinessLayer.dll` during the CI/CD build process — the signed binary appeared fully legitimate
- **SUNBURST backdoor** lay dormant for ~12–14 days after installation to evade sandbox detection, then communicated via DNS beaconing to C2 infrastructure
- **Detection origin**: FireEye discovered the breach while investigating the theft of their own red team tools
- **Scope**: ~18,000 direct victims; roughly 100 organizations experienced active follow-on intrusion including TEARDROP and Cobalt Strike deployment
- **Attribution**: U.S. intelligence attributed the attack to SVR (Russian Foreign Intelligence Service); classified as an espionage operation, not destructive attack

## Related concepts
[[Supply Chain Attack]] [[CI/CD Pipeline Security]] [[APT (Advanced Persistent Threat)]] [[DNS Beaconing]] [[Backdoor]]