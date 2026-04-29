# Toxic Combinations

## What it is
Like mixing bleach and ammonia — each chemical is manageable alone, but together they produce a deadly gas — toxic combinations in security occur when individual low-risk privileges or misconfigurations combine to create a critical vulnerability. Precisely: a toxic combination is a set of two or more permissions, roles, or access rights that are individually acceptable but collectively violate the principle of least privilege, enabling fraud, data theft, or system compromise.

## Why it matters
In a financial institution, a single employee granted both the "create vendor" and "approve payments" roles can fabricate a fake vendor and authorize payments to it — a classic Segregation of Duties (SoD) failure. This exact pattern appeared in numerous internal fraud cases, which is why identity governance platforms like SailPoint explicitly scan for toxic combinations during access reviews and certification campaigns.

## Key facts
- Toxic combinations are a **Segregation of Duties (SoD)** violation — a core concept tested on Security+ and CySA+ under access control and identity management
- They frequently arise during **role creep** (accumulation of permissions over time) or improper **role mining** during IAM implementations
- Detection requires **identity governance and administration (IGA)** tools that map role intersections, not just individual permission audits
- Common toxic pair example: **"modify audit logs" + "execute financial transactions"** — together they allow fraud with evidence destruction
- Mitigated through **access certifications**, **separation of duties policies**, and **just-in-time (JIT) provisioning** to eliminate standing combined access

## Related concepts
[[Separation of Duties]] [[Least Privilege]] [[Role-Based Access Control]] [[Identity Governance]] [[Privilege Creep]]