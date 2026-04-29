# Third-Party Integration

## What it is
Like hiring a contractor who gets a master key to your building — convenient, but now your security depends on their habits too. Third-party integration is the practice of connecting external software, APIs, or services into your environment, granting them access to data, systems, or infrastructure to extend functionality.

## Why it matters
The 2020 SolarWinds attack is the textbook case: attackers compromised SolarWinds' build pipeline and pushed a trojanized update (SUNBURST) to ~18,000 organizations that trusted the vendor's software. Because the malicious code arrived through a legitimate, signed update from a trusted third party, traditional perimeter defenses were completely blind to it.

## Key facts
- **Supply chain attacks** target the weakest link in a vendor ecosystem — often a smaller third-party with access to larger targets' environments
- **Vendor risk assessments** (questionnaires, SOC 2 reports, penetration test results) are the primary governance controls before onboarding a third party
- **Principle of Least Privilege** must apply to third-party API keys and service accounts — scope their permissions to only what they require, nothing more
- **Fourth-party risk** exists when your vendor's vendors introduce vulnerabilities — your risk doesn't stop at one hop
- Security+ and CySA+ test on **right-to-audit clauses** in contracts as a key contractual control ensuring vendors can be independently assessed

## Related concepts
[[Supply Chain Attack]] [[API Security]] [[Vendor Risk Management]]