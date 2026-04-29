# Third-party Risk

## What it is
Like a restaurant that sources ingredients from dozens of farms — if one farm ships contaminated lettuce, every diner gets sick regardless of how clean the kitchen is. Third-party risk is the exposure an organization inherits from vendors, suppliers, contractors, or partners who have access to its systems, data, or infrastructure, where a failure in that external entity directly compromises the primary organization.

## Why it matters
The 2020 SolarWinds attack is the defining example: attackers compromised SolarWinds' build pipeline and pushed a malicious update (SUNBURST) to ~18,000 customers, including U.S. federal agencies. The victims had done nothing wrong internally — their trusted software vendor was the vector. This demonstrated that your security posture is only as strong as the weakest link in your supply chain.

## Key facts
- **Vendor due diligence** requires assessing third-party security controls before onboarding — tools include security questionnaires, SOC 2 reports, and right-to-audit clauses in contracts
- **Fourth-party risk** extends this further: the vendors *of your vendors* can also introduce exposure (e.g., a subcontractor handling your cloud provider's physical security)
- **Principle of least privilege** must apply to third-party access — vendors should receive only the minimum permissions required, scoped to specific systems and time windows
- **MSSPs (Managed Security Service Providers)** are a common third-party relationship that, if compromised, give attackers elevated, trusted access across multiple client environments simultaneously
- For Security+/CySA+: third-party risk management falls under **supply chain risk management (SCRM)** and is evaluated through **vendor risk assessments**, **data processing agreements (DPAs)**, and ongoing **continuous monitoring**

## Related concepts
[[Supply Chain Attack]] [[Vendor Management]] [[Due Diligence]] [[Principle of Least Privilege]] [[SOC 2 Compliance]]