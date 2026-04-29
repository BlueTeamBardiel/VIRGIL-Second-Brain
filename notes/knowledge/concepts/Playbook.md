# Playbook

## What it is
Like a football coach's laminated call sheet that tells every player exactly what to do on a third-and-long, a security playbook is a predefined, step-by-step procedure that tells analysts exactly how to respond to a specific type of security event. It removes guesswork under pressure by codifying the "what, who, and when" for scenarios like ransomware infections, phishing alerts, or DDoS attacks.

## Why it matters
During the 2021 Colonial Pipeline ransomware attack, the absence of a mature incident response playbook contributed to a reactive, disorganized shutdown that halted fuel delivery across the U.S. East Coast for days. A well-tested ransomware playbook would have defined immediate isolation steps, communication chains, and recovery priorities — potentially cutting response time from days to hours.

## Key facts
- Playbooks are scenario-specific; an organization maintains multiple playbooks (e.g., one for phishing, one for insider threat, one for ransomware) rather than a single generic document
- They are a core component of Security Orchestration, Automation, and Response (**SOAR**) platforms, where playbooks can be automated as workflows triggered by SIEM alerts
- A playbook differs from a **runbook**: runbooks are operational procedures for routine tasks, while playbooks are specifically for incident response decisions
- Playbooks must define **escalation criteria** — the conditions under which an analyst escalates from Tier 1 to Tier 2 or notifies legal/executive leadership
- CySA+ expects candidates to know that playbooks should be reviewed and updated after every major incident or tabletop exercise to close gaps

## Related concepts
[[Incident Response Plan]] [[SOAR]] [[SIEM]] [[Runbook]] [[Tabletop Exercise]]