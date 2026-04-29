# NIST Incident Response

## What it is
Think of it as a hospital trauma protocol — when a patient arrives, staff don't improvise; they follow a practiced sequence: triage, stabilize, treat, discharge, and debrief. NIST SP 800-61 defines a structured four-phase lifecycle for handling cybersecurity incidents: Preparation, Detection & Analysis, Containment/Eradication/Recovery, and Post-Incident Activity. It gives organizations a repeatable playbook so responders act decisively instead of panicking under fire.

## Why it matters
During the 2017 NotPetya attack, organizations without a structured IR plan watched ransomware propagate laterally for hours before anyone had authority to isolate systems. Companies following NIST's containment guidance — isolating affected segments immediately while preserving forensic evidence — limited blast radius and recovered faster. The difference between a $10M loss and a $300M loss was largely procedural discipline.

## Key facts
- **Four phases in order:** Preparation → Detection & Analysis → Containment, Eradication & Recovery → Post-Incident Activity (lessons learned)
- **Post-Incident Activity** produces the "lessons learned" report within a recommended timeframe; NIST suggests meetings should occur within a week of resolution
- **Evidence preservation** is emphasized during Detection & Analysis — log collection, chain of custody, and timestamps must be maintained before containment actions alter the environment
- **Containment strategies** are categorized: short-term (isolate now), long-term (patch/rebuild), and evidence preservation must guide which comes first
- **NIST SP 800-61 Rev. 2** is the governing document; Security+/CySA+ exams frequently test phase order and the fact that "preparation" is considered the most critical phase

## Related concepts
[[Incident Response Plan]] [[Chain of Custody]] [[SANS Incident Response]] [[Security Playbooks]] [[Log Analysis]]