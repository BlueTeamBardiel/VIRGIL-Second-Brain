# Data Processor

## What it is
Like a factory that doesn't own the raw materials but shapes them into finished goods on behalf of a client, a data processor handles personal data on behalf of — and under the instructions of — a data controller. Under GDPR and similar privacy frameworks, a data processor is any entity that processes personal data on behalf of the controller but does not determine the purpose or means of that processing.

## Why it matters
In the 2020 SolarWinds supply chain attack, SolarWinds functioned as a data processor for thousands of organizations — holding privileged access to customer environments. When attackers compromised SolarWinds' build pipeline, they exploited the trusted processor relationship to pivot into controller environments, demonstrating why processor security posture directly impacts controller liability and data exposure.

## Key facts
- Under GDPR Article 28, controllers **must** use only processors that provide "sufficient guarantees" of compliance — making vendor due diligence a legal requirement, not just best practice
- Data processors **cannot** subcontract to another processor (sub-processor) without explicit prior written authorization from the controller
- If a processor acts outside controller instructions and determines processing purposes themselves, they become a **co-controller** with full legal liability
- A Data Processing Agreement (DPA) is mandatory between controller and processor, specifying scope, duration, nature, and purpose of processing
- Processors are directly liable for GDPR violations in their own domain — not just the controller — making processors independently auditable and fineable

## Related concepts
[[Data Controller]] [[GDPR Compliance]] [[Supply Chain Security]] [[Third-Party Risk Management]] [[Data Processing Agreement]]