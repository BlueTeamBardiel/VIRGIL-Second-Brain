# data retention policy

## What it is
Like a restaurant deciding how long to keep receipts before shredding them — long enough for tax audits, short enough to avoid clutter — a data retention policy defines exactly how long an organization must store specific types of data before it must be deleted or archived. It balances legal compliance, operational need, and risk exposure into a formal, enforceable schedule.

## Why it matters
In 2017, Equifax retained sensitive PII far beyond operational necessity with no clear destruction schedule, meaning that when attackers breached their systems, 147 million records were exposed that arguably shouldn't have existed anymore. A properly enforced retention policy with scheduled destruction would have reduced the blast radius of the breach significantly. This is why "data minimization" is now a core principle in regulations like GDPR.

## Key facts
- **Legal hold** (also called litigation hold) overrides normal retention schedules — data subject to active legal proceedings must be preserved even if it's past its destruction date
- HIPAA mandates medical records be retained for **6 years** from creation or last use; violating this can trigger civil and criminal penalties
- Data retention and data destruction are two sides of the same policy — you must define both *how long* to keep data and *how* to securely dispose of it (e.g., DoD 5220.22-M wiping standards)
- GDPR's **right to erasure** (Article 17) means retention policies must include mechanisms for honoring deletion requests, or organizations face fines up to 4% of global annual turnover
- Retention policies are classified by **data type** (financial, HR, PII, logs) — security logs are commonly retained for **90 days to 1 year** to support incident investigation

## Related concepts
[[data classification]] [[data destruction]] [[legal hold]] [[GDPR compliance]] [[information lifecycle management]]