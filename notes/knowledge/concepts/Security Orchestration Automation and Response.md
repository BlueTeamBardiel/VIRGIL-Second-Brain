# Security Orchestration Automation and Response

## What it is
Think of SOAR as an air traffic control tower: instead of each controller manually radioing every plane, the system coordinates dozens of aircraft simultaneously using automated protocols, escalating to humans only when judgment is needed. SOAR platforms integrate security tools, automate repetitive response tasks (like blocking IPs or quarantining endpoints), and use playbooks to standardize incident handling across the entire security stack.

## Why it matters
During a phishing campaign targeting 500 employees, a SOC without SOAR might take 45 minutes per ticket just triaging emails manually. With SOAR, an automated playbook extracts URLs, detonates attachments in a sandbox, queries threat intel feeds, and blocks malicious indicators across the firewall and email gateway — all within seconds, before most users even click the link.

## Key facts
- **Playbooks** are the core of SOAR: predefined, automated workflows that dictate exactly how the system responds to specific alert types (e.g., phishing, ransomware, failed logins)
- SOAR reduces **Mean Time to Respond (MTTR)** — a key metric on CySA+ — by eliminating manual, repetitive analyst tasks
- SOAR integrates with SIEM (which detects and alerts) but extends it by taking **action**, not just correlating logs
- Three pillars: **Orchestration** (connecting tools), **Automation** (removing human steps), **Response** (executing containment/remediation)
- Unlike SIEM alone, SOAR can automatically open tickets in ServiceNow, send Slack alerts, revoke user tokens, and update firewall rules — all from a single triggered event

## Related concepts
[[SIEM]] [[Incident Response Playbooks]] [[Threat Intelligence Platforms]] [[SOC Operations]] [[Mean Time to Respond]]