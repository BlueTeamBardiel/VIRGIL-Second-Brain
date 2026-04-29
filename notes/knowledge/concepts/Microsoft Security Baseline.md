# Microsoft Security Baseline

## What it is
Think of it as a pre-seasoned cast iron pan — instead of building flavor from scratch every time, Microsoft has already done the hard work of figuring out the ideal configuration. Precisely: a Microsoft Security Baseline is a group of pre-configured Windows and application settings, documented and tested by Microsoft, that define a secure starting state for systems in an enterprise environment. These baselines are delivered via Group Policy Objects (GPOs) or Microsoft Intune and cover settings for OS hardening, account policies, Windows Defender, and more.

## Why it matters
During the SolarWinds supply chain attack, compromised environments were partly exploited because endpoints lacked consistent hardening — attackers moved laterally through machines with weak SMB configurations and legacy authentication enabled. Organizations that had deployed Microsoft Security Baselines with SMBv1 disabled and Credential Guard enforced significantly narrowed the attacker's lateral movement options, illustrating how baseline drift creates exploitable gaps.

## Key facts
- Security Baselines are distributed through the **Microsoft Security Compliance Toolkit (SCT)**, a free downloadable toolset that includes Policy Analyzer and LGPO utilities
- Baselines exist for **Windows 10/11, Windows Server, Microsoft Edge, Microsoft 365 Apps**, and Azure environments — each versioned separately
- They are **CIS Benchmark-aligned** in many areas but are distinct documents; the CIS benchmarks are often more restrictive
- **Baseline drift** — where systems deviate from the approved configuration over time — is the primary risk these tools are designed to detect and remediate
- In the **CySA+** exam context, Security Baselines are referenced under configuration management and vulnerability management as a proactive hardening control (not a detection tool)

## Related concepts
[[Group Policy Objects (GPO)]] [[CIS Benchmarks]] [[Configuration Management]] [[Hardening]] [[Microsoft Intune]]