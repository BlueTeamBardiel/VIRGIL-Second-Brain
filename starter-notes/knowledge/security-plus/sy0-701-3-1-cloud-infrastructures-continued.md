---
domain: "3.0 - Security Architecture"
section: "3.1"
tags: [security-plus, sy0-701, domain-3, cloud-infrastructure, vendor-risk, iaas-paas-saas]
---

# 3.1 - Cloud Infrastructures (continued)

This section covers advanced cloud deployment models and architectural patterns critical to understanding shared security responsibility in modern cloud environments. You'll need to distinguish between [[Infrastructure as Code]], [[Serverless Architecture]], [[Microservices]], and monolithic approaches—plus understand how third-party vendor risk and the [[Responsibility Matrix]] shift security obligations across [[IaaS]], [[PaaS]], and [[SaaS]]. The exam heavily tests your ability to identify who owns what security layer and why architectural choices impact your organization's attack surface.

---

## Key Concepts

- **Third-Party Vendors in Cloud**
  - The cloud security model involves *three* parties: your organization, the cloud provider, and third-party vendors offering infrastructure technologies and cloud-based appliances
  - Vendor risk assessments must be continuous and ongoing, integrated into your overall [[Vendor Risk Management]] policy
  - Third-party impact must be factored into your [[Incident Response]] plan—they are part of the process, not an afterthought

- **Infrastructure as Code (IaC)**
  - Define entire infrastructure (servers, networking, applications) as declarative code files
  - Version your infrastructure the same way you version application source code, enabling reproducibility and rollback
  - Identical builds every time—critical for consistency, compliance, and disaster recovery in cloud environments
  - Central to [[DevOps]] and [[CI/CD]] pipelines; reduces configuration drift and human error

- **Serverless Architecture (Function as a Service / FaaS)**
  - Applications decomposed into individual, autonomous functions instead of running on managed servers
  - Developers write server-side logic; the cloud provider manages the entire OS and infrastructure layer
  - Functions are stateless, event-triggered, and often ephemeral (spin up for one event, shut down after)
  - All [[OS Security]] concerns (patching, hardening, access control) shift entirely to the third-party provider
  - Reduces your attack surface but increases dependency on provider security practices

- **Microservices and APIs**
  - **Monolithic Architecture**: One large application handling all logic (UI, business rules, I/O) in a single codebase
    - Scaling, change control, and debugging become increasingly difficult as the codebase grows
    - Security breach in one component can compromise the entire application
  - **Microservices Architecture**: Application split into many small, independently deployable services
    - [[API|APIs]] act as the "glue" connecting microservices; they expose interfaces for communication
    - **Scalability**: Scale only the microservices experiencing load, not the entire app
    - **Resilience**: Outages are contained—failure in one microservice doesn't cascade to all others
    - **Security & Compliance**: Isolation is built-in by design; easier to apply least privilege and segment access

- **Responsibility Matrix (Shared Security Model)**
  - Clarifies who (customer vs. provider) manages security for each layer:
    - **SaaS**: Provider manages everything except your data/accounts; customer responsible for information, identities, and access
    - **PaaS**: Customer manages applications and data; provider handles runtime, OS, networking, infrastructure
    - **IaaS**: Customer manages applications, OS, and accounts; provider manages physical hosts, networking, and datacenter
    - **On-Premises**: Customer owns the entire stack
  - Know this matrix cold—exam questions test your ability to identify responsibility misalignment

---

## How It Works (Feynman Analogy)

**Monolithic vs. Microservices**: Think of a restaurant kitchen.

A *monolithic* kitchen has one giant station where one cook handles everything—appetizers, mains, desserts, plating. If that cook gets sick, the entire restaurant stops. If you need to scale, you need a whole new cook doing everything redundantly. Changes take coordination across all tasks.

A *microservices* kitchen has separate stations: one person on appetizers, one on mains, one on desserts, one on plating. Each station can work independently. If the appetizer cook calls in sick, only appetizers slow down. You can hire an extra person *just* for desserts if demand spikes. Each station (microservice) communicates via ticket windows (APIs) telling each other what to do next.

**Serverless vs. Traditional Servers**: Imagine a taxi service vs. owning a car.

With *traditional servers* (IaaS), you own the car (rent the server), maintain the engine (patch the OS), handle insurance (security), and drive it yourself (manage the application).

