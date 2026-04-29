# Orphaned Permissions

## What it is
Like a hotel keycard that still works after the guest has checked out, orphaned permissions are access rights that remain active after the account, role, or relationship that justified them no longer exists. Precisely: orphaned permissions occur when user or service account privileges persist in a system after the associated identity has been disabled, deleted, or changed roles — creating unauthorized access pathways with no legitimate owner.

## Why it matters
When a system administrator leaves a company, their service account credentials may remain embedded in scripts, scheduled tasks, or third-party integrations — still holding elevated privileges. An attacker who discovers these dormant credentials can authenticate as a "ghost" identity that no one is actively monitoring, because the departed employee triggers no anomaly alerts and may never appear in access reviews.

## Key facts
- Orphaned permissions are a primary finding in **access control audits** and directly violate the principle of **least privilege**
- They most commonly appear after **employee offboarding failures**, mergers/acquisitions, or system migrations where account cleanup is skipped
- **User Access Reviews (UARs)** conducted quarterly or annually are the standard control to detect and remediate them
- Service accounts and **non-human identities (NHIs)** are especially prone to orphaning because no single human owner is responsible for decommissioning them
- On Security+/CySA+, orphaned permissions fall under **Identity and Access Management (IAM)** controls and are a key risk addressed by **account lifecycle management** policies

## Related concepts
[[Privilege Creep]] [[Least Privilege]] [[Account Lifecycle Management]] [[Identity and Access Management]] [[Service Accounts]]