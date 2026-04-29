# Data Custodian

## What it is
Like a bank vault manager who didn't decide what goes in the vault but is responsible for keeping the locks working and the logs accurate — a Data Custodian is the technical steward of data owned by someone else. They implement security controls, maintain storage systems, and enforce access policies defined by the Data Owner, without having authority over the data's purpose or classification.

## Why it matters
In a ransomware investigation, forensic responders often find that backups failed silently for months — the Data Owner (a department head) assumed IT was verifying restore integrity, while the sysadmin assumed the automated job was sufficient. This accountability gap is precisely the Data Custodian's failure: they are responsible for ensuring backup systems function, testing restores, and alerting when controls break down. Defining this role explicitly prevents "assumed secure" disasters.

## Key facts
- The **Data Owner** classifies data and defines policy; the **Data Custodian** implements and maintains the technical controls that enforce it.
- Common custodian responsibilities include: backup management, access control implementation, patch management, and audit log maintenance.
- The Data Custodian role is typically filled by IT/sysadmin staff, NOT executives or business unit managers.
- On Security+ exams, if a question asks *who is responsible for ensuring data backups run correctly*, the answer is the **Data Custodian**, not the Data Owner.
- Data Custodians do **not** approve access requests — they execute approved access changes as directed by the Data Owner or through a formal IAM process.

## Related concepts
[[Data Owner]] [[Data Classification]] [[Separation of Duties]] [[Identity and Access Management]] [[Least Privilege]]