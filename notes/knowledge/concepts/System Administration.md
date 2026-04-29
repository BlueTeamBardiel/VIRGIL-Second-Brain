# System Administration

## What it is
Like a building superintendent who holds master keys, controls the HVAC, and decides who gets access to which floors — a system administrator manages the infrastructure, accounts, and configurations that keep computing environments running. Precisely, system administration is the practice of configuring, maintaining, monitoring, and securing servers, endpoints, user accounts, and services within an organization's IT environment.

## Why it matters
In the 2020 SolarWinds breach, attackers compromised administrative credentials and abused legitimate sysadmin tools like PowerShell and WMI to move laterally — blending in with normal administrative activity for months undetected. Defenders countering this relied on privileged access management (PAM) and behavioral baselines to distinguish legitimate admin actions from attacker-controlled ones.

## Key facts
- **Principle of Least Privilege (PoLP):** Admins should hold only the permissions necessary for their specific role — separation of duties prevents a single compromised account from causing total damage
- **Hardening baselines:** CIS Benchmarks and STIG guidelines define secure configurations for OSes and applications, reducing attack surface before deployment
- **Patch management** is a core sysadmin responsibility — unpatched systems (e.g., EternalBlue/MS17-010) remain one of the most exploited attack vectors in real-world incidents
- **Administrative accounts should never be used for daily tasks** — dedicated privileged accounts reduce credential exposure to phishing and malware
- **Log collection and retention** (via syslog, Windows Event Logs) is a sysadmin function critical for forensic investigations and compliance with frameworks like PCI-DSS and HIPAA

## Related concepts
[[Privilege Escalation]] [[Patch Management]] [[Privileged Access Management]] [[Group Policy]] [[Hardening]]