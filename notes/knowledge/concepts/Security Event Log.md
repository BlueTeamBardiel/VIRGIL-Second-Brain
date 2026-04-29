# Security Event Log

## What it is
Think of it as a ship's captain's log — every notable event gets timestamped and recorded, so if something goes wrong, you can reconstruct exactly what happened and when. A Security Event Log is a structured, timestamped record of security-relevant activities on a system, application, or network device, capturing events like login attempts, privilege escalations, file access, and policy changes.

## Why it matters
During the 2020 SolarWinds breach, attackers operated undetected for months partly because defenders weren't aggregating and analyzing logs across systems — the evidence existed but nobody was reading it. Proper security event logging, centralized in a SIEM, would have surfaced anomalous lateral movement patterns far earlier, potentially limiting the blast radius of the compromise.

## Key facts
- Windows Security Event Log stores events in `.evtx` format; **Event ID 4624** = successful logon, **4625** = failed logon, **4688** = process creation — these are critical for forensic triage
- Log integrity matters: attackers routinely clear logs (Windows Event ID **1102** indicates the Security log was cleared — itself a red flag)
- Logs must address the **W5**: Who, What, When, Where, and the outcome (success/failure) of each event
- Retention periods are often compliance-driven: PCI-DSS requires **12 months** of log retention with 3 months immediately available
- Log forwarding to a centralized, write-protected repository (SIEM or syslog server) prevents local tampering and enables correlation across systems

## Related concepts
[[SIEM]] [[Log Management]] [[Audit Policy]] [[Windows Event IDs]] [[Chain of Custody]]