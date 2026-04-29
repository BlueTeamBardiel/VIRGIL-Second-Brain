# Threat Automation

## What it is
Like a robotic assembly line that stamps out thousands of identical car parts per hour, threat automation is the use of scripts, tools, and frameworks to execute attacks — or defenses — at machine speed and scale. Precisely defined: threat automation refers to the programmatic orchestration of attack techniques (reconnaissance, exploitation, lateral movement, exfiltration) or defensive countermeasures without requiring manual human intervention at each step.

## Why it matters
In 2021, the Conti ransomware group used automated lateral movement scripts to traverse networks and deploy encryption payloads across hundreds of endpoints within hours of initial access — far faster than any human analyst could detect and respond manually. This speed asymmetry is the core danger: attackers automate offense while defenders still rely on manual triage, creating a response gap measured in damage.

## Key facts
- **Metasploit** and **Cobalt Strike** are industry-standard frameworks that automate exploitation, post-exploitation, and C2 communication in both red team and real adversary operations
- **SOAR (Security Orchestration, Automation, and Response)** platforms like Splunk SOAR and Palo Alto XSOAR automate defensive responses — isolating hosts, blocking IPs, creating tickets — in response to triggered alerts
- Automated attack tools enable **credential stuffing** at scale: tools like Sentry MBA can test millions of username/password combinations against login portals using leaked credential databases
- The **MITRE ATT&CK framework** catalogs automated adversary behaviors under specific technique IDs (e.g., T1059 for scripted command execution), enabling defenders to build automated detection rules mapped to real TTPs
- **Playbooks** are the defensive equivalent of attack scripts — documented, automated workflows executed by SOAR tools that reduce Mean Time to Respond (MTTR)

## Related concepts
[[SOAR]] [[Metasploit Framework]] [[MITRE ATT&CK]] [[Credential Stuffing]] [[Lateral Movement]]