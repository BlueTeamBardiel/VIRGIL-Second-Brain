# threat modeling

## What it is
Like an architect who sketches a building's floor plan specifically to identify every door, window, and vent a burglar might exploit — *before* pouring the foundation — threat modeling is the structured process of identifying, enumerating, and prioritizing potential threats against a system before (or during) its development. It answers four core questions: What are we building? What can go wrong? What will we do about it? Did we do a good enough job?

## Why it matters
In 2017, Equifax's breach exposed 147 million records partly because no formal threat model had flagged their Apache Struts web-facing application as a high-value attack surface requiring aggressive patching. A proper threat model would have mapped that component as a critical trust boundary, triggering mandatory patch SLAs and potentially preventing the entire incident.

## Key facts
- **STRIDE** is the dominant threat modeling framework: Spoofing, Tampering, Repudiation, Information Disclosure, Denial of Service, Elevation of Privilege — each maps to a violated security property
- **PASTA** (Process for Attack Simulation and Threat Analysis) is a risk-centric, 7-stage alternative favored in enterprise environments and appears on CySA+ objectives
- **Data Flow Diagrams (DFDs)** are the primary artifact — they visualize trust boundaries, which are the key locations where threats materialize
- **DREAD** (Damage, Reproducibility, Exploitability, Affected users, Discoverability) provides a numeric scoring model for threat prioritization, though it has largely been deprecated by Microsoft in favor of qualitative ranking
- Threat modeling is explicitly required by **NIST SP 800-154** and is a core activity in the **Secure Development Lifecycle (SDL)**

## Related concepts
[[STRIDE]] [[attack surface]] [[data flow diagram]] [[trust boundary]] [[risk assessment]]