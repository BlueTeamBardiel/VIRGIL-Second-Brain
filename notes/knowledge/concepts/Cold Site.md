# Cold Site

## What it is
Think of a cold site like an empty warehouse you own across town — the lights work and the address exists, but there's no furniture, no equipment, no staff. In disaster recovery, a cold site is a backup facility that provides only basic infrastructure (power, cooling, connectivity), requiring an organization to install and configure all hardware and software before operations can resume. It is the slowest recovery option but also the cheapest.

## Why it matters
When a ransomware attack takes down a regional hospital's primary data center, administrators may activate their cold site — but if they haven't tested provisioning procedures, days can pass before patient records and clinical systems come back online. This delay directly illustrates why RTO (Recovery Time Objective) must be measured honestly against the actual spin-up time a cold site demands, not an optimistic guess.

## Key facts
- **Recovery Time**: Cold sites typically require **days to weeks** to become operational — the longest RTO of any DR site type.
- **Cost**: Lowest upfront and ongoing cost among DR options (cold → warm → hot), making it attractive for budget-constrained organizations with low criticality systems.
- **No pre-installed equipment**: Unlike warm sites (partial hardware ready) or hot sites (fully mirrored, near-instant failover), cold sites ship in with nothing pre-staged.
- **Exam trap**: A cold site does NOT imply data is pre-loaded or synchronized — backups must be physically or electronically restored on-site after hardware is provisioned.
- **Best use case**: Appropriate for non-critical systems where extended downtime is tolerable and cost minimization is the priority.

## Related concepts
[[Hot Site]] [[Warm Site]] [[Recovery Time Objective]] [[Business Continuity Plan]] [[Disaster Recovery]]