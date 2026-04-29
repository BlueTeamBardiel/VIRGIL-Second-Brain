# CMDB

## What it is
Think of it as the blueprint archive of a skyscraper — every beam, pipe, and wire catalogued with its exact location and connections. A Configuration Management Database (CMDB) is a centralized repository that stores information about all IT assets (called Configuration Items, or CIs) and, critically, the relationships between them. It tracks hardware, software, network devices, services, and how they depend on each other.

## Why it matters
During a ransomware incident, a CMDB lets a responder instantly answer "what systems talk to this infected server?" — enabling rapid isolation before lateral movement spreads. Without it, responders are flying blind, manually tracing connections while the attacker moves freely. Conversely, attackers who compromise a CMDB gain a precise map of the entire environment, making it a high-value target that requires strict access controls.

## Key facts
- A CMDB is a core component of ITIL (IT Infrastructure Library) and feeds directly into Change Management and Incident Response processes
- Configuration Items (CIs) include hardware, software, documentation, and services — along with their interdependencies and relationships
- An outdated or inaccurate CMDB is often worse than none — it creates false confidence during incident response (called "CMDB drift")
- CMDBs support vulnerability management by allowing security teams to correlate CVEs against specific asset versions across the entire estate
- Under frameworks like NIST CSF, a CMDB directly supports the **Identify** function — specifically asset management (ID.AM)

## Related concepts
[[Asset Inventory]] [[Change Management]] [[Attack Surface Management]] [[Configuration Management]] [[Incident Response]]