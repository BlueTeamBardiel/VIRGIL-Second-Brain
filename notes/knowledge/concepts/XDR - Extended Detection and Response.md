# XDR - Extended Detection and Response

## What it is
Think of XDR as a hospital's central monitoring station that simultaneously reads vitals from every patient ward, lab, and ICU — rather than having separate nurses watching isolated rooms. XDR is a unified security platform that ingests and correlates telemetry across endpoints, networks, cloud workloads, email, and identity systems to detect and respond to threats holistically. Unlike siloed tools, XDR breaks down data barriers so that a suspicious login, a lateral movement attempt, and a C2 beacon appear as one connected attack story.

## Why it matters
In the 2020 SolarWinds supply chain attack, defenders using isolated EDR tools saw individual anomalies — odd process launches, unusual outbound traffic — but failed to correlate them into a coherent intrusion narrative across environments. An XDR platform correlating endpoint telemetry with network flows and cloud API logs could have surfaced the full attack chain earlier, significantly compressing dwell time from months to days.

## Key facts
- XDR is the evolution of EDR: **EDR** covers endpoints only, **NDR** covers networks only, **XDR** unifies both plus cloud, email, and identity into one detection engine
- XDR reduces **Mean Time to Detect (MTTD)** and **Mean Time to Respond (MTTR)** by eliminating manual correlation across separate consoles
- Vendors offer **Native XDR** (single-vendor integrated stack) vs. **Open/Hybrid XDR** (third-party integrations via APIs) — a common exam distinction
- XDR typically includes **automated response playbooks**, enabling containment actions (host isolation, blocking IOCs) without human intervention
- Distinct from **SIEM**: SIEM aggregates logs for compliance and alerting; XDR focuses on active detection, investigation, and response with built-in context

## Related concepts
[[EDR - Endpoint Detection and Response]] [[SIEM - Security Information and Event Management]] [[SOAR - Security Orchestration Automation and Response]] [[NDR - Network Detection and Response]] [[Threat Hunting]]