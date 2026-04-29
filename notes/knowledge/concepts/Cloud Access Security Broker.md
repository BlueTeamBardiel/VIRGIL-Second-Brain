# Cloud Access Security Broker

## What it is
Think of a CASB like a strict embassy checkpoint between your employees and foreign territory — it inspects everyone crossing in both directions, enforces passport rules, and can turn away dangerous cargo. A Cloud Access Security Broker is a security policy enforcement point, either on-premises or cloud-hosted, that sits between enterprise users and cloud service providers to enforce security policies, visibility, compliance, and data protection.

## Why it matters
A healthcare employee uploads a spreadsheet containing 10,000 patient records to their personal Dropbox account — a classic shadow IT data exfiltration scenario. A CASB deployed in API mode detects the file transfer, identifies the PII via DLP inspection, blocks the upload, and alerts the security team — all before the data ever leaves the organization's control perimeter.

## Key facts
- CASBs operate in three deployment modes: **forward proxy** (inline, intercepts traffic), **reverse proxy** (agentless, redirects through CASB), and **API-based** (out-of-band, integrates directly with cloud provider APIs)
- The four pillars of CASB functionality are: **Visibility**, **Compliance**, **Data Security**, and **Threat Protection**
- CASBs are the primary control for managing **shadow IT** — unauthorized cloud apps used without IT approval (Gartner estimates 80% of employees use unapproved SaaS tools)
- API mode cannot block threats in real-time but provides deep inspection of data already at rest in cloud services like Office 365 or Salesforce
- CASBs enforce **UEBA** (User and Entity Behavior Analytics) to detect anomalies like a user downloading 5GB at 2AM

## Related concepts
[[Shadow IT]] [[Data Loss Prevention]] [[Zero Trust Architecture]] [[Cloud Security Posture Management]] [[Forward Proxy]]