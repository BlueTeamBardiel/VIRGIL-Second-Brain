# NIST Incident Response Lifecycle

## What it is
Like a hospital's trauma protocol — triage, treat, stabilize, then review the case to improve next time — the NIST IR Lifecycle is a structured, repeatable framework for handling security incidents. Defined in NIST SP 800-61r2, it organizes incident response into four sequential phases: **Preparation → Detection & Analysis → Containment, Eradication & Recovery → Post-Incident Activity**.

## Why it matters
During the 2020 SolarWinds supply chain attack, organizations *without* a mature IR lifecycle had no systematic way to determine scope, prioritize affected systems, or coordinate eradication across thousands of compromised hosts. Those following NIST 800-61r2 could invoke pre-built playbooks, isolate affected Orion servers methodically, and conduct structured lessons-learned sessions — turning a potential catastrophe into a documented, recoverable event.

## Key facts
- **Four phases** (not five or six): Preparation; Detection & Analysis; Containment, Eradication & Recovery; Post-Incident Activity — memorize this exact sequence for CySA+
- **Preparation** is the *only* phase that occurs before an incident; it includes building IR plans, training teams, and deploying detection tools
- **Containment strategies** are split into *short-term* (isolate now) and *long-term* (patch/rebuild sustainably) — the exam distinguishes these
- **Post-Incident Activity** (lessons learned) must occur within **two weeks** of the incident per NIST guidance; the output is a formal lessons-learned report
- The lifecycle is **cyclical, not linear** — lessons learned feed directly back into improving Preparation for the next incident

## Related concepts
[[Incident Response Plan]] [[Lessons Learned Report]] [[NIST SP 800-61]] [[Containment Strategies]] [[Indicators of Compromise]]