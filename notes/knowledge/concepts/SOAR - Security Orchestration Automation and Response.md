# SOAR - Security Orchestration Automation and Response

## What it is
Think of SOAR as an air traffic control tower that doesn't just watch planes — it automatically reroutes them, alerts ground crews, and files incident reports simultaneously. Precisely: SOAR is a platform that integrates security tools, automates repetitive response tasks, and orchestrates workflows across multiple systems to reduce the time between detection and containment. It combines three capabilities: orchestration (connecting tools), automation (executing tasks without humans), and response (taking action on threats).

## Why it matters
During a phishing campaign hitting 500 employees simultaneously, a SOAR platform can automatically parse the malicious email, extract IOCs, query threat intelligence feeds, block the sender domain in the email gateway, quarantine affected endpoints, and open a ticketed incident — all within seconds. Without SOAR, an analyst manually triaging each alert would take hours, allowing lateral movement and data exfiltration to occur while they work through the queue.

## Key facts
- SOAR reduces **Mean Time to Respond (MTTR)** by automating tier-1 alert triage, freeing analysts for complex investigations
- **Playbooks** are the core automation mechanism — predefined, conditional workflows that dictate exactly what actions fire in response to specific trigger conditions
- SOAR differs from SIEM: SIEM *detects and logs*; SOAR *acts and orchestrates* — they are commonly integrated, not interchangeable
- Common SOAR integrations include firewalls, EDR platforms, threat intelligence feeds, ticketing systems (e.g., ServiceNow), and identity providers
- Key exam distinction: SOAR addresses **alert fatigue** by automating low-fidelity, high-volume alerts that would otherwise overwhelm SOC analysts

## Related concepts
[[SIEM]] [[Playbooks and Runbooks]] [[Threat Intelligence]] [[Incident Response]] [[EDR]]