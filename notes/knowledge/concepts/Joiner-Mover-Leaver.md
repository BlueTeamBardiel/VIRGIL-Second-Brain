# Joiner-Mover-Leaver

## What it is
Think of it like a hotel key card system: when a guest checks in, they get access; when they move to a different room, their card is reprogrammed; when they check out, the card is deactivated. Joiner-Mover-Leaver (JML) is an identity lifecycle management framework that governs how user accounts and access rights are provisioned, modified, and revoked as employees join an organization, change roles internally, or depart.

## Why it matters
A 2020 breach at a major financial firm traced back to a developer who had moved to a non-technical HR role but retained full production database access for 14 months — a textbook "Mover" failure. Attackers who compromised that account gained database privileges far beyond what an HR employee should ever hold, demonstrating how failure at any JML stage creates persistent, exploitable privilege accumulation.

## Key facts
- **Joiner**: New accounts must follow least-privilege provisioning; access should be role-based and granted only after HR confirmation, not on day one by default.
- **Mover**: Role changes require both *granting* new access AND *revoking* old access simultaneously — failing the revocation step causes **privilege creep**.
- **Leaver**: Accounts must be disabled (not just password-changed) immediately upon departure; shared credentials or service accounts tied to individuals are a common gap.
- **Access Reviews** (recertification campaigns) are the detective control that catches JML failures — typically run quarterly or annually.
- Failure to manage the Leaver phase violates compliance frameworks including **SOX, HIPAA, and ISO 27001**, all of which mandate timely access revocation.

## Related concepts
[[Privilege Creep]] [[Least Privilege]] [[Identity and Access Management]] [[Access Reviews]] [[Separation of Duties]]