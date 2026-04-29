# IV. Threat Intelligence

## What it is
Like a neighborhood watch that shares specific descriptions of a burglar's methods, tools, and known hideouts — threat intelligence is the collection, analysis, and sharing of evidence-based knowledge about adversaries, including their tactics, motivations, indicators of compromise (IoCs), and capabilities. It transforms raw security data into *actionable* information that drives defensive decisions.

## Why it matters
In 2020, the SolarWinds supply chain attack went undetected for months partly because defenders lacked threat intelligence about the specific TTPs (Tactics, Techniques, and Procedures) used by the APT29 group. Organizations subscribed to threat intelligence feeds sharing APT29 IoCs — like specific malicious DLL signatures and C2 domain patterns — were able to detect and contain the breach significantly faster than those operating blind.

## Key facts
- **Intelligence types by source**: OSINT (open-source), HUMINT (human), SIGINT (signals), and TECHINT (technical) — Security+ focuses heavily on OSINT and TECHINT
- **Intelligence confidence levels** range from confirmed to unconfirmed; acting on low-confidence intel can cause false positives and alert fatigue
- **STIX/TAXII** are the standard formats/protocols for structuring and sharing threat intelligence between organizations
- **ISACs (Information Sharing and Analysis Centers)** are sector-specific groups (e.g., FS-ISAC for finance) that distribute vetted threat intelligence to member organizations
- **Intelligence lifecycle**: Direction → Collection → Processing → Analysis → Dissemination → Feedback — disrupting any phase degrades the output

## Related concepts
[[Indicators of Compromise (IoCs)]] [[MITRE ATT&CK Framework]] [[STIX/TAXII]] [[APT Groups]] [[Threat Hunting]]