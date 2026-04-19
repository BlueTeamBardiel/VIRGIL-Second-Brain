---
domain: "Cloud Security"
tags: [cloud, architecture, iaas, paas, saas, security-plus]
---
# Cloud Computing Models

**Cloud computing** delivers on-demand computing resources—servers, storage, databases, networking, software—over the internet using a **shared responsibility model** that divides security obligations between the provider and the customer. The three primary **service models** (IaaS, PaaS, SaaS) and four primary **deployment models** (public, private, hybrid, community) define both the capabilities available and the attack surface exposed. Understanding these models is foundational to [[Cloud Security Architecture]] and is heavily tested on the [[CompTIA Security+ SY0-701]] exam.

---

## Overview

Cloud computing emerged as a commercial paradigm in the mid-2000s, with Amazon Web Services launching EC2 in 2006 and S3 shortly after. The core principle is resource pooling—physical hardware is abstracted into virtualized resources that can be provisioned and released on demand, billed by consumption rather than capital expenditure. This elasticity fundamentally changed how organizations deploy infrastructure but simultaneously introduced new security challenges around data sovereignty, identity management, and multi-tenancy risk.

The **NIST SP 800-145** definition, which CompTIA references directly, identifies five essential characteristics of cloud computing: on-demand self-service, broad network access, resource pooling, rapid elasticity, and measured service. These characteristics apply regardless of deployment model and define what distinguishes a cloud service from traditional managed hosting. Security professionals must understand these characteristics because each one introduces specific threat vectors—for example, rapid elasticity can allow misconfigured auto-scaling to spin up resources in unexpected regions, creating shadow infrastructure.

The **service models** form a stack. Infrastructure as a Service (IaaS) sits at the bottom, providing raw compute, storage, and networking. Platform as a Service (PaaS) sits in the middle, abstracting the operating system and runtime environments. Software as a Service (SaaS) sits at the top, delivering fully managed applications over the web. The higher up the stack a customer operates, the less control they have over the underlying infrastructure—but also the less responsibility they bear for its security. This trade-off is the essence of the shared responsibility model.

**Deployment models** address who owns and operates the infrastructure. Public cloud (AWS, Azure, GCP) is owned by a third-party provider and shared among many tenants. Private cloud is operated exclusively for one organization, either on-premises or hosted. Hybrid cloud combines public and private environments connected by orchestration technology. Community cloud serves a specific group of organizations with shared concerns—common in government, healthcare (HIPAA), and defense (FedRAMP environments). Each deployment model carries distinct compliance implications and risk profiles.

Cloud adoption has accelerated dramatically post-2020, with the majority of enterprise workloads now running in cloud environments. This makes cloud security knowledge not merely academic—it is a core operational competency. Attackers have correspondingly shifted focus: the 2019 Capital One breach (S3 misconfiguration via SSRF), the 2020 SolarWinds attack (supply chain compromising cloud-hosted update infrastructure), and countless ransomware campaigns leveraging cloud credential theft demonstrate that cloud attack surfaces are actively exploited.

---

## How It Works

### Service Model Technical Breakdown

#### IaaS (Infrastructure as a Service)

The provider manages physical hardware, hypervisors, and network fabric. The customer receives virtual machines, block or object storage, and virtual networking constructs (VPCs, subnets, security groups). The customer is responsible for everything from the OS up.

**AWS example — launching an EC2 instance via CLI:**
```bash
# Launch a t3.micro Amazon Linux 2 instance in a specific subnet
aws ec2 run-instances \
  --image-id ami-0c55b159cbfafe1f0 \
  --instance-type t3.micro \
  --key-name my-keypair \
  --security-group-ids sg-0a1b2c3d4e5f \
  --subnet-id subnet-0123456789abcdef0 \
  --associate-public-ip-address \
  --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=lab-host}]'
```

The customer must patch this OS, configure the firewall (security groups), install and harden services, and manage identity. The provider secures the hypervisor and physical data center.

#### PaaS (Platform as a Service)

The provider manages OS, runtime, middleware, and scaling. The customer deploys application code and manages application-level configuration. Examples: AWS Elastic Beanstalk, Google App Engine, Azure App Service, Heroku.

**Deploying a Python Flask app to Heroku (PaaS):**
```bash
# Initialize git, create Procfile, deploy
git init
echo "web: gunicorn app:app" > Procfile
heroku create my-flask-app
git add .
git commit -m "Initial deploy"
git push heroku main
```

The customer never touches an OS here. Security focus shifts to application code vulnerabilities (OWASP Top 10), API keys in source code, and dependency management. The platform handles TLS termination, OS patching, and load balancing.

#### SaaS (Software as a Service)

The provider manages everything including the application itself. The customer configures the software and manages user access. Examples: Microsoft 365, Salesforce, Google Workspace, Slack, ServiceNow.

Security responsibilities for the customer narrow dramatically:
- Identity and access management (who has what role)
- Data classification and handling within the application
- OAuth/SAML integration configuration
- Conditional access policies

