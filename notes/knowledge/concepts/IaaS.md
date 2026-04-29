# IaaS

## What it is
Think of IaaS like renting a bare plot of land with utilities already run to it — you still build the house, pour the foundation, and maintain everything above ground. Infrastructure as a Service provides virtualized computing resources (servers, storage, networking) over the internet, where the provider manages physical hardware while the customer controls the OS, middleware, and applications.

## Why it matters
In 2019, Capital One suffered a breach of 100 million customer records because a misconfigured AWS WAF (an IaaS/cloud resource) allowed a Server-Side Request Forgery attack to harvest IAM credentials from the EC2 instance metadata service. This illustrates the **shared responsibility model** in action — AWS secured the physical infrastructure, but Capital One was responsible for correctly configuring what ran on top of it.

## Key facts
- In IaaS, the **customer is responsible** for the OS, applications, data, and identity management; the provider secures physical hardware, hypervisors, and networking infrastructure
- Common IaaS providers: AWS EC2, Microsoft Azure Virtual Machines, Google Compute Engine
- Primary attack surface includes **misconfigured security groups/firewall rules**, exposed storage buckets (S3), and overprivileged IAM roles
- The **instance metadata service (IMDS)** endpoint at 169.254.169.254 is a frequent lateral movement target — attackers exploit SSRF to steal temporary credentials
- IaaS environments are audited using tools like **AWS Config, CloudTrail (logging), and Security Hub** for continuous compliance monitoring

## Related concepts
[[Shared Responsibility Model]] [[Cloud Security Posture Management]] [[Privilege Escalation]] [[PaaS]] [[SaaS]]