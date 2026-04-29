# Unauthorized Access

## What it is
Like a stranger using a copied key to enter your house while you're away — everything looks undisturbed, but the boundary was violated. Unauthorized access is any instance where an individual gains entry to a system, network, resource, or data without explicit permission from the resource owner, regardless of whether damage occurs. The act of access itself constitutes the violation, not what is done afterward.

## Why it matters
In the 2013 Target breach, attackers gained unauthorized access to Target's internal network by compromising credentials stolen from a third-party HVAC vendor, Fazio Mechanical. They leveraged that initial foothold to move laterally and exfiltrate 40 million credit card records — demonstrating that unauthorized access through a trusted third party can be just as devastating as a direct attack.

## Key facts
- Unauthorized access violates the **Computer Fraud and Abuse Act (CFAA)** in the U.S., making it a federal crime even if no data is stolen or modified
- It can occur through **credential theft, privilege escalation, session hijacking, or exploiting misconfigurations** — not just password cracking
- **Privilege escalation** is a form of unauthorized access even when the attacker already has a valid account (vertical = gaining admin rights; horizontal = accessing another user's data)
- Detection relies heavily on **log analysis, SIEM correlation rules, and behavioral baselines** — anomalous login times, locations, or access patterns are primary indicators
- The **principle of least privilege (PoLP)** is the primary preventive control: users should only access what they need, limiting blast radius if credentials are compromised

## Related concepts
[[Privilege Escalation]] [[Credential Stuffing]] [[Principle of Least Privilege]] [[Access Control]] [[SIEM]]