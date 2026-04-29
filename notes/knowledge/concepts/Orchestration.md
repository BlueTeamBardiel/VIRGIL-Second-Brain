# Orchestration

## What it is
Like a conductor who never touches an instrument but coordinates 80 musicians into a symphony, orchestration is the automated coordination of multiple security tools and processes to execute complex workflows without manual intervention. It sits one layer above automation — not just repeating tasks, but making decisions and sequencing actions across disparate systems.

## Why it matters
During a ransomware incident, a SOAR (Security Orchestration, Automation, and Response) platform can simultaneously query the SIEM for related IOCs, pull threat intelligence from VirusTotal, isolate the infected endpoint via EDR, block the C2 IP at the firewall, and open a ticket in ServiceNow — all within seconds of initial detection. Without orchestration, this same response chain requires 4-6 analysts working in parallel and takes 30+ minutes, during which lateral movement continues.

## Key facts
- **SOAR platforms** (e.g., Splunk SOAR, Palo Alto XSOAR) are the primary orchestration tools in SOC environments and are explicitly tested on CySA+
- Orchestration relies on **playbooks** — predefined logic trees that determine conditional responses (if/then branching across tools)
- **APIs** are the connective tissue of orchestration; if a tool lacks API support, it typically cannot be orchestrated
- Orchestration reduces **Mean Time to Respond (MTTR)**, a key SOC metric measuring incident response efficiency
- Poorly designed orchestration can cause **automated over-blocking** — legitimate users getting isolated or locked out due to false-positive triggers in a playbook

## Related concepts
[[SOAR]] [[Security Automation]] [[Incident Response Playbooks]] [[SIEM]] [[Mean Time to Respond]]