# Scope

## What it is
Like a property survey that tells a contractor exactly which land they can dig on — no more, no less — scope defines the precise boundaries of an authorized security engagement. In penetration testing and vulnerability assessments, scope is the formally agreed-upon list of systems, networks, IP ranges, applications, and attack techniques that are explicitly permitted or prohibited.

## Why it matters
In 2012, a penetration tester working for a bank's parent company accessed a subsidiary's systems that were *not* included in the signed Rules of Engagement — and faced criminal charges under the Computer Fraud and Abuse Act (CFAA). Staying within scope isn't just good practice; it's the legal line separating authorized testing from criminal intrusion. A clearly defined scope also ensures defenders get actionable results for the systems that actually matter to the organization.

## Key facts
- **Scope creep** occurs when a tester discovers out-of-scope systems during testing; proper procedure is to *stop, document, and notify the client* — never pivot into those systems without written authorization
- The **Rules of Engagement (ROE)** document operationalizes scope by specifying allowed techniques, testing windows, and point-of-contact escalation paths
- **In-scope** items are explicitly listed (e.g., 192.168.10.0/24); anything unlisted is implicitly out-of-scope
- A **Statement of Work (SOW)** or **Master Service Agreement (MSA)** provides the legal backing for the scope document
- For Security+/CySA+: scope must be defined *before* any active reconnaissance or testing begins — not retroactively approved

## Related concepts
[[Rules of Engagement]] [[Penetration Testing]] [[Statement of Work]] [[Computer Fraud and Abuse Act]] [[Reconnaissance]]