# Group Policy

## What it is
Think of Group Policy like a school principal broadcasting rules over the intercom to every classroom simultaneously — no teacher needs to be told individually, and no student can opt out. Precisely: Group Policy is a Windows Active Directory feature that allows administrators to centrally define and enforce security configurations, software settings, and user restrictions across all machines and users in a domain through Group Policy Objects (GPOs).

## Why it matters
Attackers who compromise a Domain Controller can weaponize Group Policy to deploy malware across every domain-joined machine simultaneously — a technique used in the NotPetya attack to propagate destructive payloads at catastrophic speed. Defensively, hardening GPOs (disabling NTLM, enforcing SMB signing, blocking PowerShell execution) is one of the highest-leverage actions a blue team can take to reduce attack surface across an entire enterprise in a single change.

## Key facts
- GPOs are linked to **Sites, Domains, or Organizational Units (OUs)** and process in that order — SDOU — with later policies winning conflicts by default
- **Enforced (No Override)** GPOs cannot be blocked by child OUs, making them critical for non-negotiable security baselines
- Group Policy processes at **boot (computer settings)** and **login (user settings)**, with background refresh every ~90 minutes by default
- Attackers abuse **GPO delegation misconfigurations** — if a low-privileged user has write access to a GPO, they can achieve domain-wide code execution
- The `gpresult /R` command and **Resultant Set of Policy (RSoP)** tool are used to audit what policies are actually applied to a given machine

## Related concepts
[[Active Directory]] [[Organizational Units]] [[Privilege Escalation]] [[Lateral Movement]] [[Security Baselines]]