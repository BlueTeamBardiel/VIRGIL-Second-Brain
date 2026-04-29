# AWS Cloud Security Overview

AWS cloud security encompasses the practices, technologies, and services that protect data, applications, and infrastructure in cloud environments. This note covers foundational cloud security concepts and AWS's approach to securing cloud deployments.

## What Is It? (Feynman Version)

Imagine a digital fortress that sits on a giant, shared island. AWS Cloud Security is the set of guards, walls, and keys that keep your data and applications safe while you let the island host millions of other fortresses.  
*Definition*: AWS Cloud Security is the collection of practices, technologies, and services that protect data, applications, and infrastructure in AWS cloud environments.

## Why Does It Exist?

Before cloud, every company ran its own servers and had to build security from scratch. A single mis‑configured firewall or forgotten patch could expose an entire customer base to attackers. The cloud changed the game: the infrastructure is elastic, globally distributed, and shared, but the responsibilities split. The main problem it solves is the “one‑size‑fits‑all” misconfigurations that lead to data leaks and compliance failures.  
Real scenario: In 2017, a major retailer suffered a breach because an S3 bucket was left publicly readable. The loss of customer data, a damaged brand, and regulatory fines showcased why layered, managed security is essential. AWS Cloud Security offers a defense-in-depth stack so that a single lapse does not expose everything.

## How It Works (Under The Hood)

1. **Identity & Access**  
   - A user logs in with a password and optionally an MFA token.  
   - AWS IAM evaluates an attached policy, evaluates the request, and issues a short‑lived access token (JWT‑like).  
   - That token is presented to every service; each service verifies the signature and checks its own resource‑level policies.

2. **Network Isolation**  
   - Each VPC is a virtual datacenter with its own CIDR block.  
   - Security groups act as stateful packet filters, while network ACLs provide stateless per‑subnet control.  
   - Traffic can be routed via private endpoints, bypassing the public internet.

3. **Data Protection**  
   - Data at rest in services such as EBS, RDS, or S3 is encrypted automatically with keys from KMS.  
   - Data in transit uses TLS 1.2+; endpoints are validated via certificates.  
   - Key rotation and audit logs are recorded in CloudTrail.

4. **Threat Detection & Response**  
   - CloudTrail logs every API call.  
   - GuardDuty analyzes logs, network flow, and DNS queries for malicious patterns.  
   - Security Hub aggregates findings; automated Lambda functions can patch or isolate compromised resources.

5. **Compliance & Governance**  
   - AWS Artifact provides compliance reports; Config Rules enforce policy compliance in real time.  
   - IAM Access Analyzer discovers exposed resources.  
   - Audit logs are immutable when stored in S3 with versioning and cross‑region replication.

## What Breaks When It Goes Wrong?

When misconfiguration slips through, the fallout is immediate and wide:

- **First Notice**: Automated alerts (GuardDuty, Config) or manual audits.  
- **What Fails**: Public exposure of S3 buckets, open inbound ports on EC2, or revoked MFA leading to credential theft.  
- **Blast Radius**: A single leaked key can give an attacker read/write access to all services that rely on it. The attacker can exfiltrate data, inject ransomware, or pivot into on‑prem networks.  
- **Human Cost**: Hundreds of customers affected, regulatory fines, reputational damage, and the need for costly incident response and remediation.

---

## Key Concepts

- **Cloud Security**: Protection of data, applications, and infrastructure deployed in [[cloud computing]] environments
- **Shared Responsibility Model**: Division of security obligations between [[AWS]] and the customer
- **Defense in Depth**: Layered security controls across network, application, and data levels

## Core Security Areas

### Identity & Access Management
- User authentication and authorization
- [[IAM]] (Identity and Access Management) policies
- Multi-factor authentication (MFA)

### Data Protection
- Encryption at rest and in transit
- Key management services
- Data classification and handling

### Network Security
- Virtual Private Cloud ([[VPC]]) isolation
- Security groups and network ACLs
- DDoS protection

### Compliance & Governance
- Regulatory compliance frameworks
- Audit logging and monitoring
- Security posture assessment

### Threat Detection & Response
- Real‑time threat monitoring
- Incident response procedures
- Security automation

## AWS Security Resources
- [[AWS Trust Center]]: Compliance and security information
- AWS Security Best Practices documentation
- AWS security certifications and training

## Tags
#AWS #cloud-security #security #cloud-computing

---  
_Ingested: 2026-04-15 20:23 | Source: https://aws.amazon.com/what-is/cloud-security/_