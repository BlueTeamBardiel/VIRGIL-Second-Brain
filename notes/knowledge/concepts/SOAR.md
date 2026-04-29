# SOAR

## What it is
Think of SOAR as the pit crew at a Formula 1 race — the moment a car pulls in, every technician fires into action simultaneously with a pre-rehearsed role, cutting a 4-second tire change with zero deliberation. Security Orchestration, Automation, and Response (SOAR) platforms connect disparate security tools, automate repetitive analyst tasks, and execute predefined response playbooks when threats are detected. It collapses the time between alert and action from hours to seconds.

## Why it matters
During a phishing campaign targeting a financial firm, thousands of malicious emails may hit inboxes within minutes. A SOAR platform automatically ingests alerts from the email gateway, queries a threat intelligence feed to confirm malicious URLs, isolates affected endpoints via EDR integration, and blocks sender domains in the firewall — all before a human analyst finishes their coffee. Without SOAR, that same workflow requires four analysts touching four different consoles.

## Key facts
- SOAR combines three capabilities: **orchestration** (connecting tools via APIs), **automation** (executing tasks without human input), and **response** (taking action based on playbooks)
- **Playbooks** are the core of SOAR — codified, step-by-step response procedures triggered by specific alert conditions (e.g., "if phishing detected → quarantine email → check sender reputation → notify user")
- SOAR reduces **Mean Time to Respond (MTTR)**, a key SOC metric tracked on CySA+ exams
- Unlike a SIEM (which aggregates and correlates logs), SOAR **acts** — SIEM detects, SOAR responds; they are complementary, not interchangeable
- SOAR platforms (e.g., Splunk SOAR, Palo Alto XSOAR) integrate with ticketing systems like ServiceNow to maintain **audit trails** for compliance

## Related concepts
[[SIEM]] [[Incident Response]] [[Threat Intelligence]] [[EDR]] [[Playbook]]