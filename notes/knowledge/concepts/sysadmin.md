# sysadmin

## What it is
Like a building superintendent who holds master keys, controls the HVAC, and decides who gets elevator access — a sysadmin (system administrator) is the human responsible for configuring, maintaining, securing, and monitoring an organization's servers, networks, and endpoints. They sit at the intersection of operations and security, holding privileged access that makes them both essential and a high-value target.

## Why it matters
In the 2020 SolarWinds breach, attackers specifically targeted sysadmin credentials to move laterally across networks after the initial supply chain compromise — because whoever controls the sysadmin account controls the kingdom. Defenders must apply the principle of least privilege even to sysadmin roles, separating day-to-day user accounts from privileged administrative accounts (PAM) to limit blast radius when credentials are stolen.

## Key facts
- Sysadmins should use **separate accounts** for admin tasks vs. daily work — logging into email as Domain Admin violates least privilege and is a common attack vector
- **Privileged Access Workstations (PAWs)** are hardened machines dedicated solely to admin tasks, reducing exposure to malware that lives on general-use systems
- Sysadmin actions should be logged via **SIEM** and audited — insider threat detection depends on baselining normal admin behavior and flagging anomalies
- The **principle of separation of duties** means no single sysadmin should have unchecked authority over both making changes and approving them
- Sysadmin credentials are primary targets in **credential dumping attacks** (e.g., Mimikatz against LSASS) because they often have domain-wide reach

## Related concepts
[[Privilege Escalation]] [[Least Privilege]] [[Privileged Access Management]] [[Separation of Duties]] [[Insider Threat]]