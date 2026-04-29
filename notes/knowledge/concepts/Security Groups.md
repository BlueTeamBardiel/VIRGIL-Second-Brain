# Security Groups

## What it is
Think of a security group like a velvet rope at a nightclub — it doesn't check individual guests at the door, it controls which *types* of traffic can enter or leave based on rules you define. In cloud environments (AWS, Azure, GCP), a security group is a virtual stateful firewall attached directly to compute instances, controlling inbound and outbound traffic at the resource level using allow rules only.

## Why it matters
In 2019, Capital One suffered a massive breach partly because an overly permissive security group allowed an EC2 instance to make unrestricted outbound calls to AWS metadata services, enabling a misconfigured WAF to exfiltrate credentials. A properly scoped security group restricting outbound traffic to only necessary destinations would have contained the blast radius significantly.

## Key facts
- Security groups are **stateful** — if you allow inbound traffic on port 443, the return traffic is automatically permitted without an explicit outbound rule
- They use **allow-only rules**; there is no explicit deny — unmatched traffic is implicitly dropped
- In AWS, security groups are applied at the **instance/ENI level**, while Network ACLs (NACLs) operate at the **subnet level** and are stateless
- The principle of **least privilege** dictates security groups should restrict source IPs to known ranges, not 0.0.0.0/0
- Misconfigured security groups are one of the top findings in cloud security audits and map to **CIS Benchmark controls** for cloud hardening

## Related concepts
[[Network Access Control Lists]] [[Zero Trust Architecture]] [[Cloud Security Posture Management]]