**Reviewing OAuth app permissions in Microsoft 365:**
```powershell
# Connect to Microsoft Graph to audit OAuth consented apps
Connect-MgGraph -Scopes "Application.Read.All","Directory.Read.All"
Get-MgServicePrincipal -Filter "tags/any(t:t eq 'WindowsAzureActiveDirectoryIntegratedApp')" |
  Select-Object DisplayName, AppId, CreatedDateTime |
  Sort-Object CreatedDateTime -Descending
```

### Deployment Model Technical Mechanics

#### Public Cloud
Traffic flows over the public internet to provider edge nodes, then traverses the provider's private backbone. AWS uses its global Anycast network; GCP routes via its own undersea cable infrastructure. Data encryption in transit (TLS 1.2/1.3) and at rest (AES-256) is standard but must be explicitly configured in many cases.

#### Private Cloud
Technologies: **OpenStack**, **VMware vSphere with NSX**, **Nutanix**. Organizations deploy these on-premises, maintaining full control of the hardware stack.

```bash
# OpenStack CLI: list running instances in a private cloud tenant
openstack server list --status ACTIVE --all-projects

# List available networks
openstack network list
```

#### Hybrid Cloud Connectivity
Hybrid connections typically use dedicated circuits (AWS Direct Connect, Azure ExpressRoute) or encrypted VPN tunnels (IPsec IKEv2) to extend on-premises networks into cloud VPCs.

```bash
# Checking an IPsec VPN tunnel status on a FortiGate connecting to AWS VGW
get vpn ipsec tunnel summary
# Should show Phase1 and Phase2 as UP/UP
```

#### Community Cloud
FedRAMP-authorized cloud environments (GovCloud) are an example—only US government agencies and cleared contractors can provision resources. Access is controlled by agency identity federation (PIV/CAC smart card + SAML).

---

## Key Concepts

- **Shared Responsibility Model**: A contractual and operational framework where the cloud provider secures "the cloud" (hardware, hypervisors, physical facilities) and the customer secures "in the cloud" (data, identities, application configuration, OS in IaaS). The boundary shifts depending on the service model—in SaaS, the customer is responsible almost exclusively for data and identity.

- **Multi-Tenancy**: Multiple customers share the same physical infrastructure, separated by hypervisor-level or container-level isolation. This introduces the theoretical risk of **VM escape** or **side-channel attacks** (e.g., Spectre/Meltdown) where a malicious tenant could potentially read data from neighboring instances on the same physical host.

- **Elasticity vs. Scalability**: Elasticity is the ability to automatically provision and de-provision resources in response to demand (auto-scaling groups); scalability is the ability to handle increased load by adding resources (horizontal scaling = more instances; vertical scaling = larger instances). Misconfigured auto-scaling can incur runaway costs and create ephemeral infrastructure that evades logging.

- **Cloud Access Security Broker (CASB)**: A security control layer—either on-premises or cloud-hosted—that sits between users and cloud services to enforce data security policies, monitor activity, detect anomalies, and prevent data exfiltration. Examples include Microsoft Defender for Cloud Apps, Netskope, and Zscaler.

- **Serverless Computing (FaaS)**: An evolution of PaaS where the customer deploys individual functions (AWS Lambda, Azure Functions, Google Cloud Functions) without managing any server construct. The provider allocates compute only during function execution. Security concerns include event injection attacks, overly permissive IAM roles attached to functions, and cold-start timing side channels.

- **Cloud-Native Application Protection Platform (CNAPP)**: A unified security category combining CSPM (Cloud Security Posture Management), CWPP (Cloud Workload Protection Platform), and CIEM (Cloud Infrastructure Entitlement Management) to provide end-to-end visibility across cloud deployments.

- **Resource Pooling and Data Remanence**: When storage resources are deallocated and returned to the pool, data may persist on physical media until overwritten. Cloud providers address this through cryptographic erasure—destroying the encryption keys rather than wiping storage—ensuring data is effectively unrecoverable.

---

## Exam Relevance

**SY0-701 Domain Mapping**: Cloud computing models appear primarily in **Domain 1: General Security Concepts** and **Domain 4: Security Architecture**. Expect 8–12 questions across these domains touching cloud topics.

**High-Frequency Question Patterns:**

1. **Shared Responsibility Identification**: A scenario describes a breach (e.g., "An attacker exploited an unpatched OS vulnerability on an EC2 instance"). The question asks who is responsible. Answer: **the customer** for IaaS OS patching. If the hypervisor was exploited, that's **the provider's** responsibility.

2. **Model Identification by Description**: "A company wants to deploy a web application without managing servers or OS patches." This describes **PaaS**. "A company wants to use email and collaboration tools without any infrastructure." This describes **SaaS**.

3. **Deployment Model Selection**: "A hospital needs to share a cloud environment with other hospitals in the same region for a joint radiology system." This describes **community cloud**, not hybrid.

4. **CASB Use Cases**: Questions often describe a need to monitor or control employee use of unsanctioned cloud apps (Shadow IT). The correct control is a **CASB**.

