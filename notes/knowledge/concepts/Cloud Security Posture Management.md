# Cloud Security Posture Management

## What it is
Think of CSPM as a building inspector who walks through every floor of a skyscraper 24/7, automatically flagging unlocked doors, exposed wiring, and fire hazards before anyone gets hurt. Cloud Security Posture Management (CSPM) is a category of automated tools that continuously assess cloud infrastructure configurations against security best practices and compliance frameworks, identifying misconfigurations and drift in real time.

## Why it matters
In 2019, Capital One suffered a breach exposing over 100 million customer records — the root cause was a misconfigured AWS WAF and overly permissive IAM role, not a sophisticated zero-day exploit. A properly tuned CSPM tool would have flagged the excessive EC2 metadata service permissions and the misconfigured firewall rule before an attacker could weaponize them, turning a catastrophic breach into a routine alert.

## Key facts
- CSPM tools check for misconfigurations such as publicly exposed S3 buckets, overly permissive IAM policies, disabled MFA on root accounts, and unencrypted storage volumes
- They enforce compliance benchmarks including CIS Foundations, NIST 800-53, PCI-DSS, and HIPAA by mapping cloud resource states to control requirements
- CSPM operates on a **detect-and-remediate** model — many tools offer auto-remediation to close misconfigurations without human intervention
- Unlike traditional vulnerability scanners, CSPM focuses on **configuration state**, not software vulnerabilities or running code
- CSPM is distinct from CWPP (Cloud Workload Protection Platform), which protects runtime workloads; CSPM secures the infrastructure layer beneath them

## Related concepts
[[Cloud Workload Protection Platform]] [[Identity and Access Management]] [[Shared Responsibility Model]]