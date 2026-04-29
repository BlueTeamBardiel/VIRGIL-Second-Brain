# internal controls

## What it is
Think of internal controls like the checks built into a nuclear launch sequence — no single person can fire the missile alone, every action is logged, and multiple keys must turn simultaneously. In cybersecurity, internal controls are the policies, procedures, and technical mechanisms an organization implements to protect assets, ensure data integrity, prevent fraud, and enforce compliance. They operate proactively (preventing bad outcomes) and reactively (detecting and correcting them when they occur).

## Why it matters
In 2016, attackers who compromised Bangladesh Bank exploited weak internal controls — specifically, the absence of proper separation of duties and inadequate transaction monitoring — to issue fraudulent SWIFT transfers totaling $81 million. Strong internal controls, such as dual authorization for large transfers and real-time anomaly alerts, would have flagged or blocked the transactions before funds left the country.

## Key facts
- **Three categories:** Preventive (stop incidents before they happen), Detective (identify incidents in progress or after), and Corrective (remediate damage after detection)
- **Separation of duties (SoD)** is a core internal control — no single employee should be able to initiate *and* approve a financial transaction or system change
- **Mandatory vacation / job rotation** forces employees to hand off duties, exposing fraud or errors that a continuously present insider could conceal
- **Least privilege** limits user access rights to only what is needed for their role, reducing the blast radius of insider threats or compromised accounts
- Internal controls are required by compliance frameworks including **SOX (Sarbanes-Oxley)**, **PCI-DSS**, and **HIPAA**, making them a direct audit concern

## Related concepts
[[separation of duties]] [[least privilege]] [[defense in depth]] [[access control]] [[audit logging]]