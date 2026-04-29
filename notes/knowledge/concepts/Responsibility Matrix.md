# Responsibility Matrix

## What it is
Like a restaurant where the owner provides the kitchen but the chef is responsible for what gets cooked in it — a Responsibility Matrix (often called a RACI or Shared Responsibility Model) precisely documents which party owns, manages, or is accountable for each security control in a system or environment. It defines who is Responsible, Accountable, Consulted, and Informed for every security task or asset.

## Why it matters
In a 2020 cloud breach, a company assumed their AWS provider was patching the OS on EC2 instances — AWS assumed the customer was. Neither did it. A clear Responsibility Matrix would have explicitly assigned OS patching to the customer under AWS's Shared Responsibility Model, preventing the gap that attackers exploited through an unpatched vulnerability.

## Key facts
- **RACI breakdown**: Responsible = does the work; Accountable = owns the outcome; Consulted = provides input; Informed = kept in the loop — only ONE accountable party per task
- **Cloud context**: AWS, Azure, and GCP all publish Shared Responsibility Models — cloud providers own security *of* the cloud (hardware, hypervisor); customers own security *in* the cloud (data, IAM, OS configuration)
- **Third-party risk**: Responsibility Matrices are embedded in vendor contracts and SLAs to legally enforce who handles incident response, patch management, and data protection
- **Compliance relevance**: NIST CSF, ISO 27001, and SOC 2 auditors examine responsibility documentation to verify controls are assigned and not assumed
- **Common exam trap**: "Shared responsibility" does not mean equal responsibility — the split varies by service model (IaaS vs. PaaS vs. SaaS), with SaaS shifting the most responsibility to the provider

## Related concepts
[[Shared Responsibility Model]] [[Third-Party Risk Management]] [[Cloud Security Controls]] [[SLA (Service Level Agreement)]] [[Data Ownership]]