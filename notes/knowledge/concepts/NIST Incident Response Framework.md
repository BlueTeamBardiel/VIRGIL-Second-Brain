# NIST Incident Response Framework

## What it is
Like a hospital trauma team that follows a strict protocol — triage, stabilize, treat, discharge, debrief — regardless of what injury walks through the door, the NIST IR framework gives security teams a repeatable, structured playbook for handling incidents. Defined in NIST SP 800-61r2, it breaks incident response into four ordered phases: **Preparation, Detection & Analysis, Containment/Eradication/Recovery, and Post-Incident Activity**.

## Why it matters
During the 2020 SolarWinds supply chain attack, organizations without a defined IR framework scrambled to identify scope, assign roles, and coordinate response — losing critical days while attackers persisted in their environments. Organizations following NIST SP 800-61r2 had predefined escalation paths, evidence preservation procedures, and communication trees already in place, allowing faster containment of the backdoor.

## Key facts
- **Four phases**: Preparation → Detection & Analysis → Containment, Eradication & Recovery → Post-Incident Activity (lessons learned)
- The **lessons learned meeting** should occur within 2 weeks of incident closure and produce a formal report — this is explicitly tested on CySA+
- NIST distinguishes between an **event** (any observable occurrence) and an **incident** (an event that negatively affects CIA of systems)
- **Containment strategies** vary by incident type — short-term containment stops bleeding, long-term containment maintains business operations while eradication is prepared
- NIST SP 800-61r2 recommends maintaining an **incident response plan, policy, and playbooks** as three distinct, separate documents

## Related concepts
[[Incident Response Plan]] [[SANS PICERL Model]] [[Chain of Custody]] [[Indicators of Compromise]] [[Lessons Learned]]