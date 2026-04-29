# Autodesk Fusion

## What it is
Think of it as a Swiss Army knife bolted to a cloud server — a single platform that combines CAD, CAM, CAE, and PCB design so engineers never need to juggle separate tools. Autodesk Fusion (formerly Fusion 360) is a cloud-connected product lifecycle design suite used by engineers and manufacturers to design, simulate, and fabricate physical products, from consumer electronics to aerospace components. Its cloud backbone means design files, collaboration, and compute tasks live in Autodesk's infrastructure rather than solely on local machines.

## Why it matters
Fusion's cloud-sync model makes it an attractive target for industrial espionage — a threat actor who compromises an engineer's Autodesk credentials gains access to proprietary CAD files representing millions in R&D, blueprints for critical components, or even defense-adjacent hardware designs. In 2021, spear-phishing campaigns specifically targeted manufacturing sector employees using Fusion 360 credentials as the prize, demonstrating that design software accounts are now high-value targets comparable to financial credentials. Defenders must treat Fusion accounts under the same privileged-access policies as ERP or source-code repositories.

## Key facts
- Fusion stores project files in **Autodesk's cloud (ACC — Autodesk Construction Cloud)**, meaning data exfiltration risk extends beyond the local endpoint
- Credentials are managed through **Autodesk Identity (SSO)**, making MFA enforcement critical — a single password compromise exposes all linked design assets
- Fusion supports **third-party add-ins and scripts**, creating a supply chain risk vector analogous to IDE plugins or browser extensions
- Export controls (ITAR/EAR) can apply to Fusion-hosted designs involving defense components — improper cloud sharing is a compliance violation, not just a security incident
- Lateral movement from a Fusion account can pivot to **connected manufacturing equipment** (CNC machines, 3D printers) via CAM toolpath injection

## Related concepts
[[Supply Chain Attacks]] [[Credential Theft]] [[Data Loss Prevention]]