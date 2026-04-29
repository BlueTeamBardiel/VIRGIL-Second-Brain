# SLA

## What it is
Like a restaurant promising your pizza in 30 minutes or it's free, an SLA (Service Level Agreement) is a formal contract between a service provider and customer that defines measurable performance commitments — uptime percentages, response times, and breach penalties. It is a legally binding document specifying exactly what level of service is guaranteed, how it will be measured, and what remedies apply when those guarantees are missed.

## Why it matters
During a ransomware incident, an organization discovers their cloud backup provider's SLA promised 99.9% uptime but contained no guaranteed **recovery time objective (RTO)**. When restoration took 72 hours instead of the expected 4, the business suffered catastrophic losses — yet had no contractual recourse because recovery speed was never explicitly defined in the SLA. This scenario illustrates why security teams must scrutinize SLA language during vendor risk assessments, not after a crisis.

## Key facts
- **Uptime SLAs** are often expressed as "nines": 99.9% = ~8.7 hours downtime/year; 99.99% = ~52 minutes/year
- SLAs must explicitly address **RTO** (how fast systems recover) and **RPO** (maximum acceptable data loss) to be useful for incident response planning
- **Penalty clauses** (service credits) in SLAs rarely cover actual business losses — they typically only refund a percentage of monthly fees
- During **third-party risk assessments**, auditors evaluate SLAs to determine if vendor commitments align with the organization's own availability requirements
- SLAs are distinct from **MOUs** (Memoranda of Understanding) and **OLAs** (Operational Level Agreements) — SLAs are external/contractual, OLAs are internal

## Related concepts
[[Business Continuity Planning]] [[Recovery Time Objective]] [[Third-Party Risk Management]] [[Availability]] [[Vendor Management]]