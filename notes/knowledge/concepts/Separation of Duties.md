# Separation of Duties

## What it is
Like a bank vault that requires two employees with different keys present simultaneously to open it, no single person can act alone and abuse the system. Separation of Duties (SoD) is a security control that divides critical tasks among multiple people so that completing a sensitive action requires collusion between at least two individuals, making fraud or abuse significantly harder to execute and easier to detect.

## Why it matters
In 2011, a UBS rogue trader named Kweku Adoboli lost $2.3 billion partly because he had accumulated roles that let him both execute trades and book fictitious hedges in the back-office system — a textbook SoD failure. Had trade execution and trade recording been held by separate individuals, his unauthorized positions would have been flagged immediately rather than hidden for years.

## Key facts
- **Two-person integrity** is a specific implementation of SoD requiring two authorized individuals physically present to perform a sensitive operation (e.g., nuclear launch, evidence handling)
- SoD directly counters **insider threats** by ensuring no single employee can initiate, approve, and complete a high-risk transaction alone
- In IT, classic SoD examples include separating the roles of **developer**, **code reviewer**, and **deployment approver** in a CI/CD pipeline
- SoD violations are a top finding in **SOX compliance audits** — regulators specifically check that financial approval and payment roles are not held by the same person
- SoD differs from **least privilege**: least privilege limits *what* a user can access; SoD limits *how much of a process* one user can control end-to-end

## Related concepts
[[Least Privilege]] [[Need to Know]] [[Two-Person Integrity]] [[Job Rotation]] [[Mandatory Access Control]]