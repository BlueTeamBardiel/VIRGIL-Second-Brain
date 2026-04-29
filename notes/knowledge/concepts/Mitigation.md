# Mitigation

## What it is
Like a doctor who can't cure a disease but prescribes medication to reduce symptoms and prevent organ failure, mitigation reduces the impact or likelihood of a threat without necessarily eliminating it entirely. Precisely: mitigation is the application of controls, countermeasures, or configuration changes that lower risk to an acceptable level when full remediation isn't immediately possible.

## Why it matters
In 2021, the Log4Shell vulnerability (CVE-2021-44228) hit organizations before patches were available. Security teams immediately applied mitigations — disabling JNDI lookups via environment variables, implementing WAF rules to block exploit strings, and isolating vulnerable systems — buying critical time before vendor patches arrived. Without this layered mitigation response, attackers could achieve remote code execution across millions of systems during that window.

## Key facts
- Mitigation differs from **remediation**: remediation removes the vulnerability entirely (patching); mitigation reduces exposure without eliminating the root cause
- The **NIST RMF** and **Risk Response strategies** include four options: Accept, Avoid, Transfer, and **Mitigate** — mitigation is the most common active response
- Common mitigation techniques include: network segmentation, disabling unnecessary services, applying compensating controls, and enforcing least privilege
- **Compensating controls** are a specific form of mitigation used when the primary control cannot be implemented (common in PCI-DSS compliance contexts)
- On Security+/CySA+, mitigation appears in the incident response lifecycle — specifically the **Containment** phase uses mitigations to limit damage before eradication begins

## Related concepts
[[Risk Management]] [[Compensating Controls]] [[Patch Management]] [[Incident Response Lifecycle]] [[Defense in Depth]]