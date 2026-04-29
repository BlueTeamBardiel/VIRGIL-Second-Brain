# Autonomous Cyber Defense

## What it is
Like a building's sprinkler system that doesn't wait for a firefighter to detect smoke and act, autonomous cyber defense refers to security systems that detect, analyze, and respond to threats *without human intervention*. Precisely: it is the use of AI/ML-driven tooling and orchestrated playbooks to identify malicious activity and execute countermeasures — blocking IPs, isolating hosts, revoking credentials — in real time, faster than any human SOC analyst could respond.

## Why it matters
During the 2021 Colonial Pipeline ransomware attack, the company shut down operations manually after detection — a slow, costly decision. An autonomous defense system running behavioral analytics could have detected the lateral movement of the BlackMatter ransomware in its early stages and auto-isolated the affected OT network segment *before* operators had to pull the plug on 45% of the U.S. East Coast's fuel supply, potentially containing the breach in minutes rather than hours.

## Key facts
- **SOAR platforms** (Security Orchestration, Automation, and Response) are the primary implementation vehicle for autonomous defense, executing pre-built playbooks triggered by SIEM alerts
- **MTTR (Mean Time to Respond)** is the key metric improved by autonomous defense — industry benchmarks show automation can reduce MTTR from hours to under 60 seconds
- **Deception technology** (honeypots, honeytokens) can feed autonomous systems with high-fidelity threat intel to trigger automated containment without false-positive risk
- **Zero-trust architecture** is a prerequisite — autonomous systems require granular, enforceable policy controls to act on (e.g., micro-segmentation, just-in-time access)
- **Human-on-the-loop** vs. **human-in-the-loop** is a critical distinction: autonomous defense assumes the former — humans review decisions *after* action, not before

## Related concepts
[[SOAR]] [[Threat Intelligence]] [[Zero Trust Architecture]]