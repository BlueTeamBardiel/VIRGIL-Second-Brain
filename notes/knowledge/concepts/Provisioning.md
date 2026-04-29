# Provisioning

## What it is
Like a hotel front desk handing you a keycard programmed with exactly which floors and rooms you're allowed to access — then deactivating it at checkout — provisioning is the formal process of creating, configuring, and granting access rights to user accounts, systems, or services. It encompasses the entire lifecycle: setup, maintenance, and eventual deprovisioning when access is no longer needed.

## Why it matters
In 2020, the SolarWinds supply chain attack exploited overly permissive provisioning: compromised service accounts had been granted broad network privileges far beyond what their function required. Attackers leveraged these accounts to move laterally across victim networks undetected for months. Proper least-privilege provisioning would have dramatically limited the blast radius.

## Key facts
- **Provisioning vs. Deprovisioning**: Failing to deprovision accounts when employees leave creates orphaned accounts — a leading vector for insider threats and credential abuse
- **Over-provisioning** violates the principle of least privilege and is a common audit finding; users accumulate permissions over time in a pattern called **privilege creep**
- **Automated provisioning** via Identity Governance and Administration (IGA) tools or directory services (e.g., Active Directory, LDAP) reduces human error and speeds joiner/mover/leaver workflows
- **Just-in-Time (JIT) provisioning** grants access only when needed and revokes it immediately after, minimizing persistent privilege exposure — common in PAM (Privileged Access Management) solutions
- On Security+/CySA+ exams, provisioning questions often connect to **identity lifecycle management**, **access reviews**, and **separation of duties**

## Related concepts
[[Identity and Access Management]] [[Least Privilege]] [[Privilege Creep]] [[Deprovisioning]] [[Privileged Access Management]]