# Off-boarding

## What it is
Like revoking a hotel key card the moment a guest checks out — not the next day, not when it's convenient — off-boarding is the formal, security-driven process of terminating an employee's access to all organizational systems, accounts, and physical spaces upon their departure. It encompasses credential revocation, device recovery, data transfer, and exit interviews to ensure no residual access remains.

## Why it matters
In 2020, a former Cisco engineer accessed the company's AWS infrastructure *five months* after resignation and deleted 456 virtual machines, causing $2.4 million in damages — a textbook failure of off-boarding. Proper off-boarding would have disabled his cloud credentials the day his employment ended, closing that window entirely.

## Key facts
- **Immediate account disablement** is the priority: Active Directory accounts, VPN credentials, email, SaaS apps (Salesforce, Slack, GitHub) must be disabled — not deleted — on the last day of employment
- **Disable before delete**: Accounts are disabled first to preserve audit logs and forensic evidence; deletion removes that trail
- **Data ownership transfer**: Files, email archives, and project assets must be migrated to a manager or successor before account deletion
- **Hardware return** must include laptops, mobile devices, tokens, and badge access — each logged with serial numbers in a formal checklist
- **Exit interviews + NDA reminders** are procedural controls that reinforce legal obligations around confidential data and trade secrets
- Privileged accounts (admin, root, service accounts) require **immediate revocation** and password rotation for any shared credentials the departing employee knew

## Related concepts
[[Identity and Access Management]] [[Principle of Least Privilege]] [[Insider Threat]] [[Access Control Lists]] [[Account Management]]