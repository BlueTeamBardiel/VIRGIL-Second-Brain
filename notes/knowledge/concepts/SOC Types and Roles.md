# SOC Types and Roles

## What it is
Think of a SOC like an air traffic control tower — different airports (internal, outsourced, hybrid) have different staffing models, but all exist to keep traffic from crashing. A Security Operations Center (SOC) is a centralized team and facility responsible for continuously monitoring, detecting, analyzing, and responding to cybersecurity threats. SOC models vary by ownership, staffing, and operational scope.

## Why it matters
During the 2020 SolarWinds supply chain attack, organizations with mature in-house SOCs detected anomalous SAML token behavior weeks earlier than those relying solely on outsourced providers — because internal analysts had deeper context about their own environment. SOC structure directly determines detection speed and response authority, which translates to dwell time reduction.

## Key facts
- **SOC Types:** Internal (dedicated in-house team), Outsourced/MSSP (Managed Security Service Provider handles monitoring), Co-managed/Hybrid (shared responsibilities between in-house and MSSP), and Command SOC (coordinates multiple SOCs across an enterprise)
- **Tier 1 Analyst:** Monitors alerts, performs triage, escalates incidents — the first responder filtering noise from the SIEM
- **Tier 2 Analyst:** Performs deeper investigation, threat hunting, and incident containment; owns confirmed incidents
- **Tier 3 Analyst/Threat Hunter:** Proactively hunts for hidden threats using TTPs; often develops detection rules and conducts malware analysis
- **SOC Manager:** Oversees operations, metrics, staffing, and communicates with leadership; accountable for SLAs (Mean Time to Detect/Respond — MTTD/MTTR)
- On CySA+ and Security+, understand that **MSSPs trade customization for cost savings**, while internal SOCs offer better contextual awareness but require higher investment

## Related concepts
[[SIEM]] [[Incident Response Lifecycle]] [[Threat Hunting]] [[MSSP]] [[Tiered Escalation Model]]