**Common Gotchas:**
- **Private cloud ≠ on-premises**: Private cloud can be hosted by a third party (e.g., AWS GovCloud dedicated tenancy) but is logically isolated. Don't assume private cloud means the hardware is in your building.
- **Hybrid cloud requires integration**: Simply having both on-prem and cloud doesn't make it hybrid—there must be orchestration and workload portability between the two environments.
- **SaaS doesn't eliminate all customer security responsibility**: Identity management, DLP policies, and data classification remain the customer's responsibility even in full SaaS deployments.
- **FaaS/Serverless is a subset of PaaS** for exam categorization purposes.

---

## Security Implications

### Misconfigurations (Primary Attack Vector)
The leading cause of cloud breaches is misconfiguration, not zero-day exploits. Common misconfigurations include:

- **Publicly exposed S3 buckets**: AWS S3 buckets default to private but can be made public. The 2019 **Capital One breach** exposed over 100 million records due to an SSRF vulnerability combined with an overly permissive IAM role attached to an EC2 instance, allowing exfiltration from S3.
- **Overly permissive IAM policies**: Granting `*` actions on `*` resources violates least privilege. Attackers who steal credentials gain unlimited access.
- **Exposed management interfaces**: RDP (TCP 3389) or SSH (TCP 22) open to `0.0.0.0/0` in security groups are continuously scanned and brute-forced.
- **Unencrypted storage volumes**: EBS volumes, Azure Disks, and GCP Persistent Disks can be created without encryption enabled.

### Multi-Tenancy Risks
**CVE-2018-3615 / CVE-2018-3620 (Foreshadow/L1TF)**: Intel processor vulnerabilities that could allow a malicious VM to read L1 cache data belonging to another VM on the same physical host, breaking hypervisor isolation boundaries. Cloud providers responded by disabling hyper-threading in some configurations and applying microcode updates.

### Identity and Access Management Attacks
**Cloud credential theft** is the primary initial access technique (MITRE ATT&CK T1552.005 — Cloud Instance Metadata API). Attackers who gain code execution in a cloud VM can query the instance metadata service (IMDS) to retrieve temporary credentials:

```bash
# Classic IMDSv1 attack (no authentication required) — now mitigated by IMDSv2
curl http://169.254.169.254/latest/meta-data/iam/security-credentials/
# Returns role name, then:
curl http://169.254.169.254/latest/meta-data/iam/security-credentials/my-ec2-role
# Returns AccessKeyId, SecretAccessKey, Token — usable immediately
```

AWS now enforces IMDSv2 (requires a PUT token request first) as a mitigation. The 2019 Capital One attack exploited IMDSv1.

### Supply Chain Attacks in Cloud Environments
The **2020 SolarWinds SUNBURST** attack compromised Orion software updates, which were then distributed to thousands of organizations including cloud-hosted environments. Attackers used the backdoor to pivot into Azure AD tenants, steal SAML signing certificates (Golden SAML attack), and impersonate any user in federated cloud environments.

### Shadow IT and SaaS Proliferation
Employees connecting unsanctioned SaaS applications (personal Google Drive, unauthorized Slack workspaces) to corporate identity providers create data exfiltration paths that bypass DLP controls. OAuth token abuse allows attackers to maintain persistent access even after password resets.

---

## Defensive Measures

### 1. Enforce Cloud Security Posture Management (CSPM)
Deploy CSPM tools to continuously scan cloud configurations against security benchmarks (CIS AWS Foundations Benchmark, CIS Azure Benchmark):

```bash
# Run Prowler (open-source CSPM) against AWS account
pip install prowler
prowler aws --compliance cis_aws_foundations_benchmark_v1.5

# Specific check for public S3 buckets
prowler aws --check s3_bucket_public_access_block_account_configuration
```

### 2. Implement Least Privilege IAM
Apply AWS IAM Access Analyzer to identify overly permissive policies:

```bash
# Create an IAM Access Analyzer
aws accessanalyzer create-analyzer \
  --analyzer-name production-analyzer \
  --type ACCOUNT

# List findings (overly permissive resources)
aws accessanalyzer list-findings \
  --analyzer-arn arn:aws:access-analyzer:us-east-1:123456789012:analyzer/production-analyzer
```

Use **Service Control Policies (SCPs)** in AWS Organizations to enforce guardrails across all accounts, preventing any principal from disabling CloudTrail or deleting GuardDuty findings.

### 3. Enable and Centralize Cloud Logging

**AWS CloudTrail** (API activity), **VPC Flow Logs** (network traffic), and **AWS GuardDuty** (threat detection) should be enabled in every region:

```bash
# Enable CloudTrail in all regions, writing to a central S3 bucket
aws cloudtrail create-trail \
  --name org-cloudtrail \
  --s3-bucket-name my-cloudtrail-logs-bucket \
  --is-multi-region-trail \
  --enable-log-file-validation

aws cloudtrail start-logging --name org-cloudtrail
```

Forward logs to a SIEM ([[Security Information and Event Management]]) such as Splunk, Microsoft Sentinel, or Elastic SIEM.

### 4. Enforce IMDSv2 (Mitigate SSRF-to-IMDS Attacks)

```bash