# Google Cloud Platform

## What it is
Like renting space in a massive, shared office building where Google handles the locks, elevators, and fire suppression — but you're still responsible for who gets a key to your suite. Google Cloud Platform (GCP) is a suite of cloud computing services offering compute, storage, networking, and security capabilities hosted on Google's global infrastructure, consumed on a pay-as-you-go model.

## Why it matters
In 2020, attackers compromised GCP environments by exploiting misconfigured service accounts with overly permissive IAM roles, then used those accounts to mine cryptocurrency at the victim's expense — a pattern documented in Google's own Threat Horizons report. This highlights that misconfigured Identity and Access Management (IAM), not infrastructure vulnerabilities, is the dominant attack surface in GCP environments.

## Key facts
- **Shared Responsibility Model**: Google secures the underlying infrastructure; customers are responsible for data, IAM configurations, and application security
- **IAM and Service Accounts**: GCP uses service accounts (non-human identities) that, if over-privileged, become prime targets — the principle of least privilege is critical
- **Cloud Security Command Center (SCC)**: GCP's native SIEM-like tool for threat detection, vulnerability scanning, and compliance monitoring across GCP resources
- **VPC Service Controls**: Act as a security perimeter around GCP APIs, preventing data exfiltration even if credentials are compromised
- **Organization Policy Constraints**: Org-level controls that restrict what actions can be taken across all projects, enforcing guardrails like prohibiting public IPs or disabling service account key creation

## Related concepts
[[Identity and Access Management]] [[Shared Responsibility Model]] [[Cloud Security Posture Management]] [[Zero Trust Architecture]] [[Privilege Escalation]]