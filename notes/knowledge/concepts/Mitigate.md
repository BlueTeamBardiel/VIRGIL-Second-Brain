# Mitigate

## What it is
Like a surgeon who can't cure a disease but removes the tumor to reduce harm, mitigation means reducing the impact or likelihood of a threat without fully eliminating it. In cybersecurity risk management, mitigation is one of four core risk responses (alongside accept, transfer, and avoid) that organizations use when a vulnerability cannot be completely remediated.

## Why it matters
When the Apache Log4Shell vulnerability (CVE-2021-44228) was disclosed in December 2021, patching every affected system immediately was impossible — systems were buried in third-party software and nested dependencies. Organizations mitigated by blocking outbound LDAP traffic at the firewall and deploying WAF rules to filter malicious JNDI strings, buying critical time before patches could be applied.

## Key facts
- Mitigation reduces **risk** (probability × impact) but does not eliminate the underlying vulnerability — the threat surface still exists
- On Security+/CySA+, mitigation is tested as part of the **risk response framework**: Avoid, Transfer, Mitigate (reduce), Accept
- Common technical mitigations include network segmentation, disabling unused services, least-privilege access, and MFA enforcement
- NIST SP 800-30 distinguishes mitigation from remediation: remediation removes the vulnerability; mitigation reduces its exploitability or damage potential
- "Compensating controls" are a specific type of mitigation used when primary controls can't be implemented (common in PCI-DSS compliance contexts)

## Related concepts
[[Risk Management]] [[Compensating Controls]] [[Vulnerability Remediation]] [[Defense in Depth]] [[Risk Acceptance]]