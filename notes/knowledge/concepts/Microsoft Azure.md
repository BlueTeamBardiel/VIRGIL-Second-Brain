# Microsoft Azure

## What it is
Think of Azure like a city of skyscrapers you rent floors in — Microsoft owns the building's foundation, plumbing, and security guards at the lobby, but you're responsible for locking your own apartment. Azure is Microsoft's cloud computing platform offering IaaS, PaaS, and SaaS services across globally distributed data centers, enabling organizations to host workloads without owning physical infrastructure.

## Why it matters
In 2021, attackers exploited misconfigured Azure Blob Storage containers left publicly accessible, exposing sensitive data from thousands of organizations — no exploit required, just an open door left unlocked. Defenders use Azure Security Center (now Microsoft Defender for Cloud) to continuously assess misconfigurations, enforce least-privilege access via Azure RBAC, and detect anomalous identity behavior through Azure AD Identity Protection.

## Key facts
- **Shared Responsibility Model**: Microsoft secures the physical infrastructure and hypervisor; the customer is responsible for data, identities, access controls, and OS patching (in IaaS scenarios).
- **Azure Active Directory (Entra ID)** is the identity backbone — compromising it via password spray or token theft gives attackers lateral movement across all Azure-connected resources.
- **Azure Security Benchmark** maps controls to NIST and CIS frameworks, making it exam-relevant for compliance-based security questions.
- **Managed Identities** eliminate hardcoded credentials by allowing Azure resources to authenticate to other services automatically — a key defense against credential exposure.
- **Microsoft Defender for Cloud** assigns a **Secure Score** to your Azure environment, quantifying your posture and prioritizing remediation — a common CySA+ topic.

## Related concepts
[[Cloud Security]] [[Shared Responsibility Model]] [[Identity and Access Management]] [[Azure Active Directory]] [[Misconfiguration Vulnerabilities]]