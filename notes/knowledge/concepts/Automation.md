# Automation

## What it is
Like a factory assembly line that stamps out thousands of identical parts without a human touching each one, automation in cybersecurity means scripting or tooling repetitive tasks so they execute consistently and at machine speed. Precisely: automation is the use of scripts, orchestration platforms, or AI-driven tools to perform security tasks — scanning, alerting, patching, response — with minimal or no human intervention per execution cycle.

## Why it matters
In a SOC handling 10,000 alerts per day, no team can manually triage each one — automation via SOAR (Security Orchestration, Automation, and Response) platforms can correlate alerts, enrich indicators, and isolate infected endpoints in seconds. Without it, the mean time to respond (MTTR) balloons while attackers move laterally undetected. Conversely, attackers use automation too: credential stuffing tools like Sentry MBA fire thousands of login attempts per minute against web applications.

## Key facts
- **SOAR platforms** (e.g., Splunk SOAR, Palo Alto XSOAR) automate playbooks that combine detection, enrichment, and response into a single workflow
- Automation reduces **mean time to detect (MTTD)** and **mean time to respond (MTTR)** — key metrics tested on CySA+
- **Scripting languages** most relevant to security automation: Python, PowerShell, and Bash — each maps to different OS environments
- Automated vulnerability scanning (e.g., Nessus, OpenVAS) must be scheduled carefully; unauthenticated scans can crash fragile OT/ICS systems
- **CI/CD pipeline security automation** (DevSecOps) integrates SAST/DAST tools automatically on every code commit, catching flaws before production

## Related concepts
[[SOAR]] [[Threat Intelligence]] [[Vulnerability Scanning]] [[DevSecOps]] [[Incident Response]]