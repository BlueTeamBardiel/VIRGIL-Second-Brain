# Malicious update

## What it is
Like a pharmacist secretly swapping your heart medication with poison while keeping the original label, a malicious update delivers harmful code disguised as a legitimate software patch or upgrade. Precisely, it is an attack vector where adversaries compromise the software update mechanism — either by poisoning the update server, hijacking the delivery channel, or signing packages with stolen certificates — to push malware to trusting endpoints at scale.

## Why it matters
The 2020 SolarWinds SUNBURST attack is the canonical example: attackers infiltrated SolarWinds' build pipeline and inserted a backdoor into the Orion software update, which was then cryptographically signed and distributed to approximately 18,000 organizations, including U.S. federal agencies. Because the update came from a trusted vendor with a valid certificate, traditional perimeter defenses were completely blind to it.

## Key facts
- Malicious updates exploit **implicit trust** — endpoints automatically accept signed packages from known vendors without inspecting payload behavior
- Attackers target the **supply chain / build pipeline** rather than end targets directly, achieving massive lateral reach with a single compromise
- **Code signing certificates** are a prime target; a stolen or fraudulently issued certificate makes malicious packages nearly indistinguishable from legitimate ones
- Defenses include **binary transparency logs**, **software bill of materials (SBOM)**, and **reproducible builds** to verify update integrity independently of the vendor
- Classified under **MITRE ATT&CK T1195.002** (Supply Chain Compromise: Compromise Software Supply Chain) and **T1072** (Software Deployment Tools)

## Related concepts
[[Supply Chain Attack]] [[Code Signing]] [[Integrity Verification]] [[MITRE ATT&CK]] [[Man-in-the-Middle Attack]]