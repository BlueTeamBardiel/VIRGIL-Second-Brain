# Access Certification

## What it is
Like a landlord doing an annual walkthrough to confirm which tenants still have valid keys — and revoking the ones who moved out — Access Certification is the formal, periodic process where managers review and confirm (or revoke) user access rights across systems. It ensures that privileges granted in the past remain appropriate today, combating the accumulation of unnecessary permissions over time.

## Why it matters
A classic real-world failure: a developer who transferred to marketing six months ago still has full read/write access to the production database. During a breach investigation, forensics reveals the attacker compromised that developer's credentials and pivoted directly into sensitive customer records — access that should have been stripped at the time of role change. A proper access certification campaign would have caught and remediated this months earlier.

## Key facts
- Access Certification is a core control for combating **privilege creep** — the gradual accumulation of access rights beyond what a user's current role requires
- It directly supports **least privilege** and **separation of duties** principles, both testable on Security+ and CySA+
- Certifications are typically triggered on a **scheduled basis** (quarterly, annually) or **event-driven** (job role change, termination, merger)
- The process involves three parties: the **system owner** (who generates the report), the **manager/reviewer** (who approves or revokes), and the **IAM/admin team** (who executes changes)
- Failure to conduct access certifications is a common **audit finding** and a compliance gap under frameworks like SOX, HIPAA, and ISO 27001
- Automated Identity Governance and Administration (IGA) tools (e.g., SailPoint, Saviynt) are commonly used to scale this process across thousands of accounts

## Related concepts
[[Least Privilege]] [[Privilege Creep]] [[Identity and Access Management]] [[Separation of Duties]] [[User Account Review]]