# breach

## What it is
Like a dam wall cracking and water flooding the valley below, a breach is the moment containment fails and protected data escapes to unauthorized hands. Precisely defined, a breach is a confirmed incident in which protected, sensitive, or confidential data is accessed, disclosed, or stolen by an unauthorized party. The key word is *confirmed* — suspected exposure is an incident until evidence proves actual unauthorized access occurred.

## Why it matters
In 2013, Target suffered a breach where attackers used stolen HVAC vendor credentials to pivot into the payment network, exfiltrating 40 million credit card records. This case illustrates why breach scope matters: organizations must trigger mandatory notification under laws like PCI-DSS and state breach notification statutes within specific timeframes once a breach is confirmed, not merely suspected. Delayed confirmation cost Target over $18 million in settlement fees.

## Key facts
- **NIST SP 800-53** distinguishes a *breach* (confirmed unauthorized disclosure) from a *security incident* (any policy violation, which may not involve data loss)
- **HIPAA Breach Notification Rule** requires covered entities to notify affected individuals within **60 days** of discovering a breach of unsecured PHI
- Breaches are classified by data type: **PII, PHI, PCI** data each trigger different regulatory obligations and penalties
- The **mean time to identify (MTTI)** a breach averaged **207 days** (IBM Cost of a Data Breach Report 2023) — attackers dwell long before discovery
- Breach vs. **data leak**: a leak is unintentional exposure (misconfigured S3 bucket) without confirmed access; a breach requires evidence an unauthorized party actually obtained the data

## Related concepts
[[data exfiltration]] [[incident response]] [[data classification]] [[notification requirements]] [[threat actor]]