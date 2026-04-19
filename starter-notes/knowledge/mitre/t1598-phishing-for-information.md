# T1598: Phishing for Information

Adversaries send phishing messages to elicit sensitive information for use during targeting. This reconnaissance technique aims to trick targets into divulging credentials or actionable data rather than executing malicious code.

## Overview
- **ID**: T1598
- **Tactic**: Reconnaissance
- **Platforms**: PRE (Pre-Compromise)
- **Created**: 02 October 2020
- **Last Modified**: 24 October 2025
- **Version**: 1.4

## Sub-techniques
- [[T1598.001]] - Spearphishing Service
- [[T1598.002]] - Spearphishing Attachment
- [[T1598.003]] - Spearphishing Link
- [[T1598.004]] - Spearphishing Voice

## Description

Phishing for information is electronically delivered [[social engineering]]. It differs from standard [[phishing]] in that the objective is data gathering rather than code execution.

Adversaries may:
- Conduct **targeted spearphishing** against specific individuals, companies, or industries
- Perform **mass credential harvesting** campaigns
- Obtain information via email, instant messages, or electronic conversation
- Direct victims to call phone numbers for credential collection
- Use [[Email Spoofing]] to fool recipients and automated security tools
- Apply evasive techniques like [[Email Hiding Rules]] to manipulate message metadata
- Employ social engineering (posing as authority, creating urgency)

## Threat Actors
- [[APT28]] - Spearphishing to compromise credentials
- [[Kimsuky]] - Tailored spearphishing for victim enumeration
- [[Moonstone Sleet]] - Email-based information gathering
- [[Scattered Spider]] - Credential phishing + OTP code capture
- [[ZIRCONIUM]] - Targeted campaign staff with credential phishing

## Mitigations
- **M1054 - Software Configuration**: Deploy [[SPF]], [[DKIM]], and [[DMARC]] for anti-spoofing and email authentication
- **M1017 - User Training**: Train users to identify social engineering and spearphishing attempts

## Tags
#reconnaissance #phishing #social-engineering #credential-harvesting #mitre-attack

---
_Ingested: 2026-04-15 20:48 | Source: https://attack.mitre.org/techniques/T1598/_
