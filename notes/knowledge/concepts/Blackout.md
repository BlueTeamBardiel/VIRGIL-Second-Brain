# Blackout

## What it is
Like cutting the power to a security camera right before a heist, a blackout attack deliberately disables or overwhelms monitoring and logging systems so that subsequent malicious activity goes unrecorded. Precisely, it is an attacker technique where SIEM systems, log aggregators, or detection tools are targeted first to create a blind spot, enabling follow-on attacks to proceed without generating forensic evidence.

## Why it matters
During the 2015 Ukraine power grid attack, adversaries used a variant of this technique — disabling UPS systems and flooding operator phone lines simultaneously with the destructive payload, preventing operators from seeing or responding to the attack in real time. Defenders must treat sudden loss of telemetry or log ingestion failures as a potential attack indicator, not just an infrastructure glitch.

## Key facts
- A blackout attack is often the **first phase** of a multi-stage intrusion, preceding data exfiltration or destructive payloads
- Attackers may trigger blackouts by flooding a SIEM with millions of junk log events (log flooding/fatigue), crashing it under load
- **Detection gap**: if log timestamps show a suspicious silence followed by indicators of compromise, the silence itself is evidence
- Disabling Windows Event Log service (`wevtutil cl`) or `auditd` on Linux are common host-level blackout tactics used post-compromise
- Defense-in-depth requires **out-of-band logging** (e.g., immutable write-once storage, syslog to hardened remote servers) so attackers cannot erase their tracks even with local admin access

## Related concepts
[[Log Tampering]] [[SIEM]] [[Defense Evasion]] [[Anti-Forensics]] [[Indicator of Compromise]]