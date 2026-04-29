# Accountability

## What it is
Like a bank vault that logs every employee who opens it — not just *whether* it was opened, but *who*, *when*, and *why* — accountability is the security principle ensuring that every action in a system can be traced back to a specific, authenticated identity. It closes the loop between authentication and audit: you can't have accountability without first knowing *who* is acting.

## Why it matters
In the 2013 Edward Snowden breach, the NSA discovered that privileged insider access lacked sufficient accountability controls — logs existed but weren't actively monitored or tied tightly to individual identities. Had robust accountability been enforced (individual non-shared credentials, real-time log review, and user behavior analytics), anomalous bulk data access would have triggered alerts far earlier. Accountability transforms logs from passive records into active deterrents.

## Key facts
- Accountability depends on **non-repudiation** — a user cannot deny their actions if proper logging and identity binding are in place
- Shared accounts (e.g., generic "admin" logins) directly destroy accountability because actions cannot be attributed to a single individual
- Audit logs are the technical enforcement mechanism for accountability; they must be **write-once/tamper-evident** (e.g., WORM storage or SIEM forwarding) to be trustworthy
- On Security+, accountability is one of five pillars alongside **confidentiality, integrity, availability, and non-repudiation** — sometimes listed as a component of the AAA framework (Authentication, Authorization, **Accounting**)
- The **AAA framework** (RADIUS, TACACS+) implements accountability through the *accounting* function, recording session start/stop times, commands executed, and data transferred

## Related concepts
[[Non-Repudiation]] [[Audit Logs]] [[AAA Framework]] [[Least Privilege]] [[Insider Threat]]