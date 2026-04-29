# Identity Governance

## What it is
Think of it as the HR department for digital identities — just as HR tracks who has which job title, what building access they need, and fires people when they leave, Identity Governance tracks *who has access to what*, ensures that access is appropriate, and revokes it when circumstances change. Precisely: Identity Governance (IG) is the policy-driven framework for managing digital identities, enforcing least privilege, and providing auditable proof that access rights are appropriate and compliant.

## Why it matters
In the 2020 SolarWinds breach, attackers leveraged over-privileged service accounts that had accumulated unnecessary permissions over years — a textbook failure of access reviews and governance. A mature Identity Governance program with regular access certifications and role-based access controls would have minimized the blast radius by ensuring those accounts held only what they truly needed.

## Key facts
- **Access Certification (Recertification):** Periodic manager reviews confirming that users still need their current access — a core IG control often required by SOX, HIPAA, and PCI-DSS.
- **Role-Based Access Control (RBAC):** IG uses roles to assign permissions by job function rather than individually, reducing administrative sprawl and enforcing least privilege at scale.
- **Segregation of Duties (SoD):** IG enforces that no single user holds conflicting permissions (e.g., someone who can create vendors *cannot* also approve payments), preventing fraud.
- **Joiners/Movers/Leavers (JML):** A core IG lifecycle process — provisioning access when hired, adjusting it when roles change, and promptly deprovisioning when departing.
- **Orphaned Accounts:** Accounts with no active owner (common after terminations) are a high-risk finding; IG processes exist specifically to detect and remediate them.

## Related concepts
[[Identity and Access Management]] [[Least Privilege]] [[Privileged Access Management]] [[Role-Based Access Control]] [[Access Control Lists]]