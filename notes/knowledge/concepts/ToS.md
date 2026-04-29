# ToS

## What it is
Like the fine print on a rental car agreement that lets the company GPS-track you — Terms of Service are legal contracts users accept (often without reading) that define what a platform can do with your data and activity. Precisely: ToS agreements establish the legal framework governing user behavior, data collection rights, and liability limitations between a service provider and its users. They are enforceable contracts that can significantly impact both user privacy and organizational security posture.

## Why it matters
During a 2014 breach investigation, researchers discovered that a gaming company's ToS explicitly permitted them to share "anonymized" user data with third parties — data that was later re-identified and used in a credential stuffing campaign against corporate accounts where employees reused passwords. Security analysts must review vendor ToS agreements as part of third-party risk assessments, since clauses around data retention, breach notification timelines, and subprocessor sharing can directly affect incident response obligations.

## Key facts
- ToS violations can constitute unauthorized access under the **Computer Fraud and Abuse Act (CFAA)** — U.S. v. Drew (2008) tested this when a user created a fake MySpace account
- In cloud environments, ToS defines the **shared responsibility model** — clarifying which security controls the vendor owns vs. the customer
- ToS agreements often specify **breach notification windows** that may conflict with GDPR's 72-hour mandatory reporting requirement
- Security researchers must check ToS before conducting **bug bounty or penetration testing** — unauthorized testing is illegal even on your own data
- Shadow IT often creates ToS compliance gaps — employees using unapproved SaaS tools may bind the organization to unknown **data sovereignty clauses**

## Related concepts
[[Shared Responsibility Model]] [[Third-Party Risk Management]] [[Data Privacy Regulations]] [[Computer Fraud and Abuse Act]] [[Shadow IT]]