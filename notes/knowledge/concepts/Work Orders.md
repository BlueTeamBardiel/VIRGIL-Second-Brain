# Work Orders

## What it is
Like a mechanic's repair ticket that authorizes someone to pop your hood and work on your engine, a work order is a formal document that authorizes and documents specific maintenance, repair, or change activities within an organization's IT or physical infrastructure. It provides a traceable record of who was authorized to do what, when, and why.

## Why it matters
During a forensic investigation, an attacker posing as an HVAC technician gained physical access to a server room by presenting a forged work order — no one verified it against the ticketing system. A proper work order verification process, tied to an asset management or ITSM system, would have flagged the unauthorized entry and potentially prevented the breach entirely.

## Key facts
- Work orders are a key component of **change management** processes, ensuring all modifications to systems are authorized, tracked, and reversible
- They establish **chain of custody** for physical and logical assets — critical during incident response to distinguish authorized changes from attacker activity
- Work orders should be cross-referenced with the **change advisory board (CAB)** approval before any maintenance begins, especially in regulated environments
- Unverified work orders are a known **social engineering vector** — attackers exploit the assumption that a clipboard and paperwork equal legitimacy (tailgating, physical intrusion)
- In **audits and compliance frameworks** (PCI-DSS, HIPAA, SOC 2), documented work orders serve as evidence that changes followed authorized procedures and were not performed ad hoc

## Related concepts
[[Change Management]] [[Physical Security Controls]] [[Chain of Custody]] [[Social Engineering]] [[Asset Management]]