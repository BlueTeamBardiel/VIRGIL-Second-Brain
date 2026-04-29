# FedRAMP

## What it is
Think of FedRAMP as the TSA pre-check for cloud vendors wanting to do business with the U.S. government — pass the screening once, fly through every agency's door. Formally, FedRAMP (Federal Risk and Authorization Management Program) is a standardized security authorization framework that cloud service providers (CSPs) must satisfy before federal agencies can procure their services. It enforces NIST SP 800-53 controls and creates a "authorize once, use many" model to eliminate redundant agency-by-agency assessments.

## Why it matters
In 2020, the SolarWinds supply chain attack compromised federal networks partly because third-party software and cloud integrations lacked consistent vetting. FedRAMP directly addresses this by requiring CSPs to undergo rigorous third-party assessment organization (3PAO) audits before handling federal data, meaning a compromised vendor without FedRAMP authorization should never have reached production government systems in the first place.

## Key facts
- **Three impact levels:** Low, Moderate, and High — based on the potential damage if CIA (confidentiality, integrity, availability) is compromised; most federal workloads require Moderate.
- **Two authorization paths:** Agency ATO (Authorization to Operate) sponsored by a specific agency, or JAB (Joint Authorization Board) P-ATO sponsored by DoD, DHS, and GSA — the harder, more prestigious route.
- **Control baseline:** Built on NIST SP 800-53 Rev 5; Moderate baseline requires approximately 325 controls.
- **Continuous monitoring (ConMon):** Authorized CSPs must submit monthly vulnerability scans and annual penetration test results — authorization is never "set and forget."
- **FedRAMP Marketplace:** A public catalog where agencies can verify a CSP's authorization status before procurement — a critical due-diligence step.

## Related concepts
[[NIST SP 800-53]] [[Authority to Operate (ATO)]] [[Cloud Security Alliance (CSA)]] [[Third-Party Risk Management]] [[Supply Chain Risk Management]]