With *serverless* (FaaS), you use Uber. You don't own, maintain, or operate a vehicle—you just call the service with a request (trigger a function), the platform handles everything else, and you pay per ride (per invocation). The trade-off: less control, but zero operational overhead. You trust Uber's mechanics (the cloud provider's infrastructure team).

**Infrastructure as Code**: Instead of manually setting up servers one-by-one (error-prone, time-consuming), you write a blueprint in code that says "create 10 identical servers with these configs, this networking, these security groups." Run the blueprint 100 times, get 100 identical setups. No manual variation. Every environment matches—dev, test, prod.

---

## Exam Tips

- **Responsibility Matrix is Non-Negotiable**: The exam will show you a scenario (e.g., "An OS needs a security patch") and ask who's responsible. Know: SaaS = provider handles almost everything; IaaS = customer handles OS/apps; PaaS = split responsibility on middleware. Off-by-one errors cost points.

- **Serverless ≠ No Security**: A common trap is thinking FaaS eliminates security concerns. Reality: you still own data security, authentication logic, and API security. You just don't patch the OS because the provider does. The exam tests whether you understand *what* responsibility you still carry.

- **Microservices = More APIs = More Attack Surface**: While microservices add resilience, each API is a potential entry point. The exam may ask about the security trade-offs (e.g., "What's a risk of microservices?"). Answer: more [[API]] endpoints to secure, more complexity in inter-service authentication and [[Authorization]].

- **Third-Party Vendor Risk is Continuous**: Don't treat vendor assessments as a one-time checkbox. The exam emphasizes *ongoing* monitoring and incident response integration. A compromised vendor becomes *your* incident.

- **Infrastructure as Code ≠ Automatic Security**: Exam trap: thinking IaC magically prevents security misconfigurations. Reality: IaC lets you *codify* bad configurations at scale. Emphasis is on version control, repeatability, and the ability to audit changes—not automatic hardening.

---

## Common Mistakes

- **Confusing who owns what in PaaS**: Many candidates think PaaS means "the provider manages everything." Actually, *you* manage your application code and data security; the provider manages the platform (runtime, middleware, databases). Test yourself: "In PaaS, who patches the Java runtime?" (Provider.) "Who secures the authentication logic in your application?" (You.)

- **Underestimating Serverless Complexity**: Candidates assume FaaS means "I don't have to think about security." Wrong. You still write vulnerable code, mishandle credentials, and expose APIs. Serverless shifts operational burden (OS patching), not security burden (your code).

- **Treating Microservices as a Security Silver Bullet**: While isolation is good, microservices introduce complexity—more [[API]] calls, more authentication handshakes, more surface area. The exam tests whether you recognize both benefits AND risks.

---

## Real-World Application

In Morpheus's [[[YOUR-LAB]]] homelab, moving from a monolithic internal application to microservices (backed by [[Tailscale]] for secure inter-node communication) would require adding [[API]] authentication (possibly [[OAuth]] or [[mTLS]]) and monitoring each service independently via [[Wazuh]]. If considering [[Serverless|FaaS]] for event-driven tasks (e.g., automated incident response), you'd rely on the cloud provider's OS security but still own the function code security and least-privilege [[IAM]] role design. Using [[Infrastructure as Code]] (e.g., Terraform) to define the lab ensures repeatability—critical for disaster recovery and compliance auditing in a security-focused homelab.

---

## [[Wiki Links]]

### Architecture & Deployment Patterns
- [[Monolithic Architecture]]
- [[Microservices Architecture]]
- [[Serverless Architecture]]
- [[Function as a Service (FaaS)]]
- [[Infrastructure as Code (IaC)]]
- [[DevOps]]
- [[CI/CD Pipeline]]

### Cloud Service Models & Responsibility
- [[IaaS]] (Infrastructure as a Service)
- [[PaaS]] (Platform as a Service)
- [[SaaS]] (Software as a Service)
- [[Responsibility Matrix]]
- [[Shared Security Model]]

### Security & Risk
- [[Vendor Risk Management]]
- [[Third-Party Risk]]
- [[Incident Response]]
- [[Attack Surface]]
- [[Least Privilege]]
- [[Isolation]]
- [[Configuration Drift]]

### APIs & Communication
- [[API]] (Application Programming Interface)
- [[API Gateway]]
- [[OAuth]]
- [[mTLS]] (Mutual TLS)
- [[SAML]]

### Monitoring & Compliance
- [[Wazuh]]
- [[SIEM]]
- [[Audit Logging]]

### Homelab Tools & Concepts
- [[[YOUR-LAB]]]
- [[Tailscale]]
- [[Active Directory]]
- [[Terraform]]

### Related Exam Domains
- [[3.0 - Security Architecture]]
- [[Zero Trust]]
- [[CIA Triad]]
- [[Defense in Depth]]

---

## Tags

`domain-3` `security-plus` `sy0-701` `cloud-infrastructure` `vendor-risk` `iaas-paas-saas` `microservices` `serverless` `infrastructure-as-code` `responsibility-matrix` `shared-security-model`

---

## Study Checklist

- [ ] Draw the Responsibility Matrix from memory (SaaS/PaaS/IaaS rows, layers as columns)
- [ ] Explain monolithic vs. microservices in your own words (restaurant analogy works)
- [ ] Describe FaaS and identify what *you* still own (data, code security, IAM)
- [ ] List three continuous vendor risk monitoring activities
- [ ] Name two security benefits and two risks of microservices
- [ ] Practice: "Who patches the [OS/runtime/application]?" for each service model
- [ ] Review a sample IaC template and identify how it enables consistency

---

**Last Updated**: 2025  
**Exam Focus**: Domain 3.0 (18% of SY0-701)  
**Difficulty**: Medium-High (Responsibility Matrix questions are frequent)

---
_Ingested: 2026-04-15 23:51 | Source: professor-messer-sy0-701-comptia-security-plus-course-notes-v107.pdf_
