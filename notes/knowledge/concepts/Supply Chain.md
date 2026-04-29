# supply chain

## What it is
Like poisoning a city's water treatment plant instead of individual homes — compromise one upstream source and you infect everyone downstream automatically. A supply chain attack targets the trusted third-party vendors, software libraries, hardware components, or build pipelines that an organization relies on, rather than attacking the organization directly.

## Why it matters
The 2020 SolarWinds attack is the canonical example: attackers inserted malicious code into a software build process, meaning that when SolarWinds pushed a legitimate, signed update to Orion, roughly 18,000 organizations — including US federal agencies — unknowingly installed a backdoor. The attack succeeded precisely *because* the update was trusted and digitally signed, bypassing most perimeter defenses entirely.

## Key facts
- **SolarWinds (SUNBURST)** and **3CX** are the flagship exam examples of software supply chain compromise via build pipeline injection
- **Dependency confusion attacks** exploit how package managers (npm, PyPI) resolve public vs. private package names — attackers upload malicious public packages with the same name as internal private ones
- Supply chain risk management is addressed under **NIST SP 800-161** and is testable on CySA+
- Mitigations include **software bill of materials (SBOM)**, code signing verification, and **vendor risk assessments**
- Hardware supply chain attacks (e.g., counterfeit chips or implanted firmware) are harder to detect and require physical inspection or trusted sourcing programs
- Attackers leverage **trusted relationships** — the victim organization's defenses never trigger because the malicious payload arrives via an already-whitelisted vendor

## Related concepts
[[third-party risk management]] [[code signing]] [[software bill of materials]] [[trusted platform module]] [[zero trust architecture]]