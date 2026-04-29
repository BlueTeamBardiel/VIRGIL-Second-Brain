# Cloud Security

## What it is
Think of cloud security like renting an apartment: the landlord (cloud provider) secures the building's foundation, locks, and hallways, but *you* are responsible for what happens inside your unit — who has a key, what valuables you store, whether you left the window open. This shared responsibility model is the core of cloud security: a discipline covering the policies, controls, and technologies that protect data, applications, and infrastructure hosted in cloud environments.

## Why it matters
In 2019, Capital One suffered a breach exposing over 100 million customer records because a misconfigured Web Application Firewall allowed an attacker to exploit an SSRF vulnerability and query AWS metadata — pulling IAM credentials directly from the instance. The attacker didn't break the cloud; they walked through a door the customer left unlocked. Proper IAM least-privilege policies and misconfiguration scanning would have stopped it cold.

## Key facts
- **Shared Responsibility Model**: CSPs (AWS, Azure, GCP) secure "of" the cloud (hardware, hypervisor, physical); customers secure "in" the cloud (OS, data, identity, configurations).
- **Top cloud risk is misconfiguration**, not zero-days — exposed S3 buckets, open security groups, and default credentials dominate breach reports.
- **CASB (Cloud Access Security Broker)** acts as a policy enforcement point between users and cloud services, providing visibility, DLP, and access control.
- **Data sovereignty** concerns mean data stored in a foreign region may fall under that nation's legal jurisdiction and government access laws.
- **CSP audit logs** (e.g., AWS CloudTrail) provide immutable records of API calls and are critical for incident response and compliance evidence.

## Related concepts
[[Identity and Access Management]] [[Misconfiguration Vulnerabilities]] [[Zero Trust Architecture]] [[CASB]] [[Shared Responsibility Model]]