# User Off-boarding

## What it is
Like revoking a hotel keycard the moment a guest checks out — not the next day, not when housekeeping gets around to it — user off-boarding is the immediate, systematic revocation of all access rights when an employee or contractor leaves an organization. It encompasses disabling accounts, retrieving physical assets, revoking certificates, and transferring data ownership before departure.

## Why it matters
In 2020, a former Cisco engineer logged into his old AWS account — never disabled after his resignation — and deleted 456 virtual machines, causing $2.4 million in damages. Had off-boarding revoked his cloud credentials on his last day, the access vector simply wouldn't have existed. This is the canonical example of why "orphaned accounts" are a critical threat surface.

## Key facts
- **Immediate disable, not delete**: Accounts should be disabled first to preserve forensic data and allow mailbox transfer; deletion is a separate, later step
- **Privileged accounts first**: Admin and service accounts require priority revocation — former employees with elevated privileges pose disproportionate insider threat risk
- **Exit interviews + access audits**: Both should happen simultaneously; access logs from the final 30 days should be reviewed for data exfiltration indicators
- **Third-party and federated access**: OAuth tokens, API keys, and SSO sessions granted to personal devices or SaaS apps must be explicitly revoked — disabling the AD account alone may not terminate these sessions
- **Documented in policy**: Security+ expects off-boarding to be a formal, auditable procedure within HR and IT policy frameworks, not an ad-hoc process

## Related concepts
[[Least Privilege]] [[Identity and Access Management]] [[Insider Threat]] [[Account Management]] [[Separation of Duties]]