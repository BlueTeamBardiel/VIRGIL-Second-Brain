# IaaS — Infrastructure as a Service

## What it is

In **Street Fighter**, when you pick Ryu at the character select screen, Capcom hands you the fighter, the stage, the netcode, the rollback, the frame data engine — the entire ring. You bring the inputs: the combos, the spacing, the matchup knowledge, the decision to throw a Hadouken or bait a DP. Capcom owns the floor. You own the fight. **IaaS is the same split.** The cloud provider owns the building, the power, the hypervisor, the physical network. You own the OS, the patches, the firewall rules, the IAM, the data. Pick wrong on the patch cadence, you eat the combo.

In plain English: IaaS is renting virtualized hardware. You get a VM, a virtual network, virtual storage. You configure everything from the operating system up.

Technical definition (NIST SP 800-145 alignment): **Infrastructure as a Service** is a cloud service model where the consumer provisions processing, storage, networks, and other fundamental computing resources. The consumer does not manage the underlying cloud infrastructure but **does control operating systems, storage, deployed applications, and select networking components** (e.g., host firewalls). AWS EC2, Azure Virtual Machines, GCP Compute Engine are the canonical examples.

## Why it matters

CySA+ tests cloud constantly because most enterprises are now hybrid, and the SOC analyst's day is split between on-prem Windows event logs and CloudTrail JSON. **Objective 1.1** explicitly lists IaaS alongside SaaS, PaaS, hybrid, serverless, virtualization, and containerization — the architecture surface you're defending.

Career relevance: the shared responsibility model is the single most-confused concept in entry-level cloud security. If you can articulate where the provider's responsibility ends and yours begins, you're already ahead of the L1 who paged the on-call because "AWS got breached" when actually a developer left an S3 bucket public. *The provider didn't get breached. The tenant did.*

## Key facts

### The shared responsibility model — who eats the damage

| Layer | IaaS | PaaS | SaaS |
|---|---|---|---|
| Physical datacenter | Provider | Provider | Provider |
| Hypervisor / host OS | Provider | Provider | Provider |
| Network infrastructure | Provider | Provider | Provider |
| **Guest OS** | **You** | Provider | Provider |
| **Patching** | **You** | Provider | Provider |
| **Runtime / middleware** | **You** | Provider | Provider |
| Application | You | You | Provider |
| **Configuration** | **You** | **You** | **You** |
| **IAM / access policy** | **You** | **You** | **You** |
| **Data** | **You** | **You** | **You** |

IaaS gives you the most control and the most blast radius. You can harden a Windows Server 2022 VM exactly how you want. You can also forget to patch it for 90 days because no one ran a [[vulnerability scanning]] credentialed scan against the VPC.

### What you actually deploy in IaaS

- **Compute** — EC2 instances, Azure VMs, GCP Compute Engine. You pick the image, size, region.
- **Storage** — block (EBS), object (S3), file (EFS). Encryption at rest is your decision (usually one checkbox, frequently unchecked).
- **Network** — VPC, subnets, route tables, security groups, NACLs. This is your [[Network segmentation]] surface in the cloud.
- **IAM** — roles, policies, instance profiles. The IAM misconfiguration is the cloud-era equivalent of "Domain Admin for the service account."

### Hardening the IaaS workload

[[System hardening]] in IaaS is the same muscle as on-prem, with cloud-specific extras:

- **Patch the guest OS.** The provider patches the hypervisor. You patch Ubuntu, RHEL, Windows. Nobody else does this for you.
- **CIS Benchmarks** for the OS, applied via configuration management (Ansible, Chef) or golden images (Packer).
- **Disable defaults.** Default VPCs, default security groups (0.0.0.0/0 inbound on SSH), default IAM policies (AdministratorAccess on dev accounts).
- **[[Encryption]] at rest** — EBS volumes, S3 buckets, RDS snapshots. Customer-managed KMS keys give you key rotation control.
- **Encryption in transit** — TLS everywhere, [[SSL]] only as a deprecated label, never as a current protocol. SSL 3.0 is dead. TLS 1.2 minimum, 1.3 preferred.
- **Host-based controls** — EDR agent on every VM. Cloud doesn't replace endpoint telemetry, it multiplies the endpoints.
- **Disable [[passwordless]] root SSH and rotate keys.** SSH key sprawl is the new password reuse.

### Identity is the new perimeter

In on-prem, the firewall is the wall. In IaaS, the wall is permeable and the **identity boundary is the real perimeter**.

- **[[IAM]]** — least-privilege roles, no long-lived access keys on EC2 (use instance profiles), no wildcard `*:*` policies in production.
- **[[MFA]]** — mandatory on the root account, mandatory on any human IAM user. CompTIA loves this question.
- **[[SSO]]** + **[[Federation]]** — federate corporate identity (Azure AD, Okta) into AWS via SAML. One identity, one offboarding event kills cloud access too.
- **[[PAM]]** — privileged session recording, just-in-time elevation, vaulted credentials for break-glass accounts.
- **[[Zero trust]]** — every API call is authenticated, authorized, logged. No "inside the VPC" trust shortcut.

### Logging and time — the forensic foundation

The SOC's job in IaaS is impossible without logs and synchronized time.

- **[[Log ingestion]]** — CloudTrail (API calls), VPC Flow Logs (NetFlow equivalent), GuardDuty findings, OS logs (syslog, Windows Event Log), application logs. All ship to [[SIEM]].
- **[[Logging levels]]** — debug/info/warn/error/critical. Production at info+ baseline; debug only during incident response, never permanently (storage cost + sensitive data leakage).
- **[[Time synchronization]]** — every VM runs NTP (chrony on Linux, w32time on Windows) against the cloud provider's time service. **Without synced time, your forensic timeline is fiction.** Cross-system correlation in SIEM breaks if clocks drift even seconds.
- **CloudTrail must be enabled in every region, with log file validation, shipped to a separate logging account.** Attackers who get in disable CloudTrail first.

