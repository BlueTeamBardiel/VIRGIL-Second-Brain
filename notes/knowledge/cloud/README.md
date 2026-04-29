# Cloud Security
> The cloud didn't change security — it just moved the perimeter to IAM and made every misconfiguration public.

Cloud infrastructure has the same security principles as on-premises, but the blast radius of mistakes is different. A misconfigured S3 bucket exposes data to the whole internet. An over-permissioned IAM role hands an attacker the keys to your entire account. Understanding the shared responsibility model and the most common misconfigs is the entry point.

---

## Shared Responsibility Model

This concept appears on every cloud security certification and in every cloud security interview.

**The provider secures:** Physical infrastructure, hypervisor, network fabric, managed service availability.

**You secure:** Everything you put in the cloud — your data, your identity/access configurations, your network rules, your OS patches (for IaaS), your application code.

```
                    Responsibility
      Customer  │  Shared  │  Provider
─────────────────────────────────────────
Data            │          │
IAM / Access    │          │
Network config  │          │
OS patches      │          │ (depends: SaaS vs PaaS vs IaaS)
App code        │          │
                │ Platform │
                │          │  Physical hardware
                │          │  Hypervisor
                │          │  Global network
```

**Practical implication:** Enabling encryption is your job. Configuring MFA is your job. Setting a public S3 bucket is your mistake. AWS will not stop you from doing these things wrong — that's the shared part.

---

## AWS: Key Security Services

### IAM — Identity and Access Management
The most important AWS security service. Every action in AWS goes through IAM.

**Core components:**
- **Users:** Individual identities (avoid using root account — ever)
- **Groups:** Collections of users with shared permissions
- **Roles:** Temporary credentials assumed by services, EC2 instances, or external identities (no username/password)
- **Policies:** JSON documents defining what actions are allowed/denied on which resources

```json
// Example IAM policy: S3 read-only on a specific bucket
{
  "Version": "2012-10-17",
  "Statement": [{
    "Effect": "Allow",
    "Action": ["s3:GetObject", "s3:ListBucket"],
    "Resource": [
      "arn:aws:s3:::my-bucket",
      "arn:aws:s3:::my-bucket/*"
    ]
  }]
}
```

**Principle of least privilege:** Grant only what's needed. Most breaches come from over-permissioned roles. `AdministratorAccess` should never be assigned outside break-glass scenarios.

**Root account rules:**
1. Enable MFA immediately after account creation
2. Create an admin IAM user for daily use
3. Generate root access keys only if absolutely required — then delete them
4. Never use root for routine work

### S3 — Simple Storage Service
The #1 source of cloud data breaches. S3 is public internet-accessible by default when set public.

```bash
# Check if a bucket is public (AWS CLI)
aws s3api get-bucket-acl --bucket my-bucket
aws s3api get-bucket-policy-status --bucket my-bucket

# Block all public access (do this on every bucket unless it's a static website)
aws s3api put-public-access-block --bucket my-bucket \
    --public-access-block-configuration \
    "BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=true,RestrictPublicBuckets=true"
```

**S3 attack pattern:** Attacker discovers public bucket via Google dork (`site:s3.amazonaws.com`) or tool like `bucket-finder`. Downloads everything. Ransom note appears.

### VPC and Security Groups
**VPC (Virtual Private Cloud):** Your isolated network in AWS. Subnets, route tables, internet gateways.

**Security Groups:** Stateful firewalls attached to instances. Default: allow all outbound, deny all inbound.

```
# Dangerous: open to the world
Inbound: 0.0.0.0/0 → port 22 (SSH), port 3389 (RDP), port 5900 (VNC)

# Correct: restrict to your IP or corporate range
Inbound: 203.0.113.0/24 → port 22
```

**Common misconfiguration:** Security groups left open from development (`0.0.0.0/0` on any port). Use AWS Config rules to alert on this automatically.

### CloudTrail
Every API call in AWS logged to CloudTrail. Essential for forensics and compliance.

```bash
# Query CloudTrail logs for a specific event
aws cloudtrail lookup-events \
    --lookup-attributes AttributeKey=EventName,AttributeValue=CreateUser \
    --start-time 2026-01-01 --end-time 2026-04-15
```

**Enable:** CloudTrail → Create Trail → All regions, log to S3, enable CloudWatch Logs integration. Enable Log File Validation (detects tampering).

**Key events to alert on:**
- `ConsoleLogin` with MFA=No
- `CreateAccessKey` (especially for root)
- `DeleteTrail` / `StopLogging` (attacker covering tracks)
- `PutBucketPolicy` with public access
- `AssumeRoleWithWebIdentity` from unexpected sources

---

## Azure: Key Security Services

### Entra ID (formerly Azure Active Directory / AAD)
Microsoft's cloud identity platform. If your org uses O365, you're already using Entra ID.

