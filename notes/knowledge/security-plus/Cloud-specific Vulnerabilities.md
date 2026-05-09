# Cloud-specific Vulnerabilities

## What it is

In Tekken, when you pick a tag team match, your partner shares your health bar — if your opponent bodies Heihachi while Kazuya is offscreen, Kazuya still loses the round. That's exactly what cloud-specific vulnerabilities do — your security depends on infrastructure, tenants, and a provider you don't control, and their failures become your failures.

**Cloud-specific vulnerabilities** are weaknesses unique to cloud computing environments arising from shared infrastructure, multi-tenancy, the [[Shared Responsibility Model]], misconfigured cloud-native services, and the management plane exposed through APIs and consoles.

## Why it matters

A single misconfigured S3 bucket or over-permissive IAM role has leaked more records than most malware campaigns combined — Capital One (2019), Twitch (2021), and Microsoft's 38TB internal leak (2023) were all cloud configuration failures, not zero-days. Objective 2.3 requires you to identify cloud-specific attack surfaces: misconfiguration, insecure APIs, account hijacking, and improper tenant isolation. **CompTIA's favorite trap**: confusing what *the customer* secures versus what *the provider* secures — they will hand you a SaaS scenario and ask who patches the OS (provider) or a IaaS scenario and ask who patches the OS (customer). Memorize the [[Shared Responsibility Model]] table or you will lose easy points.

## Key facts

### The core cloud vulnerability categories

| Vulnerability | Mechanism | Defense |
|---|---|---|
| **[[Misconfiguration]]** | Public buckets, open security groups, default creds | [[CSPM]], IaC scanning, baseline policies |
| **[[Insecure APIs]]** | Unauthenticated/over-scoped management APIs | [[OAuth 2.0]], rate limiting, [[API Gateway]] |
| **[[Account Hijacking]]** | Stolen cloud console creds, no MFA | [[MFA]], [[Conditional Access]], session monitoring |
| **[[Insufficient Identity Management]]** | Over-privileged IAM roles, long-lived keys | [[Least Privilege]], short-lived tokens, [[CIEM]] |
| **[[Insecure Multi-Tenancy]]** | VM escape, side-channel (Spectre/Meltdown) | Hypervisor patching, dedicated tenancy |
| **[[Data Exposure]]** | Unencrypted storage, missing TLS | [[Encryption at Rest]], [[KMS]], [[BYOK]] |
| **[[Lack of Visibility]]** | No logging, blind to provider-side activity | [[CloudTrail]]/audit logs, [[CASB]], [[SIEM]] |
| **[[Vendor Lock-in]]** | Proprietary APIs, exfil cost barriers | Multi-cloud design, open standards |

### The Shared Responsibility Model — memorize cold

| Layer | IaaS | PaaS | SaaS |
|---|---|---|---|
| Data | **Customer** | **Customer** | **Customer** |
| Application | **Customer** | **Customer** | Provider |
| Runtime / Middleware | **Customer** | Provider | Provider |
| OS | **Customer** | Provider | Provider |
| Hypervisor / Network / Physical | Provider | Provider | Provider |

Data is **always** the customer's problem. That's the whole exam in one row.

### Attack patterns specific to cloud

- **[[Server-Side Request Forgery|SSRF]] against metadata service** — the Capital One attack: SSRF a web app, query `169.254.169.254`, steal IAM credentials, walk into S3. Defense: [[IMDSv2]] (session-token required).
- **[[Privilege Escalation via IAM]]** — `iam:PassRole` + `lambda:CreateFunction` chains let a low-priv user become admin. Defense: [[CIEM]] tooling, deny-by-default boundaries.
- **[[Subdomain Takeover]]** — dangling DNS pointing at a deleted cloud resource someone else can claim. Defense: DNS hygiene, monitor [[CNAME]] records.
- **[[Cryptojacking]]** — stolen keys spin up GPU instances to mine. The bill arrives before the alert does.
- **[[Side-Channel Attack]]** — co-tenant inference via shared CPU cache (Spectre/Meltdown class).

### Defenses CompTIA expects you to name

- **[[Cloud Security Posture Management|CSPM]]** — continuous misconfiguration scanning (e.g., public buckets, unencrypted volumes)
- **[[Cloud Access Security Broker|CASB]]** — policy enforcement between users and SaaS, four pillars: visibility, compliance, data security, threat protection
- **[[Cloud Workload Protection Platform|CWPP]]** — runtime protection for VMs, containers, serverless
- **[[Secure Access Service Edge|SASE]]** — converged network + security delivered from the cloud edge
- **[[Infrastructure as Code]] scanning** — catch the misconfig in the pipeline, not in production

### The cost of getting it wrong

- **Capital One (2019)** — 106M records, $190M settlement, SSRF + over-permissive IAM
- **Microsoft AI research (2023)** — 38TB leaked via misconfigured Azure SAS token
- **Twitch (2021)** — 125GB source code via server misconfiguration

Pattern: nobody got hacked. Everyone got *configured wrong*.

## Related concepts

[[Shared Responsibility Model]] · [[Misconfiguration]] · [[CASB]] · [[CSPM]] · [[CWPP]] · [[SASE]] · [[IAM]] · [[Least Privilege]] · [[IMDSv2]] · [[Multi-Tenancy]] · [[Virtualization Vulnerabilities]] · [[API Security]]

---
*Source: VIRGIL knowledge base — 2026-05-08*