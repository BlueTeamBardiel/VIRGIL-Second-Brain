# Manual Updates

## What it is
Like a mechanic who only fixes your car when you physically bring it in — rather than automatically scheduling service — manual updates require a human to deliberately initiate the patching process. Precisely: manual updates are a patch management approach where administrators or end users must explicitly download and apply software updates, firmware, or security patches without automated scheduling or deployment. No action = no update.

## Why it matters
In 2017, the WannaCry ransomware exploited MS17-010, a Windows vulnerability for which Microsoft had already released patch MS17-010 two months earlier — but organizations relying on manual update processes simply never applied it. Hundreds of thousands of machines across 150 countries were compromised specifically because the human-driven update workflow broke down. Manual updates create a direct, measurable gap between patch availability and patch deployment.

## Key facts
- Manual updates introduce **patch latency** — the dangerous window between vulnerability disclosure (or patch release) and actual remediation, which attackers actively target
- In regulated environments (ICS/SCADA, medical devices), manual updates may be *required* by policy to prevent untested patches from disrupting critical operations
- Security+ and CySA+ distinguish manual updates from **automatic updates** and **push updates** as part of patch management lifecycle questions
- Manual processes demand compensating controls: vulnerability scanners, configuration management tools, and change management logs to track what has and hasn't been patched
- A common exam scenario: a system showing **unpatched known CVEs** after months is a red flag that manual update procedures failed or were bypassed

## Related concepts
[[Patch Management]] [[Vulnerability Scanning]] [[Change Management]] [[Compensating Controls]] [[Configuration Management]]