### Cloud-specific controls you'll see on the exam

- **[[CASB]]** — Cloud Access Security Broker. Sits between users and cloud services. Enforces DLP, access policy, threat detection on cloud traffic. Four pillars: visibility, compliance, data security, threat protection.
- **[[SASE]]** — Secure Access Service Edge. Combines SD-WAN + security (SWG, CASB, ZTNA, FWaaS) into a cloud-delivered edge. The remote-work answer to "the perimeter is gone."
- **[[SDN]]** — software-defined networking. VPCs are SDN. Security groups, route tables, transit gateways are all programmable.
- **[[DLP]]** — data loss prevention. In IaaS, this means scanning S3 for [[PII]], [[CHD]], PHI; blocking exfil patterns in egress traffic.
- **[[PKI]]** — managed via ACM (AWS Certificate Manager), Azure Key Vault, GCP Certificate Manager. Internal CAs for service-to-service mTLS.

### Hybrid, virtualization, containers, serverless — adjacent models

- **[[Virtualization]]** — the foundation under IaaS. The hypervisor (KVM, Hyper-V, Xen) carves physical into virtual.
- **[[Containerization]]** — Docker, containerd. Lighter than VMs, share kernel. ECS, EKS, AKS, GKE deliver containers as a service — but the orchestration plane introduces its own attack surface ([[Kubernetes]] RBAC, kubelet exposure).
- **[[Serverless]]** — Lambda, Azure Functions, Cloud Run. Provider runs the runtime; you ship code. Shorter blast radius per function but new categories of risk (over-permissioned execution roles, cold-start telemetry gaps).
- **[[Hybrid cloud]]** — on-prem + cloud connected via VPN or Direct Connect/ExpressRoute. Identity federation and consistent logging across both halves is the SOC's headache.

### CompTIA exam traps

> **CompTIA exam trap:** "Who patches the OS in IaaS?" Answer: **the customer**. In PaaS, the provider patches the OS and runtime. In SaaS, the provider patches everything. CompTIA will give you a scenario with an unpatched VM in EC2 and ask whose responsibility it was. It was yours.

> **CompTIA exam trap:** CASB vs SASE vs SWG. **CASB** is specifically the broker for cloud service traffic (Shadow IT discovery, OAuth app governance, DLP for SaaS). **SASE** is the umbrella architecture combining network + security at the edge. **SWG** (Secure Web Gateway) is a component — URL filtering, malware scanning for web traffic. SASE contains CASB and SWG; CASB doesn't contain SASE.

> **CompTIA exam trap:** "Encryption at rest" vs "encryption in transit." An S3 bucket can be encrypted at rest (SSE-S3, SSE-KMS) and still serve objects over plain HTTP if you forgot the bucket policy requiring TLS. CompTIA loves to test this distinction.

> **CompTIA exam trap:** Time synchronization is not a "nice to have" — it's a Domain 1.0 explicit objective. If clocks drift, [[chain of custody]] and forensic timeline reconstruction collapse. Expect a question framed as "why did the IR team fail to correlate the lateral movement events?" Answer involves NTP.

## SOC reality

- **The 3am alert:** GuardDuty fires `UnauthorizedAccess:IAMUser/ConsoleLoginSuccess.B` — successful console login from an unusual geography on a service account that should never log into the console. You don't have hours. You revoke the access key, force MFA reset, pull CloudTrail for that principal for the last 72 hours, and start mapping what API calls fired.
- **The L1's first move:** acknowledge the ticket, confirm it's not a known whitelisted admin, check if the IP matches any known corporate egress or VPN. If not — escalate to L2 immediately. Don't try to "investigate" by clicking around the console. You'll tip the attacker.
- **What the IR lead asks:** "Scope — which accounts, which regions, which resources touched? Impact — was data accessed or exfiltrated? Evidence — is CloudTrail preserved, are we taking EBS snapshots before terminating?" If you terminate the instance before snapshotting, you destroyed the evidence. Never terminate first.
- **Never promise leadership** "we've contained it" until CloudTrail confirms no further activity from the compromised principal for a full beacon interval, AND you've checked for persistence mechanisms (new IAM users, new access keys, Lambda functions, EC2 instances in unused regions, modified trust policies).
- **The handoff:** L1 detects → L2 investigates → IR team contains and eradicates → cloud engineering rotates keys and rebuilds → legal/compliance assesses notification obligations ([[GDPR]] 72h, state breach laws, customer contracts). If [[PII]] or [[CHD]] is involved, legal is on the bridge inside the hour.

*Cloud doesn't make you safer. It makes the misconfigurations faster, the blast radius bigger, and the audit trail richer — if you turned the audit trail on.*

## Related concepts

[[SaaS]] · [[PaaS]] · [[Serverless]] · [[Hybrid cloud]] · [[Virtualization]] · [[Containerization]] · [[Shared responsibility model]] · [[CASB]] · [[SASE]] · [[SDN]] · [[Zero trust]] · [[IAM]] · [[MFA]] · [[SSO]] · [[Federation]] · [[PAM]] · [[DLP]] · [[Encryption]] · [[PKI]] · [[Network segmentation]] · [[System hardening]] · [[Log ingestion]] · [[Time synchronization]] · [[SIEM]] · [[CloudTrail]] · [[VPC Flow Logs]] · [[CIS Benchmarks]] · [[PII]] · [[CHD]]

*Source: VIRGIL knowledge base — 2026-05-11*