**Key concepts:**
- **Tenant:** Your organization's isolated Azure AD instance
- **Users/Groups:** Same as on-prem AD but cloud-native
- **Service Principals:** Non-human identities (app registrations, managed identities)
- **Conditional Access:** Policies that enforce MFA, block untrusted locations, require compliant devices

**Security Defaults:** Enable this immediately on new tenants — forces MFA for all users, blocks legacy auth, protects privileged actions.

### RBAC — Role-Based Access Control
Azure RBAC controls who can do what in Azure resources (distinct from Entra ID roles, which control directory).

| Role | Can do |
|---|---|
| Owner | Everything including role assignment |
| Contributor | Create/manage resources, can't manage access |
| Reader | Read-only |
| Custom roles | Scoped to specific actions and resources |

**Principle:** Assign roles at the narrowest scope (resource > resource group > subscription).

### Network Security Groups (NSGs)
Azure's equivalent of AWS Security Groups. Stateful packet filter rules on subnets or NICs.

Same guidance as AWS Security Groups — never allow `0.0.0.0/0` on management ports.

### Microsoft Defender for Cloud (formerly Azure Security Center)
Cloud-native CSPM (Cloud Security Posture Management). Scans your Azure environment and scores it against security benchmarks.

Free tier gives you security recommendations. Paid tier adds threat detection.

### Microsoft Sentinel
Azure's cloud-native SIEM and SOAR. Ingests logs from Azure, O365, and any connected data source. Runs KQL (Kusto Query Language) queries for detection.

```kql
// Example: Find sign-ins from new countries
SigninLogs
| where TimeGenerated > ago(7d)
| summarize Countries=dcount(Location) by UserPrincipalName
| where Countries > 3
| order by Countries desc
```

---

## Top Cloud Misconfigurations

These are what penetration testers and attackers look for first:

### 1. Public S3 Buckets (AWS)
Exposed data to the internet. Check: AWS Console → S3 → Block Public Access settings.

### 2. No MFA on Root / Global Admin
One compromised credential = total account takeover. Always enforce MFA, especially on privileged accounts.

### 3. Over-permissive IAM Roles
EC2 instance with `AdministratorAccess` attached → any code running on that instance has full AWS access.

Audit: `aws iam get-account-authorization-details` → look for managed policies with `*` actions.

### 4. Open Security Groups / NSGs
Port 22 or 3389 open to `0.0.0.0/0`. Automated scanners find these within minutes of deployment.

### 5. No CloudTrail / Diagnostic Logging
Flying blind. Can't detect attacks, can't do forensics. Enable everything.

### 6. Publicly Accessible Metadata Service (SSRF → IMDS)
The EC2 metadata service at `http://169.254.169.254` exposes IAM credentials. If an attacker can make your application issue HTTP requests (SSRF), they can steal credentials.

Mitigation: Require IMDSv2 (requires a PUT token request — SSRF typically can't make PUT requests):
```bash
aws ec2 modify-instance-metadata-options \
    --instance-id i-1234567890 \
    --http-tokens required
```

---

## Cloud Attack Techniques (MITRE ATT&CK Cloud Matrix)

| Technique | What It Is |
|---|---|
| **T1552.005** — Cloud Instance Metadata API | SSRF to steal IAM credentials via metadata service |
| **T1078.004** — Valid Accounts: Cloud Accounts | Compromised cloud credentials used for access |
| **T1537** — Transfer Data to Cloud Account | Exfiltrate to attacker-controlled S3 bucket |
| **T1136.003** — Create Cloud Account | Attacker creates new IAM user/service principal for persistence |
| **T1580** — Cloud Infrastructure Discovery | Enumerate resources, IAM, and services after initial access |

---

## Free Tier Labs

Learn cloud security without paying:

| Platform | What You Get |
|---|---|
| **AWS Free Tier** | 12 months of limited free services (EC2 t2.micro, S3, Lambda, CloudTrail) |
| **Azure Free Account** | $200 credit for 30 days + 12 months of free services |
| **Google Cloud** | $300 credit valid for 90 days |
| **CloudGoat (Rhino Labs)** | Intentionally vulnerable AWS environment for practice |
| **flaws.cloud** | AWS CTF teaching real-world S3 and IAM vulnerabilities |
| **flaws2.cloud** | Attacker and defender perspective CTF |

Start with **flaws.cloud** — it's free, hands-on, and teaches the most common AWS vulnerabilities you'll encounter on the job.

---

## Tags
`[[Cloud]]` `[[AWS]]` `[[Azure]]` `[[Active Directory]]` `[[CySA+]]` `[[Incident Response]]` `[[IAM]]` `[[MITRE ATT&CK]]` `[[Misconfiguration]]`